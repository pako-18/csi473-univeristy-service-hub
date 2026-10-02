# Quality Scenarios to Architecture

**Project:** Student Completion Verification and Digital Letter Issuance System
**Laboratory:** 7
**Source:** `docs/architecture-drivers.md`, `docs/use cases/quality-scenarios.md`

## 1. Design obligations

| Driver | Scenario / FR | Design obligation | Architecture element that carries it |
|---|---|---|---|
| D1 Correctness | QS-2; FR-03 to FR-08 | Eligibility rules live in one place only | Eligibility module |
| D1 Correctness | QS-2; FR-08 | Credits are always calculated from one source of truth, with no manual check | Academic Record Adapter (single read path) |
| D1 Correctness | QS-2; FR-08 | Eligibility decision, letter record and audit entry are saved together or not at all | Letter Requests module + one relational database (single transaction) |
| D2 Security | QS-3; FR-01, FR-13 | One access-control check point for all authenticated features | Identity module |
| D2 Security | QS-3; FR-14 | Public verification route is separate from authenticated routes and exposes only what FR-14 allows | Verification module |
| D2 Security | FR-15 | Audit trail is append-only and cannot be edited by users | Audit module |
| D3 Availability | QS-4 | Completion-status features stay usable during operating hours | Deployment: health check, restart, backup and restore |
| D3 Reliability | QS-5; FR-12 | An issued letter is stored before email is sent; email failure never loses the letter | Letter Issuance module + email outbox with retries |
| C1 / C2 | Constraints §4.4 | Academic records can be swapped for test data; only approved technology | Academic Record Adapter (replaceable) |

## 2. Scenario not treated as a driver

QS-1 (3-second response): load is a few thousand requests a year, so it does not constrain the structure. It is checked later through testing.

## 3. Traceability

| Quality scenario | Driver | Architecture elements |
|---|---|---|
| QS-2 | D1 | Eligibility, Academic Record Adapter, Letter Requests |
| QS-3 | D2 | Identity, Verification, Audit |
| QS-4 | D3 | Deployment and operations |
| QS-5 | D3 | Letter Issuance, email outbox |