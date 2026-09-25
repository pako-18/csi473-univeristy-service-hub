# Architecture Drivers (Phase 1 → Phase 2)

**Project:** Student Completion Verification and Digital Letter Issuance System
**Laboratory:** 6 — Phase 1 final review and architecture drivers
**Feeds:** Laboratory 7 (`docs/quality-to-architecture.md`,
`docs/architecture-options.md`, `decisions/ADR-001-architecture.md`)

These drivers come from **our own quality scenarios and constraints**
(`docs/use cases/quality-scenarios.md`, Phase 1 report §4). They were not
chosen from a preferred framework or pattern.

---

## 1. Candidate drivers considered

| Source | Summary | Architectural impact |
|---|---|---|
| QS-1 | Completion status within 3 s | Low: the load is small (a few thousand requests a year) |
| **QS-2** | Credit total exactly equals the sum of completed module credits | **High:** needs one source of truth and no manual check (FR-08) |
| **QS-3** | No protected data shown to unauthorised users | **High:** personal records plus a public verification feature (FR-14) |
| **QS-4** | ≥ 99% availability in operating hours | **High:** peak demand at graduation |
| **QS-5** | ≥ 99% of valid requests produce a letter | **High:** depends on an external email server (FR-12) |
| Constraint §4.4 | One semester; limited approved technology; no confidential records | **High:** limits operating complexity and requires a replaceable data source |

## 2. The three selected drivers

| # | Driver | From | Why it shapes the architecture |
|---|---|---|---|
| **D1** | **Correctness** of the eligibility outcome | QS-2; FR-03 to FR-08; risk 1 in §4.5 | Because FR-08 removes manual checking, the eligibility logic must sit in one place, read one source of truth, and save approval, letter and audit consistently. |
| **D2** | **Security and authenticity** of records and letters | QS-3; FR-01, FR-13, FR-14, FR-15; risk 2 in §4.5 | There must be a clear boundary between the public verification route and authenticated features, a single access-control point, and an unalterable audit trail. |
| **D3** | **Availability and reliability** of issuance | QS-4, QS-5; FR-12; risks 3 and 4 in §4.5 | No single instance may be a point of failure, and an email outage must not lose an issued letter. |

**Constraint carried alongside the drivers:** C1 is a one-semester deadline, a
small team and lecturer-approved technology only. C2 is that there must be no
confidential records in the prototype, so the academic-record source must be
replaceable with test data.

## 3. Realistic alternatives for Laboratory 7

### Alternative A — Layered modular monolith
One deployable web application and one relational database. The code is layered
(presentation → application → domain → infrastructure) and split into modules
for Identity, Letter Requests, Eligibility, Approvals, Letter Issuance,
Verification and Audit. Academic records are read through a single adapter.
Email is sent from an outbox with retries.

- *Likely strengths:* D1 (single transaction and single source of truth), C1.
- *Likely weaknesses:* scales and fails as one unit (D3).

### Alternative B — Event-driven microservices
Separate services (Auth, Request, Eligibility, Approval, Letter, Verification,
Notification, Audit), each with its own database, behind an API gateway and
communicating through a message broker.

- *Likely strengths:* fault isolation and independent scaling (D3).
- *Likely weaknesses:* eventual consistency affects D1 and FR-15; more attack
  surface (D2); operating cost far beyond C1.

Both alternatives will be compared using the **same weighted criteria (D1, D2,
D3, C1)** in Laboratory 7.
