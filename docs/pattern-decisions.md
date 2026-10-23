# Pattern Decisions - Lab 9

## 1. Design problems in our project

| ID | Design problem (plain words) | Where it shows up | Linked requirement / use case |
|----|------------------------------|-------------------|-------------------------------|
| P1 | Persistence coupling: the letter-issuing logic must save and look up letters and requests, but should not be stuck to one specific database. | Storing letters, verification codes, request status | FR-13, FR-14, UC-07, UC-08 |
| P2 | External dependency: student academic records come from outside our core logic, and the source could be unavailable or change. | Retrieving results and credits | FR-02, UC-03 (alt flow: record unavailable) |
| P3 | External format: the letter must be produced as a PDF, but the core logic should not know how PDFs are built. | Letter generation | FR-11, UC-06 |
| P4 | Secondary effects: after a letter is issued we must also send an email and write an audit log entry, without cluttering the main issuing code. | Notification and logging | FR-12, FR-15, UC-02 step 6 |
| P5 | Variable behaviour: eligibility rules differ by programme (credits, compulsory modules, electives). | Completion check | FR-04, FR-05, FR-06, FR-07 |

## 2. Pattern decisions
(to be filled in Step 3)