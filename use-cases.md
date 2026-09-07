# Use Cases
Student Completion Verification and Digital Letter Issuance System

## UC-01: Authenticate User

**Primary actor:** Student
**Precondition:** User has a registered account.
**Postcondition:** User is signed in, or access is refused.

**Main flow**
1. User submits credentials.
2. System validates the credentials against the user record.
3. System grants access to the request portal.

**Alternative flow A2 - invalid credentials**
- At step 2, if validation fails, the system refuses access and records the attempt.

## UC-02: Request Completion Letter

**Primary actor:** Student
**Supporting actors:** Registry Officer, Finance Officer
**Precondition:** Student is authenticated and has an active record.
**Postcondition:** A signed digital letter is issued, or the request is rejected with a stated reason.

**Main flow**
1. Student submits a request for a completion letter.
2. System validates the student record is active.
3. System checks academic completion status.
4. System checks financial clearance.
5. Registry Officer reviews and approves the request.
6. System generates the letter with a verification code.
7. System notifies the Student that the letter is available.

**Alternative flow A3 - incomplete academic record**
- At step 3, if outstanding results exist, the system rejects the request and records the reason. Student is notified.

**Alternative flow A4 - outstanding financial obligation**
- At step 4, if clearance fails, the request is held and the Student is notified of the outstanding item.

## UC-03: Verify Completion Status

**Primary actor:** System
**Supporting actor:** Faculty Officer
**Precondition:** A letter request exists for the student.
**Postcondition:** Completion status is recorded against the request.

**Main flow**
1. System retrieves the student academic record.
2. System checks all required credits are met.
3. System checks no results are outstanding.
4. System records the completion outcome on the request.

**Alternative flow A2 - record unavailable**
- At step 1, if the record cannot be retrieved, the request is flagged for manual review by the Faculty Officer.

## UC-04: Confirm Student Clearance

**Primary actor:** Finance Officer
**Precondition:** Completion status has been confirmed.
**Postcondition:** Clearance is granted or the request is held.

**Main flow**
1. System submits the student for clearance checking.
2. Finance Officer reviews outstanding obligations.
3. Finance Officer records the clearance decision.

**Alternative flow A2 - outstanding balance**
- At step 2, if obligations exist, clearance is refused and the reason is recorded.

## UC-05: Approve or Reject Letter Request

**Primary actor:** Registry Officer
**Precondition:** Completion and clearance checks are complete.
**Postcondition:** The request is approved or rejected with a reason.

**Main flow**
1. Registry Officer opens the pending request.
2. Registry Officer reviews the verification results.
3. Registry Officer approves the request.
4. System records the approval and the approving officer.

**Alternative flow A3 - rejection**
- At step 3, the Registry Officer rejects the request and records a reason. The Student is notified.

## UC-06: Generate and Issue Digital Letter

**Primary actor:** System
**Precondition:** The request has been approved.
**Postcondition:** A signed letter with a verification code is available to the Student.

**Main flow**
1. System selects the appropriate letter template.
2. System populates the template with the student and completion details.
3. System applies a digital signature.
4. System generates a unique verification code.
5. System makes the letter available to the Student.

## UC-07: Verify Letter Authenticity

**Primary actor:** External Verifier
**Precondition:** A letter has been issued.
**Postcondition:** The verifier is shown whether the letter is valid.

**Main flow**
1. External Verifier submits a verification code.
2. System looks up the code against issued letters.
3. System displays the issuing date and validity status.

**Alternative flow A2 - unknown code**
- At step 2, if no match is found, the system reports that no valid letter exists for that code.

## UC-08: Track Request Status

**Primary actor:** Student
**Precondition:** The student has submitted at least one request.
**Postcondition:** The current status of each request is displayed.

**Main flow**
1. Student opens the request history.
2. System retrieves all requests for the student.
3. System displays each request with its current status and date.
