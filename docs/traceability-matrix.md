# Traceability Matrix

Requirement to use case to analysis element to planned verification.

Requirement IDs refer to `requirements.md` (FR-01 to FR-15). Use case IDs refer
to `use-cases.md` (UC-01 to UC-11). Analysis elements are classes and
responsibilities in `models/domain-model.mmd` and `docs/crc-cards.md`.

| FR | Requirement (abbreviated) | Use case | Analysis element | Planned verification |
|---|---|---|---|---|
| FR-01 | Authenticate students and staff with role-based access | UC-01 | Student, RegistryOfficer | Sign-in test with valid, invalid and unauthorised-role credentials |
| FR-02 | Retrieve a student's academic record | UC-03, UC-09 | Enrolment — knows Student and Programme; holds CourseResult | Retrieval test against a seeded record; failure path per UC-03 A2 |
| FR-03 | Calculate total credits earned | UC-09 | Enrolment — `calculateCreditsEarned()` | Unit test: total equals sum of completed CourseResult credits |
| FR-04 | Compare earned credits against programme requirement | UC-03 | CompletionCheck; CompletionRequirement — `isSatisfiedBy()` | Unit test with above, equal to, and below threshold |
| FR-05 | Check compulsory modules are complete | UC-03 | CompletionRequirement — mandatory flag | Unit test: missing compulsory module yields not satisfied |
| FR-06 | Check elective requirements are met | UC-03 | CompletionRequirement — required credits | Unit test at elective threshold boundary |
| FR-07 | Itemise outstanding requirements | UC-10 | CompletionCheck — records unmet requirements individually | Test: response lists each unmet item, not a single flag |
| FR-08 | Derive eligibility status without manual input | UC-03 | CompletionCheck — `determineOutcome()` | Integration test: outcome produced with no staff action |
| FR-09 | Authorised staff update academic results | UC-11 | Enrolment — accepts updates from authorised staff only | Test with authorised and unauthorised users per UC-11 A2 |
| FR-10 | Staff approve or reject, with timestamp | UC-05 | ApprovalDecision — decision, decidedOn, reason, RegistryOfficer | Test both outcomes; assert decision persists after rejection |
| FR-11 | Generate letter on approval | UC-06 | CompletionLetter; LetterTemplate | Test: letter produced only after approving ApprovalDecision |
| FR-12 | Deliver letter to institutional email | UC-02, UC-06 | CompletionLetter — delivery; LetterRequest state Delivered | Test delivery confirmation and the DeliveryFailed retry path |
| FR-13 | Unique verification code bound to each letter | UC-06 | VerificationCode — composed by CompletionLetter | Test: codes unique across letters; code inseparable from letter |
| FR-14 | External party verifies a letter by code | UC-07 | VerificationCode; VerificationRequest | Test valid, revoked and unknown codes per UC-07 A2 |
| FR-15 | Audit trail of approvals, issuance and verification | UC-05, UC-06, UC-07 | AuditEntry | Test: entry written for each of the three actions, with actor |

## Coverage notes

Every requirement FR-01 to FR-15 maps to at least one use case, one analysis
element and one planned verification.

UC-04 (Confirm Student Clearance) does not appear in this matrix. No requirement
covers financial clearance, and the project scope excludes tuition fee
calculation. This is recorded as an open item in `use-cases.md` and in Section 11
of the Phase 1 report.

UC-08 (Track Request Status) has no requirement of its own. It is satisfied by
the request history that FR-10 and FR-12 make possible, but a requirement should
be added if it is to be assessed independently.

FR-15 requires `AuditEntry` to record approvals, letter generation and
verification attempts. The domain model currently associates `AuditEntry` only
with `LetterRequest`, so the associations from `ApprovalDecision`,
`CompletionLetter` and `VerificationCode` are outstanding.
