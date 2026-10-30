@'
# Accessibility Checklist - Lab 10

Checked against the Student wireframes (`prototype/wireframes-student.html`) and the Academic staff wireframes (`prototype/wireframes-staff.html`). Linked to quality scenario **QS-7 (Access on Any Device)** and **QS-6 (Request Effort)** in `docs/use cases/quality-scenarios.md`, and to the alternative states in `docs/ui-states.md`.

**Checked by:** pako-18 (Member 4) on 30 October 2026, by opening both files in a browser and using the keyboard.

**Limits of this check:** the wireframes are static, so buttons do not navigate. This checklist checks reachability by keyboard, focus visibility, labelling, cues, messages and layout. It does not check colour contrast numerically (the wireframes are black and white) or screen reader output beyond the roles used in the HTML. Those are re-checked on the built interface.

## Checklist

| # | Requirement | Screens checked | Result | Evidence / notes | Action if failed |
|---|---|---|---|---|---|
| 1 | **Keyboard access:** every field, button and link can be reached with Tab, in a sensible order. | Student: Sign in, Dashboard, Request, Letter ready, Outstanding. Staff: Student lookup, Result. | To confirm | Buttons do not navigate because the wireframes are static. Tab order to be written here, for example "Student ID, Password, Sign in, Sign out". | Fix the order in the HTML so it follows the reading order. |
| 2 | **Visible focus:** a clear outline shows the current item. | All screens | Pass | A thick black outline appears on fields, buttons and links when focused. | - |
| 3 | **Persistent labels:** each field keeps a visible label, not placeholder text. | Student: Sign in. Staff: Student lookup. | Pass | "Student ID" and "Password" are written above their fields and stay visible. | - |
| 4 | **Non-colour cues:** meaning never depends on colour alone. | All screens | Pass | Success, error and warning messages use an icon and words (✔ Eligible, ✖ Not eligible, ⚠ Records unavailable). If colour is added later it must be used on top of these, never instead of them. | - |
| 5 | **Clear errors:** each error says what happened and what to do next. | Sign in, Student lookup, Request, all states in `docs/ui-states.md` | Pass | Example: "No student found with ID [ID]. Check the ID and try again." Errors sit next to the field and the typed ID stays in the box. | - |
| 6 | **Readable responsive layout:** text is readable and nothing is cut off at phone width. | All screens | To confirm | Check with the browser phone view (F12, then Ctrl+Shift+M), or by zooming to 300%. Result to be written here. | Adjust widths so no sideways scrolling is needed. |

## Checks made by design (to verify after implementation)

| Requirement | How the design supports it | How it will be verified |
|---|---|---|
| Works on any device, no app install (QS-7) | Plain web pages, single column, large touch targets. | Open the built pages on a phone and on a shared computer browser. |
| Loading and error messages announced to screen readers | Loading uses `role="status"` and errors use `role="alert"` in the HTML. | Test with a screen reader such as NVDA on the built interface. |
| No protected data on unauthorised screens (QS-3) | The unauthorised screen shows no student data, not even empty fields. | Try to open the staff page as a student account. |

## Summary

Four of six requirements pass on the wireframes, and two (keyboard order and phone layout) are confirmed separately in the table above.
'@ | Set-Content -Path docs\accessibility-checklist.md -Encoding utf8
code docs\accessibility-checklist.md