# Quality Scenarios

## Student Completion Verification and Digital Letter Issuance System

### QS-1 — Completion Status Response Time

**Stimulus:**  
A student requests their completion status.

**Context:**  
The system is operating under normal expected usage and the student's academic record is available.

**Expected Response:**  
The system calculates the student's completed credits, checks the programme requirements, and displays the student's completion status.

**Response Measure:**  
The completion status should be displayed within 3 seconds of the student's request.

### QS-2 — Credit Calculation Accuracy

**Stimulus:**  
A student requests their completed credit total.

**Context:**  
The student's academic record contains valid completed modules and their assigned credit values.

**Expected Response:**  
The system calculates the total number of completed credits using the student's completed modules.

**Response Measure:**  
The calculated credit total shall exactly match the sum of the credits assigned to the student's completed modules.

### QS-3 — Unauthorised Access

**Stimulus:**  
An unauthorised user attempts to access a student's academic record.

**Context:**  
The user has not been authenticated or does not have permission to access the student's record.

**Expected Response:**  
The system denies access to the student's academic record and completion information.

**Response Measure:**  
The system shall display no protected student academic information to the unauthorised user.

### QS-4 — System Availability

**Stimulus:**  
A student attempts to access the system.

**Context:**  
The request occurs during the university's scheduled operating hours.

**Expected Response:**  
The system allows the student to access the completion-status functionality.

**Response Measure:**  
The system should be available at least 99% of the time during scheduled operating hours.

### QS-5 — Completion Letter Generation Reliability

**Stimulus:**  
A student who has satisfied all programme requirements requests their completion status.

**Context:**  
The student's academic record and programme requirements are available and valid.

**Expected Response:**  
The system confirms the student's completion status and generates the completion letter.

**Response Measure:**  
The system should successfully generate the completion letter for at least 99% of valid completion requests.

### QS-6 — Request Effort (Usability)

**Stimulus:**
A student wants to request a completion letter.

**Context:**
The student is signed in and uses a phone.

**Expected Response:**
The system lets the student request the letter and see the result, either the letter or the list of outstanding requirements.

**Response Measure:**
The student can complete the request in no more than 5 steps from the dashboard, and sees the result within 5 minutes with no human involved.

### QS-7 — Access on Any Device (Accessibility)

**Stimulus:**
A student uses a phone, a shared campus computer or another person's laptop to reach the system.

**Context:**
The device has a standard web browser and may use the keyboard only, or have a slow connection.

**Expected Response:**
Every critical task works with the keyboard, visible focus, persistent labels, clear error messages and non-colour cues, and without installing an app.

**Response Measure:**
All items in `docs/accessibility-checklist.md` pass for the critical screens.
