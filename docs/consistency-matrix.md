# Consistency Matrix

Links each step of the core workflow across the use case, the interaction model,
the responsibility allocation, the lifecycle model and the requirements. Its
purpose is to expose places where the artefacts disagree.

Sources: `use-cases.md`, `models/sequence-core-use-case.mmd`,
`docs/crc-cards.md`, `models/lifecycle-letter-request.mmd`, `requirements.md`.

## UC-02 — Request Completion Letter

| Step | Use case step | Sequence message | Responsibility (CRC) | LetterRequest state | FR |
|---|---|---|---|---|---|
| 1 | Student submits a request | `submitRequest(purpose)` | LetterRequest — knows reference, date, purpose, status | Submitted | FR-01 (authenticated), UC-08 history |
| 2 | System validates record is active | `performCheck(enrolment)` | LetterRequest — triggers CompletionCheck | UnderVerification | FR-02 |
| 3 | System checks completion status | `getCompletedResults()`, `calculateCreditsEarned()`, `isSatisfiedBy()` | Enrolment — calculates credits; CompletionRequirement — states satisfaction | UnderVerification | FR-03, FR-04, FR-05, FR-06 |
| 3a | Outcome determined | `determineOutcome()` | CompletionCheck — derives outcome, records unmet items | AwaitingApproval or Refused | FR-07, FR-08 |
| 4 | Registry Officer reviews and approves | `approve(reason)` | ApprovalDecision — knows decision, date, reason, officer | AwaitingApproval → Approved | FR-09, FR-10 |
| 5 | System generates letter with code | `generate()`, `applyTemplate()`, `create()` | CompletionLetter — owns VerificationCode; LetterTemplate | LetterIssued | FR-11, FR-13 |
| 6 | Student is notified letter is available | `deliverToInstitutionalEmail()` | CompletionLetter — delivery | Delivered | FR-12 |

## Alternative flows

| Flow | Use case | Sequence branch | Lifecycle state | FR |
|---|---|---|---|---|
| A3 incomplete academic record | UC-02 A3 | `else outcome = Not Eligible` | Refused | FR-07, FR-08 |
| A2 record unavailable | UC-03 A2 | *(not modelled — see gaps)* | VerificationFailed | FR-02 |
| A3 rejection by officer | UC-05 A3 | `recordRefusal(reason)` | Refused | FR-10 |
| A2 unknown code | UC-07 A2 | *(not modelled)* | *(not applicable)* | FR-14 |

## Inconsistencies identified

**C-01 — Financial clearance has no requirement, responsibility or state.**
Step 4 of UC-02 and the whole of UC-04 depend on a clearance check. No FR covers
it, no class in the domain model performs it, and the lifecycle model has no
state for a held request. The scope statement excludes tuition fee calculation.
*Resolution required: add FR-16 and the supporting analysis elements, or remove
step 4, UC-04 and the Finance Clearance participant.*
**Status: RESOLVED (Phase 1 review, F-01).** UC-04 withdrawn; step 4 and A4
removed from UC-02; the table above now has six steps.

**C-02 — Audit associations are missing from the domain model.**
FR-15 requires approvals, letter generation and verification attempts to be
audited, and the sequence diagram shows `AuditEntry` being written from
`ApprovalDecision`, `CompletionLetter` and `VerificationCode`. The domain model
associates `AuditEntry` only with `LetterRequest`.
*Resolution: add the three associations, or centralise audit writing on
`LetterRequest`.*
**Status: RESOLVED (Phase 1 review, F-03).** Associations added from
`ApprovalDecision`, `CompletionLetter` and `VerificationRequest` to `AuditEntry`.

**C-03 — CRC card vocabulary does not match the domain model.**
The committed cards use `Academic Record`, `Module Result`, `Academic Staff` and
`Programme Requirement`; the domain model uses `Enrolment`, `CourseResult`,
`RegistryOfficer` and `CompletionRequirement`. Messages in the sequence diagram
therefore have no matching responsibility for most classes.
*Resolution: adopt the domain model vocabulary across the cards, and add cards
for `LetterRequest`, `ApprovalDecision`, `CompletionCheck` and
`VerificationCode`.*
**Status: RESOLVED (Phase 1 review).** Cards use domain-model names; cards added
for `ApprovalDecision`, `RegistryOfficer`, `VerificationCode` and `AuditEntry`.

**C-04 — UC-08 has no requirement.**
Track Request Status is modelled and supported by the request history that
Decision 1 in `decisions/D-002.md` makes possible, but no FR states it.
*Resolution: add a requirement, or fold the behaviour into FR-12.*

**C-05 — Two verification-side alternative flows are unmodelled.**
UC-07 A2 (unknown code) and UC-03 A2 (record unavailable) have no representation
in the sequence diagram. UC-03 A2 does appear in the lifecycle model as
`VerificationFailed`, so the two behavioural models disagree with each other.
*Resolution: extend the sequence diagram, or note the scope of the diagram
explicitly as the main flow of UC-02 only.*
**Status: RESOLVED by scoping (Phase 1 review).** The Phase 1 report §9.3 now
states that the sequence diagram covers UC-02 and its A2/A3/A5 branches only;
UC-03 A2 is covered by the lifecycle state `VerificationFailed`.

**C-06: FR-09 mis-traced (found in Phase 1 review, F-02).**
The traceability matrix described FR-09 as "staff update academic results"
(UC-11), but `requirements.md` defines FR-09 as staff reviewing a completion
assessment. **Status: RESOLVED.** FR-09 now traces to UC-05. UC-11 is recorded
as having no requirement (FR-16 proposed for Phase 2).
