USE CASE 1: Check Student Completion Status

Primary Actor-Student
Supporting Actor-Academic Staff

Goal-The student wants to know whether they have completed all the required credits and programme requirements for graduation.

PRECONDITIONS
-The student has a registered academic record.
-The student's programme requirements are available in the system.
-The student has successfully authenticated.

POST CONDITIONS
-The student's completed credits have been calculated.
-The student's completion status has been determined.
-Any outstanding credits or modules have been identified.
-If  reqrements are satisfied, the student is identified as eligible for a completion letter.

MAIN SUCCESS FLOW
The student logs into the system.

 The student requests their completion status.

The system retrieves the student's academic record.

-The system calculates the student's completed credits.
The system retrieves the requirements for the student's programme.

The system compares the student's completed credits with the required credits.

The system checks whether all required modules have been completed.

The system determines the student's completion status.

Th ystem displays the completion status to the student.

Alternative Flows

1.Student Has Outstanding Credits

-The system calculates the student's completed credits.
- The system determines that the student has not completed the required number of credits.
-The system identifies the outstanding credits.
-The system identifies any outstanding modules.
-The system displays the outstanding requirements to the student.
-The system marks the student as incomplete.
-The system does not generate a completion letter.

2.Student Has Outstanding Required Modules

-The system determines that the student's completed credits meet the required total.
-The system checks the required modules.
-The system determines that one or more required modules have not been completed.
-The system identifies the outstanding modules.-The system displays the outstanding modules to the student.
-The system marks the student as incomplete.
-The system does not generate a completion letter.

3.Academic Record Cannot Be Retrieved

-The system attempts to retrieve the student's academic record.
-The academic record cannot be retrieved.
-The system displays an appropriate error message.
-The system informs the student that their completion status cannot currently be calculated.
-The system does not generate a completion letter.

4.All Requirements Completed

-The system confirms that the student has completed all required credits.
-The system confirms that all required modules have been completed.
-The system marks the student as eligible for completion.
-The system generates the student's completion letter.
-The system makes the completion letter available to the student.