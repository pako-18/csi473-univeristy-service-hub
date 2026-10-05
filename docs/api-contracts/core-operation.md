# API contract: Request completion letter

**Project:** Student Completion Verification and Digital Letter Issuance System
**Laboratory:** 8
**Operation:** `POST /api/letter-requests` (UC-02; FR-04 to FR-08, FR-11 to FR-13, FR-15; QS-5)
**Related:** `decisions/ADR-001-architecture.md`, `models/logical-data-model.mmd`

## 1. Request

Caller: a logged-in student. The student number comes from the login session, never from the request body.

Header:
- `Idempotency-Key`: a UUID the client creates once per submit and reuses on every retry of that submit.

Body:

    { "purpose": "Application for postgraduate study" }

| Input | Rule |
|---|---|
| purpose | required, text, 3 to 200 characters after trimming |
| Idempotency-Key | required, valid UUID |

## 2. Rules applied, in order

1. The caller must be logged in with the student role (the single access check in Identity).
2. The input must pass the validation above.
3. The student must have an `ACTIVE` enrolment.
4. Credits are calculated from `COURSE_RESULT`. Only completed, valid results count (Rule 4).
5. The student is eligible only if the credit total meets the programme requirement and every compulsory module is completed (Rules 1 to 3).
6. If eligible, the system decides automatically and issues the letter. There is no officer approval step (ADR-001).

## 3. Success response

`201 Created` the first time. `200 OK` with header `Idempotent-Replay: true` if the same key is sent again.

    {
      "referenceNumber": "LR-2026-000123",
      "status": "LetterIssued",
      "letter": {
        "letterNumber": "CL-2026-000045",
        "issuedOn": "2026-10-05",
        "validUntil": "2027-10-05",
        "verificationCode": "A7K2-93QF-LM48"
      },
      "delivery": { "status": "PENDING" }
    }

Email is sent afterwards from the outbox, so `delivery.status` starts as `PENDING` and the request status later becomes `Delivered`.

## 4. Error outcomes

Every error has the same shape. The `code` values are stable and never change meaning.

    { "error": { "code": "NOT_ELIGIBLE", "message": "...", "referenceNumber": "LR-2026-000124", "details": [] } }

| HTTP | code | When | Stored request status | Retry? |
|---|---|---|---|---|
| 400 | VALIDATION_FAILED | purpose missing or outside 3 to 200 characters, or Idempotency-Key missing or not a UUID | nothing stored | yes, after fixing the input |
| 401 | UNAUTHENTICATED | no valid login session | nothing stored | after logging in |
| 403 | FORBIDDEN | caller is not a student | nothing stored | no |
| 409 | IDEMPOTENCY_KEY_REUSED | same key sent with a different purpose | unchanged | use a new key |
| 422 | ENROLMENT_NOT_ACTIVE | no active enrolment (A2) | Refused | after the record is corrected (UC-11) |
| 422 | NOT_ELIGIBLE | credits or compulsory modules missing (A3) | Refused, decision REJECTED | after the record is corrected (UC-11) |
| 503 | RECORD_SOURCE_UNAVAILABLE | the Academic Record Adapter timed out or failed | VerificationFailed | yes, same key |
| 500 | INTERNAL_ERROR | unexpected failure, the transaction is rolled back | no letter, code, outbox row, decision or audit entry saved | yes, same key |

For `NOT_ELIGIBLE`, `details` lists every unmet requirement with `requirementId`, `description`, `required` and `achieved`, so the student sees exactly what is outstanding (Rule 5).

A resubmission after a corrected record is a new request: new Idempotency-Key, new reference number (D-002 Decision 1).

## 5. Processing and transaction boundary

1. **Transaction 1:** save the `LETTER_REQUEST` as `Submitted` with its idempotency key, and commit. A repeat of the same key finds this row and returns the stored result, so no second request is created.
2. Read the academic record through the Academic Record Adapter. This is an external call, so it sits outside any database transaction. Status is `UnderVerification`.
3. **Transaction 2, all or nothing:** save the check and its requirement results, the decision, and, if eligible, the letter, verification code and outbox row. Save the audit entries and update the request status.
4. If step 2 fails, the status becomes `VerificationFailed` and the response is 503. Retrying with the same key resumes the same request until the retry limit in the lifecycle model, then it becomes `Cancelled`.
5. If transaction 2 fails, everything in it is rolled back. A retry with the same key resumes the same request.

## 6. Design rationale

**Choice:** the call is synchronous. The student waits for the decision and gets the letter details in the same response. Only email delivery is asynchronous, through the outbox.

**Alternative:** fully asynchronous. The API returns `202 Accepted` and the student polls for the result.

**Consequence accepted:** the request depends on the record source answering in time (QS-1, 3 seconds). A slow source gives `503`. We accept this because volume is a few thousand requests a year, and the student gets an immediate, itemised answer.