# UI States - Lab 10

Alternative states for the Student and Academic staff screens of the Completion Letter system. Screen names match `models/navigation.mmd` and the wireframes in `prototype/`.

Linked to: FR-01 (sign-in and roles), FR-02 (retrieve record), FR-07 (itemised outstanding requirements), UC-03 alternative flow (records unavailable), QS-1 (response time), QS-3 (unauthorised access), QS-4 (availability), QS-6 (usability) and QS-7 (accessibility).

**Rules for every message**
- Say what happened and what the user can do next.
- Use an icon and words, never colour alone (for example, "✖ Error:" or "✔ Done:").
- Error and status messages sit next to the thing they describe, are announced to screen readers, and move keyboard focus to the first field that needs fixing.
- When the records system is down, the system never guesses or shows an old status as current. Any stale data is labelled with the time it was last updated.

## 1. Student screens

| Screen | Loading | Empty | Validation | Error | Unauthorised | Unavailable / stale / offline |
|---|---|---|---|---|---|---|
| **Sign in** (step 1) | Button shows "Signing in..." and is disabled. | Both fields blank, with labels "Student ID" and "Password" always visible. | Blank ID: "Enter your Student ID." Blank password: "Enter your password." Shown under the field, focus moves to it. | "Student ID or password is incorrect. Please check and try again." | Expired session: "Your session has expired. Please sign in again." | System down: "The system is unavailable. Please try again later." Offline: "You appear to be offline. Check your connection and try again." |
| **Dashboard** (step 2) | "Loading your details..." | No requests yet: "You have not requested a letter yet." | No input on this screen. | "We could not load your details." with a Try again button. | Not signed in: redirected to Sign in. No student data is shown. | Records unavailable: programme and credits show "Not available right now". If older data is shown, it is labelled "Last updated [date and time]". |
| **Request completion letter** (step 3) | "Checking your record..." Button disabled, announced to screen readers. | Not applicable: one action, no list. | Not applicable: no input. | "Something went wrong. Your request was not submitted. Please try again." | Expired session: redirected to Sign in with the session message. | Records unavailable (UC-03 alternative flow): "Your academic records are temporarily unavailable. No letter has been issued. Please try again later." |
| **Letter ready** (step 4, eligible) | "Preparing your letter..." | Not applicable: this screen only appears when a letter exists. | Not applicable. | "The letter could not be prepared. Please try again. If this continues, contact the registry." | Opening another student's letter: "You do not have access to this page." No letter data shown. | Email still queued: "Your letter is ready. The email copy will follow shortly." |
| **Outstanding requirements** (step 4, not eligible) | "Checking your requirements..." | Not applicable: an empty list would mean the student is eligible. | Not applicable. | "We could not list your requirements. Please try again." | Same as Letter ready. | Same as Request completion letter. |

## 2. Academic staff screens

| Screen | Loading | Empty | Validation | Error | Unauthorised | Unavailable / stale / offline |
|---|---|---|---|---|---|---|
| **Sign in** | Same as student Sign in. | Same. | Same. | Same. | Same. | Same. |
| **Student lookup** | "Looking up student..." Button disabled. | On arrival: "Enter a student ID to see their completion status." | Blank ID: "Enter a student ID." Wrong format: "Student ID must contain digits only." Shown under the field with an icon, focus returns to the field. | ID not found: "✖ No student found with ID [ID]. Check the ID and try again." Other failure: "Something went wrong. Please try again." | A student opening this page: "You do not have permission to view this page." No student data is shown (QS-3). | Records unavailable: "Student records are temporarily unavailable. Please try again later." No status is shown or guessed. Offline: "You appear to be offline." |
| **Result** (eligible) | "Checking requirements..." | Student has no recorded modules: "No academic record found for this student." | Not applicable. | "We could not complete the check. Please try again." | Staff role required. A student is shown "You do not have permission to view this page." | If the record is older than the latest update, it is labelled "Record last updated [date and time]". Records unavailable: same message as Student lookup. |
| **Result** (not eligible) | Same as above. | Same as above. | Not applicable. | Same as above. | Same as above. | Same as above. |

## 3. Notes on design choices

- **Records unavailable never produces a status.** UC-03's alternative flow says no letter is issued when the records source is down. Staff and students both see the same plain message and a way to retry.
- **Queued email is not an error.** The email is sent by a background worker (ADR-002), so "Letter ready" can appear before the email arrives. The message says so, to avoid students thinking nothing was sent.
- **Unauthorised screens show no data at all**, not even blanked fields, to meet QS-3.
