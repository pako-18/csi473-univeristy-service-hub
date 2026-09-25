USE CASE5: Update Academic Record


Primary Actor:Academic Staff

Supporting Actor:Student

Goal:Academic staff want to update a student's academic record with accurate module results and credit information so that the student's completion status can be calculated correctly

## Preconditions

1. The academic staff member is authorised to update academic records.
2. The student has a registered academic record.
3. The relevant module and programme information is available.
4. The academic staff member has successfully authenticated.

## Postconditions

1.The student's academic record contains the updated information.
2.he updated module and credit information is available for completion calculations.
3.The student's completion status can be recalculated using the updated information.
5.Invalid information is not saved.
6.The system informs academic staff of the validation error.
7.The student's previous valid academic record remains unchanged.

## Main Success Scenario

1. Academic staff log into the system.
2. Academic staff select the student whose record needs to be updated.
3. The system retrieves the student's academic record.
4. Academic staff enter or update the relevant academic information.
5. The system validates the entered information.
6. The system confirms that the information is valid.
7. The system saves the updated academic record.
8. The system confirms that the academic record has been successfully updated.
9. The updated information becomes available for credit and completion calculations.

## Alternative Flows

### A1 — Student Record Cannot Be Found

1. Academic staff search for the student's academic record.
2. The system cannot find the student's record.
3. The system displays an appropriate error message.
4. The system does not create or modify a record.

### A2 — Invalid Academic Information

1. Academic staff enter academic information.
2. The system validates the information.
3. The system identifies invalid or incomplete information.
4. The system displays the validation error.
5. Academic staff correct the information.
6. The system validates the corrected information again.

### A3 — Unauthorised User

1. A user attempts to update a student's academic record.
2. The system checks the user's permissions.
3. The system determines that the user is not authorised.
4. The system denies the update request.
5. The system does not modify the student's academic record.

### A4 — Update Cannot Be Saved

1. Academic staff enter valid academic information.
2. The system validates the information successfully.
3. The system attempts to save the updated record.
4. The update cannot be saved.
5. The system displays an appropriate error message.
6. The system informs academic staff that the record was not updated.
