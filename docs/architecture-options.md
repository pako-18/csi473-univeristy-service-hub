# Architecture Options

**Project:** Student Completion Verification and Digital Letter Issuance System
**Laboratory:** 7
**Drivers:** D1 correctness, D2 security and authenticity, D3 availability and reliability, C1 one-semester constraint (see `docs/architecture-drivers.md`)

## 1. Alternative A: Layered modular monolith

One deployable web application and one relational database. Layers: presentation, application, domain, infrastructure.

| Module | Responsibility | Interface it offers |
|---|---|---|
| Identity | Login, roles, the single access-control check | `authorise(user, action)` |
| Letter Requests | Receives requests, owns the LetterRequest lifecycle | `submitRequest()`, `getStatus()` |
| Eligibility | Calculates credits and checks programme rules | `checkEligibility(student)` |
| Approvals | Records the automatic eligibility decision (no manual officer step) | `recordDecision()` |
| Letter Issuance | Creates the letter, stores it, queues the email | `issueLetter()` |
| Verification | Public check of a letter's authenticity | `verify(letterCode)` |
| Audit | Append-only record of every decision and issue | `logEvent()` |
| Academic Record Adapter | Single read path to academic records | `getCompletedModules(student)` |

External systems: academic record source (replaceable with test data), email server.
Runs as: one application and one database. Email goes through an outbox table with retries.
Operating cost: one deployment, one database backup, one log stream.

## 2. Alternative B: Event-driven microservices

Services: Auth, Request, Eligibility, Approval, Letter, Verification, Notification, Audit. Each has its own database. They sit behind an API gateway and talk through a message broker.

Interfaces: one REST API per service plus events on the broker (for example `RequestSubmitted`, `EligibilityChecked`, `LetterIssued`).
Operating cost: 8 deployments, 8 databases, a broker, a gateway, distributed tracing, and a deployment pipeline for each service.

## 3. Comparison (same criteria for both)

Scores run from 1 (poor) to 5 (strong). Weights reflect the project: correctness matters most because FR-08 removes manual checking.

| Criterion | Weight | A: Modular monolith | B: Microservices |
|---|---|---|---|
| D1 Correctness of eligibility outcome | 30% | **5**. One transaction saves decision, letter and audit together. | **2**. Data is split across services, so results are eventually consistent and a partial failure can leave decision and letter out of step. |
| D2 Security and authenticity | 25% | **4**. One access-control point and a small attack surface. The public route must be kept separate inside the app. | **2**. Every service-to-service call needs its own authentication, and the attack surface is larger. |
| D3 Availability and reliability | 25% | **3**. Fails as one unit, but two identical app instances plus database backup and the email outbox cover QS-4 and QS-5. | **4**. Faults are isolated and services scale independently, but the broker and gateway become new points of failure. |
| C1 One semester, small team | 20% | **5**. Fits the team, the time and the approved technology. | **1**. Operating cost is far beyond the constraint. |
| **Weighted score** | 100% | **4.25** | **2.30** |

Weighted score = sum of (weight x score). For A: 0.30x5 + 0.25x4 + 0.25x3 + 0.20x5 = 4.25. For B: 0.30x2 + 0.25x2 + 0.25x4 + 0.20x1 = 2.30.

## 4. Result

Alternative A is preferred. It gives up independent scaling and full fault isolation (D3) to keep one source of truth (D1), a small security boundary (D2) and a design the team can finish and operate (C1). The decision and its consequences are recorded in `decisions/ADR-001-architecture.md`.