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
