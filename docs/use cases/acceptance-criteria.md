Acceptance Criteria 1 — Student Has Completed All Requirements

Given a student has completed all required credits and all required programme modules,

When the student requests their completion status,

Then the system shall mark the student as eligible for completion.

### Acceptance Criteria 2- Student Has Outstanding Requirements

**Given** a student has outstanding credits or required modules,

**When** the student requests their completion status,

**Then** the system shall mark the student as incomplete and display the outstanding requirements.

### Acceptance Criteria 3 — Completion Letter

**Given** a student has satisfied all required credits and programme requirements,

**When** the system confirms that the student is eligible for completion,

**Then** the system shall generate the student's completion letter and make it available to the student.

### Acceptance Criteria 4 — Academic Record Unavailable

**Given** the student's academic record cannot be retrieved,

**When** the student requests their completion status,

**Then** the system shall display an appropriate error message and shall not generate a completion letter.