# Data integrity, traceability and exit record

**Project:** Student Completion Verification and Digital Letter Issuance System
**Laboratory:** 8
**Related:** `models/logical-data-model.mmd`, `docs/api-contracts/core-operation.md`, `models/deployment.mmd`, `models/failure-recovery.mmd`, `decisions/ADR-001-architecture.md`

## 1. Integrity constraints

| ID | Rule | Where it is enforced | Protects |
|---|---|---|---|
| IC-1 | A request has at most one check, one decision and one letter | UNIQUE `reference_number` on `COMPLETION_CHECK`, `APPROVAL_DECISION`, `COMPLETION_LETTER` | No duplicate decision or letter (D1) |
| IC-2 | Sending the same submit twice creates one request | UNIQUE (`student_number`, `idempotency_key`) on `LETTER_REQUEST`; the API returns the stored result | Duplicate requests |
| IC-3 | Decision, check results, letter, verification code, outbox row and audit entries are saved together | Transaction 2 in the API contract, section 5 | No partial state (D1) |
| IC-4 | Letters, codes, decisions and audit rows are never deleted or changed | No delete path in the application, ON DELETE RESTRICT, no UPDATE or DELETE permission on audit; revoking sets a flag | Authenticity and audit trail (D2, FR-14, FR-15) |
| IC-5 | One random verification code per letter | UNIQUE `letter_number` on `VERIFICATION_CODE` | FR-13 |
| IC-6 | One outbox row per letter, claimed by one worker at a time | UNIQUE `letter_number` on `EMAIL_OUTBOX` plus a row lock | No double sending |
| IC-7 | Status values are limited to the lifecycle states | CHECK on `LETTER_REQUEST.status` and `EMAIL_OUTBOX.status` | No invalid states |
| IC-8 | The credit total is never stored | Calculated from `COURSE_RESULT`; a check stores only per-requirement results | QS-2 |
| IC-9 | The issued letter text is saved exactly as issued | `rendered_body` on `COMPLETION_LETTER` | Authenticity if the record changes later |
| IC-10 | Every audit entry points to at least one subject | CHECK that one of the four foreign keys on `AUDIT_ENTRY` is set | Audit completeness |
| IC-11 | A student can only request for themselves | The student number comes from the login session, never the request body | Access control (D2) |

## 2. Traceability

| Artefact | File | Traces to |
|---|---|---|
| Logical data model | `models/logical-data-model.mmd` and `.pdf` | Domain model, D-002 Decisions 1 to 4, FR-04 to FR-08, FR-11 to FR-15, QS-2 |
| API contract | `docs/api-contracts/core-operation.md` | UC-02, FR-04 to FR-08, FR-11 to FR-13, FR-15, QS-5, Business Rules 1 to 5 |
| Deployment | `models/deployment.mmd` and `.pdf` | ADR-001 (D1, D2, D3, C1, C2), QS-3, QS-4 |
| Failure and recovery | `models/failure-recovery.mmd` and `.pdf` | ADR-001 Risk 2, QS-5, FR-12, lifecycle states LetterIssued, Delivered, DeliveryFailed |

## 3. Design rationale

**Data model.** Choice: application data lives in one relational database, and academic records are read through the adapter and referenced by ID. Alternative: copy the academic records into our database so real foreign keys can be used. Consequence accepted: there is no database foreign key across that boundary, so we save snapshots (`required_value`, `achieved_value`, `rendered_body`) and check references in the adapter.

**API contract.** See section 6 of the contract: a synchronous request, with only email delivery asynchronous.

**Deployment.** Choice: two identical application nodes behind a load balancer and one database with backups. Alternative: a database replica with automatic failover. Consequence accepted: the database is still a single point of failure (ADR-001 Risk 1). We cover it with backups and a tested restore, not with failover.

**Failure and recovery.** Choice: save the letter first and email it from an outbox with retries. Alternative: send the email inside the request and fail the request if the email fails. Consequence accepted: an email may be sent twice if a worker crashes after the email server accepts it but before the database update is saved. This is harmless, because it is the same letter and the same code.

## 4. Cross-check

| Check | Result |
|---|---|
| API statuses exist in the lifecycle model and the data model | Yes (Submitted, UnderVerification, VerificationFailed, Refused, LetterIssued, Delivered, DeliveryFailed, Cancelled) |
| API error outcomes match what is stored | Yes |
| Deployment matches ADR-001 and the component architecture | Yes (two nodes, load balancer, one database, adapter, outbox, public route in the same application) |
| Failure flow uses columns that exist | Yes (`status`, `attempts`, `next_attempt_at`, `last_error` on `EMAIL_OUTBOX`) |
| Gaps found | The letter text was not stored, and the data model drew foreign keys across the external boundary. Both were revised, see section 5 |

## 5. Revision after cross-check

Commit `538e7e6`. Before: the issued letter text was not stored, and links to the academic record tables looked like database foreign keys. After: `COMPLETION_LETTER.rendered_body` and `CHECK_REQUIREMENT_RESULT.required_value` were added, and a note says those links are references by ID only because the record source is external.

## 6. Differences from the domain model and open items

- Automatic issuance (ADR-001): `ApprovalDecision` no longer links to `RegistryOfficer`. `RegistryOfficer` is kept only to revoke letters.
- Added: `institutional_email`, `idempotency_key`, `EMAIL_OUTBOX`, `CHECK_REQUIREMENT_RESULT`, `course_code` on requirements, `rendered_body`, `required_value`.
- **Open item:** `models/domain-model.mmd`, `models/lifecycle-letter-request.mmd` and `models/sequence-core-use-case.mmd` still show officer approval (AwaitingApproval, Approved). They must be aligned to automatic issuance.
- **Open item:** there is no API yet for staff to resend an email whose delivery failed.

## 7. Exit record

**Risk:** an eligible student gets a letter but the email is lost, delayed or sent twice, because the email server is down or a worker crashes.

**Mechanism:** the letter, code, outbox row and audit entry are saved in one transaction before any email is tried. An outbox worker retries with a row lock, and `UNIQUE letter_number` on `EMAIL_OUTBOX` allows only one outbox row per letter. After the retry limit the row becomes FAILED and the request DeliveryFailed.

**Test:**
1. Stop the email server and submit an eligible request. Expect `201`, a letter and verification code saved, and the outbox row PENDING.
2. Start the email server again. Expect exactly one email, the outbox row SENT and the request Delivered.
3. Run two workers at once. Expect still only one email.
4. Stop a worker right after the email server accepts the message. Expect at most one duplicate email, and the letter unchanged.
