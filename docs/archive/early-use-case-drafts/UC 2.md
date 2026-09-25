USE CASE 2: View Credit Summary

Primary Actor:Student

Supporting Actor:Academic Staff


Goal:The student wants to view a summary of the credits they have completed towards their program.

Preconditions

-The student has a registered academic record.
-The student's programme is recorded in the system.
-The student's completed modules and their credit values are available.
-The student has successfully authenticated.

Postconditions

-The system calculates the student's completed credits.
-The system displays the student's completed credit total.
-The system displays the modules contributing to the completed credit total.


-The system cannot retrieve the student's academic record.
-The system informs the student that the credit summary cannot currently be displayed.

Main Success Flow

-The student logs into the system.
-The student selects the option to view their credit summary.
-The system retrieves the student's academic record.
-The system identifies the modules completed by the student.
-The system retrieves the credit value for each completed module.-The system calculates the student's total completed credits.
-The system displays the completed credit total to the student.
-The system displays the completed modules and their associated credits.

Alternative Flows

1.Academic Record Cannot Be Retrieved
-The student requests their credit summary.
-The system attempts to retrieve the student's academic record.
-The academic record cannot be retrieved.
-The system displays an appropriate error message.
-The system informs the student that the credit summary cannot currently be displayed.

2.No Completed Modules

-The system retrieves the student's academic record.
-The system determines that the student has no completed modules recorded.
-The system displays a completed credit total of zero.
- The system informs the student that no completed modules are currently recorded.

3.Incomplete Academic Record

-The system retrieves the student's academic record.
-The system identifies missing or incomplete academic information.
-The system calculates the credit total using the valid recorded information.
-The system informs the student that some academic information may be missing.
-The system recommends that the student contact academic staff to verify the record.
.
