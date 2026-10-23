# Framework Decision - Lab 9

- **Status:** Proposed (team to confirm)
- **Date:** 23 October 2026
- **Linked to:** docs/pattern-decisions.md (P1 to P5), models/detailed-class-design.mmd, decisions/ADR-002.md

## Decision
We will build the prototype as one deployable web application in **Java 17 with Spring Boot 3**, using **Maven** to manage dependencies.

| Need | Choice | Linked requirement / problem |
|---|---|---|
| Web UI and API | Spring Web (REST controllers) | FR-01, FR-14 |
| Saving requests, letters, outbox rows, audit log | Spring Data JPA behind our repository interfaces; H2 in-memory database for the prototype and tests, a production relational database later | P1, FR-13, FR-15 |
| PDF letter | A PDF library (Apache PDFBox or OpenPDF) behind LetterRenderer | P3, FR-11 |
| Email | Spring Mail behind NotificationSender | P4, FR-12 |
| Retry worker | Spring scheduled task (@Scheduled) running EmailRetryWorker | P4, ADR-002 |
| Tests | JUnit 5 and Mockito, with fake in-memory ports | Exit record test |

## Why this fits our project
- Our architecture is one deployable web application with a relational database, which is what Spring Boot is built for.
- Spring's constructor injection lets LetterIssuanceService receive its interfaces (the ports) from outside, so it never creates a concrete adapter itself. This supports Ports and Adapters (P1 to P3).
- Spring has built-in scheduling and mail support, so the outbox worker (P4) needs no extra server.
- The team already knows Java, and Spring Boot has plenty of documentation for students.

## Dependency-management approach
- All libraries are declared in one `pom.xml`. Spring Boot's parent POM fixes compatible versions, and we pin any extra library (PDF, test tools) to a specific version.
- Dependency direction: the application service and domain classes depend only on the interfaces in `src/interfaces-or-ports/`. Adapters (database, records system, PDF, email) depend on the interfaces and the libraries, never the other way round.
- Framework annotations (@Entity, @Repository, @Scheduled) are kept in the adapter classes. The domain and port classes stay plain Java so they can be tested without Spring.
- The pom.xml and its lock of versions are committed. New libraries are added in a pull request and checked by a teammate.

## Alternative considered
**Quarkus or plain Jakarta EE.** Realistic and lighter at startup. Not chosen because the team has less experience with them and there are fewer student-level examples, which would slow the prototype.

## Consequences
- **Accepted:** Spring adds some hidden behaviour (auto-configuration, annotations), and its libraries make the build larger.
- **Managed by:** keeping Spring out of the domain and port classes, and writing the core test with fake ports and no Spring.
- **Revisit if:** the team decides on another language or framework before Phase 2.