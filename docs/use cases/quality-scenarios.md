Quality Scenarios

## Student Credit Completion System

### Quality Scenario 1 — Completion Status Response Time

**Stimulus:**  
A student requests their completion status.

**Context:**  
The system is operating under normal expected usage and the student's academic record is available.

**Expected Response:**  
The system calculates the student's completed credits, checks the programme requirements, and displays the student's completion status.

**Response Measure:**  
The completion status should be displayed within 3 seconds of the student's request.

### Quality Scenario 2 — Credit Calculation Accuracy

**Stimulus:**  
A student requests their completed credit total.

**Context:**  
The student's academic record contains valid completed modules and their assigned credit values.

**Expected Response:**  
The system calculates the total number of completed credits using the student's completed modules.

**Response Measure:**  
The calculated credit total shall exactly match the sum of the credits assigned to the student's completed modules.

### Quality Scenario-003 — Unauthorised Access

**Stimulus:**  
An unauthorised user attempts to access a student's academic record.

**Context:**  
The user has not been authenticated or does not have permission to access the student's record.

**Expected Response:**  
The system denies access to the student's academic record and completion information.

**Response Measure:**  
The system shall display no protected student academic information to the unauthorised user.

### Quality Scenario 4 — System Availability

**Stimulus:**  
A student attempts to access the Student Credit Completion System.

**Context:**  
The request occurs during the university's scheduled operating hours.

**Expected Response:**  
The system allows the student to access the completion-status functionality.

**Response Measure:**  
The system should be available at least 99% of the time during scheduled operating hours.

### Quality Scenario 5 — Completion Letter Generation Reliability

**Stimulus:**  
A student who has satisfied all programme requirements requests their completion status.

**Context:**  
The student's academic record and programme requirements are available and valid.

**Expected Response:**  
The system confirms the student's completion status and generates the completion letter.

**Response Measure:**  
The system should successfully generate the completion letter for at least 99% of valid completion requests.