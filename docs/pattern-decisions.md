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

| Pattern / technique | Solves | Participants (from detailed-class-design) | Why it fits our project | Cost accepted |
|---|---|---|---|---|
| Ports and Adapters (Repository, Gateway, Renderer) | P1, P2, P3 | LetterIssuanceService; LetterRequestRepository, LetterRepository, StudentRecordsGateway, LetterRenderer; DbLetterRequestRepository, DbLetterRepository, RecordsSystemAdapter, PdfLetterRenderer | The issuing logic must not depend on the database, the records source or the PDF tool. The prototype uses test records, and a real records system can replace it later. | More files and interfaces to write and keep in sync |
| Strategy | P5 | CompletionChecker; EligibilityRule; CreditsRule, CompulsoryModulesRule, ElectiveCreditsRule | FR-04 to FR-06 are separate checks, and FR-07 needs an itemised list of what is missing. One rule class per check gives that list naturally. | Three small classes instead of one method |
| Outbox | P4 | LetterIssuanceService; EmailOutbox; DbEmailOutbox; EmailRetryWorker; NotificationSender | FR-12 needs delivery to be logged, and the email server can fail. Saving the email first means a failed send is retried, not lost. | A background worker and an extra table (see decisions/ADR-002.md) |

## 3. Exit record
- **Greatest benefit:** Ports and Adapters. LetterIssuanceService can be tested without a database, records system or PDF tool.
- **Cost:** extra interfaces and adapter classes to maintain.
- **Test that confirms it works:** run verifyAndIssue with fake in-memory versions of the repositories, gateway and renderer. A student who meets all requirements gets a Letter with a verification code, and the test needs no database or email server.