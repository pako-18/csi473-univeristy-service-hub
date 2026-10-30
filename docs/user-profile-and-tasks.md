# User Profile and Task Scenarios

## 1. Primary user profile
**Who:** A University of Botswana student who has finished their programme and needs official proof that they passed all academic requirements.

**Why they need it:** To prove completion to a third party which could be job related or if the student wants to continue their studies.

**Devices and comfort:** Mostly a smartphone, or any device they can get access to, such as a campus computer or a friend's laptop. They are not assumed to be technical. Students may not always have data or their own phone, which is why the system must work on any device. 

**Pain today:** Getting a completion letter involves going back and forth with staff, and every step depends on a person acting. This is slow and tedious. For example, on day of collection a certain important staff member may be unavailable to assist due to absence or just staff negligence. 

## 2. Primary task scenario
A student has just finished their final exams and needs a completion letter. They sign in on their phone and request one. The system checks their academic record automatically. If they meet every requirement, the letter is issued straight away and they are told by email or notification. If they do not, they see exactly which requirements are still outstanding. At no point do they need to visit the registry or wait for a person.

## 3. Success criteria
- The student can request a letter from the dashboard in no more than 5 steps on a phone.
- The student gets a result (the letter, or a list of outstanding requirements) within 5 minutes with no human involved.
- The student receives an email or notification stating their completion status.

## 4. Secondary task (academic staff)
**User:** An academic staff member who needs to confirm that a student has completed all the modules required for their programme, for example when a student asks why their letter was not issued.

**Scenario:** A student contacts the department because they have not received a completion letter. The staff member signs in and enters the student's ID. The system retrieves the student's academic record and compares it with the requirements of their programme. The staff member then sees the student's completion status, and either that the student is eligible or a list of the requirements still outstanding. The staff member can then tell the student exactly what is missing, without searching through records by hand.

**Success criteria:**
- When the student is found, the staff member sees their completion status and either "eligible" or the list of outstanding requirements.
- When the student is not found, a clear error message says that no student matches the ID entered.
- When the records system is unavailable, a message says the records are temporarily unavailable and to try again later, and no status is guessed or shown.

## 5. Links to requirements

| Task | Requirements | Use cases | Quality concern |
|---|---|---|---|
| Student requests a completion letter | FR-01 (sign-in), FR-02 (retrieve record), FR-07 (itemise outstanding requirements), FR-08 (eligibility without manual input), FR-12 (email delivery) | UC-01, UC-02, UC-03, UC-10 | Usability: QS-1 (status within 3 seconds), QS-5 (letter generation), QS-6 (request effort); Accessibility: QS-7 (works on any device and browser) |
| Academic staff check a student's status | FR-01, FR-02, FR-03 (credits earned), FR-04 to FR-06 (checks), FR-07 | UC-01, UC-03, UC-09, UC-10 | Security: QS-3 (unauthorised access); Usability: QS-6 (request effort); Accessibility: QS-7 (works on any device and browser) |

## 6. Exit record (Lab 10)
- **Most important usability problem:** in the usability test on 30 October 2026, a tester asked to find what was missing on the "Not yet eligible" screen could not see the list of outstanding requirements. The list was small and unlabelled, and the only prominent button was "Back to dashboard" (see `evidence/usability-test.md`, Task B).
- **Interface change made:** the banner now states how many requirements are outstanding, a heading "What you still need:" sits above the list, and the list is larger, numbered and boxed. Requirements already met are shown separately (see `prototype/wireframes-student.html`).
- **How it will be verified after implementation:** ask at least two people who have not seen the design to reach the "not eligible" screen and say what they still need. Each must name every outstanding item without help, within the limits in QS-6.
