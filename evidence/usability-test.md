# Usability Test Record - Lab 10

**Date:** 30 October 2026
**Run by:** pako-18 (Member 4)
**Method:** Low-fidelity wireframes, tested remotely. Each tester was sent **one screen picture at a time** (from `prototype/wireframes-student.html` and `wireframes-staff.html`), given a task, and asked what they would press and what they expected. No hints were given. Answers are recorded in the testers' own words.
**Testers:** three team members (Kutlo, Kao, Katlego).
**Limit:** Kao and Katlego tested screens they built themselves (student and staff screens respectively), so independence is reduced. Kutlo wrote the tasks but did not build the screens.
**Linked to:** QS-6 (Request Effort), QS-7 (Access on Any Device), FR-07 (itemised outstanding requirements), `docs/user-profile-and-tasks.md`.

## Results

| Tester | Task | Screen shown | Observation | Result | Revision |
|---|---|---|---|---|---|
| Kutlo | A: student gets a letter | Sign in | Would type Student ID and password, then press Sign in. Expected the next page to lead straight to where the completion letter is. | Success | None needed |
| Kutlo | A: student gets a letter | Request completion letter | "Too much info, not straight to the point." Would improve the layout, wording and user experience. Suggested a clearer explanation of the check. | Success, with a usability complaint | Logged as possible further change (see below) |
| Kao | B: student not eligible | Request and Not eligible | Preferred the button to say "Check eligibility", not "Check and request letter". Would click Back to dashboard and wait for what is outstanding. Could not see the list of what is outstanding. | **Fail: could not find what is outstanding** | **Made: see Design change** |
| Katlego | C: staff check a student | Student lookup | Would search the database to find out why a student has no letter, and whether it is a system error or something else. | Partial: result screen does not say whether the cause is the system or the student | Logged as possible further change (see below) |

## Design change made

**Problem observed (Task B, Kao):** on the "Not yet eligible" screen the tester could not see the list of outstanding requirements, so they could not answer "what do I need to do next?". The list was small, had no heading, and the only prominent control was "Back to dashboard".

**Change:** the banner now states the number of outstanding items ("2 requirements are still outstanding"), a heading "What you still need:" sits above the list, and the list is larger, numbered and boxed. Items already met are shown separately below it.

**Why this change:** it fixes the one observed task failure on the screen that carries FR-07, and needs no new screen or feature. A realistic alternative was to shorten the Request screen text instead. We chose the list fix because a failed task matters more than a wording complaint.

**Cost accepted:** the screen is slightly longer and the met items are less prominent.

## Possible further changes (logged, not made)

1. Shorten the explanation on the Request screen to one line and rename its button "Check eligibility" (Kutlo, Kao).
2. Add a "Why no letter" line to the staff Result screen, separating "requirements outstanding" from "records system unavailable" (Katlego).

## Exit record

- **Most important usability problem:** a tester could not find the list of outstanding requirements on the "Not yet eligible" screen.
- **Interface change made:** clear count in the banner, a "What you still need" heading, and a larger numbered, boxed list.
- **How it will be verified after implementation:** ask at least two people who have not seen the design to reach the not-eligible screen and say what they still need. Each must name every outstanding item without help (and see QS-6).