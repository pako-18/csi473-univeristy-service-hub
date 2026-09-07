# Functional Requirements — Student Completion Verification and Digital Letter Issuance System

| ID | Requirement Description | Acceptance Criteria |
|---|---|---|
| FR-01 | The system shall authenticate authorised users (students, staff) before granting access. | Login rejects invalid credentials; valid credentials grant role-based access (student vs staff). |
| FR-02 | The system shall retrieve and display a student's academic record. | Given a valid student ID, the system returns modules taken, grades, and credits within 5 seconds. |
| FR-03 | The system shall calculate total credits earned by a student. | Sum of credits matches manual calculation for a test record with ≥95% accuracy. |
| FR-04 | The system shall compare a student's earned credits against their programme's total credit requirement. | System correctly flags "met" or "not met" for at least 3 test programme profiles. |
| FR-05 | The system shall check whether all compulsory modules for the programme have been completed. | System lists any missing compulsory module(s) if incomplete; returns "complete" if none missing. |
| FR-06 | The system shall check whether elective requirements (e.g. minimum elective credits) have been satisfied. | System correctly validates elective credit thresholds against at least 2 test cases. |
| FR-07 | The system shall identify and list any outstanding requirements preventing completion. | Output includes a specific, itemised list (not a generic pass/fail) of unmet requirements. |
| FR-08 | The system shall determine a preliminary completion eligibility status based on FR-03 to FR-07. | Status ("Eligible" / "Not Eligible") is generated automatically without manual staff input. |
| FR-09 | The system shall allow authorised staff to review a student's completion assessment results. | Staff role can open and view full assessment detail (credits, modules, eligibility) for a given student. |
| FR-10 | The system shall allow authorised staff to approve or reject a completion assessment. | Staff action updates the record status to "Approved" or "Rejected" and is timestamped. |
| FR-11 | The system shall generate a Letter of Completion upon staff approval. | A formatted letter document (PDF) is produced containing student name, programme, and completion date. |
| FR-12 | The system shall send the approved letter to the student's institutional email address. | Email is dispatched within a defined time window (e.g. 5 minutes) and delivery is logged. |
| FR-13 | The system shall generate a unique verification code for each issued letter. | Each code is unique, non-sequential/guessable, and permanently linked to that letter record. |
| FR-14 | The system shall allow an external party to verify a letter using the verification code. | Entering a valid code returns letter authenticity + key details; invalid codes return "not found." |
| FR-15 | The system shall record important system actions (approvals, letter generation, verification attempts) in an audit trail. | Each logged action includes timestamp, user/actor, and action type; log is read-only to non-admins. |