# ADR-001: Layered modular monolith for the Student Completion Verification and Digital Letter Issuance System

**Status:** Accepted
**Date:** 2 October 2026
**Laboratory:** 7
**Related:** `docs/architecture-drivers.md`, `docs/quality-to-architecture.md`, `docs/architecture-options.md`, `models/component-architecture.mmd`

## Context

Our quality scenarios and constraints give three drivers:

- **D1 Correctness (QS-2):** FR-08 removes manual checking, so the eligibility outcome must always be right.
- **D2 Security and authenticity (QS-3):** personal records sit next to a public verification feature (FR-14).
- **D3 Availability and reliability (QS-4, QS-5):** the system must be available at least 99% of operating hours, and at least 99% of valid requests must produce a letter, even though email depends on an external server (FR-12).

Constraints: one semester, a small team, lecturer-approved technology only, and no confidential records in the prototype (the academic-record source must be replaceable with test data).

Letter issuance is automatic once the eligibility check passes. There is no manual officer approval step.

## Decision

We will build **Alternative A: a layered modular monolith**. This is one deployable web application and one relational database, organised in layers (presentation, application, domain, infrastructure) and split into modules: Identity, Letter Requests, Eligibility, Approvals (records the automatic decision), Letter Issuance, Verification and Audit.

- Academic records are read through one replaceable Academic Record Adapter.
- The eligibility decision, the letter record and the audit entry are saved in one database transaction.
- Letters are stored first and emailed from an outbox with retries, so an email failure never loses a letter.
- The public verification route is separate from the authenticated routes and can only read letters.
- All authenticated actions go through one access-control check in the Identity module.

## Alternatives considered

| Alternative | Why not chosen |
|---|---|
| **B: Event-driven microservices** (8 services, each with its own database, behind a gateway and a message broker) | Data split across services makes results eventually consistent, which weakens D1 and the audit trail. It has a larger attack surface (D2). It needs 8 deployments, a broker and a gateway, which is far beyond what one semester allows (C1). Its main benefit, independent scaling, is not needed for a few thousand requests a year. |

Weighted comparison scores: A = 4.25, B = 2.30 (see `docs/architecture-options.md`).

## Consequences

**Positive**
- One source of truth and one transaction give strong correctness (D1).
- One access-control point and a small attack surface (D2).
- The team can build, deploy and run it within the semester (C1).
- Module boundaries stay clear, so a module can be split out later.

**Negative**
- The application and database scale and fail as one unit. Availability (D3) depends on running two identical app instances, a health check, database backups and tested restore.
- A fault in one module (for example a memory leak in Verification) can affect the whole application.
- The public verification route shares a process with the authenticated features, so the separation must be enforced in code and reviewed.
- Module boundaries are only a convention in a monolith, so the team must review dependencies to stop modules reaching into each other.

## Risks

1. The single database is a single point of failure for D3.
2. Email outages could delay letters. The outbox hides this from students but needs monitoring.
3. Module boundaries may erode over time.

## Evidence that would make us reconsider

- Measured availability falls below 99% of operating hours in two consecutive months because of whole-application failures.
- Load grows beyond what two app instances and one database handle, for example response times above 3 seconds (QS-1) at graduation peaks.
- The university requires the verification feature to run separately, or other university systems need to reuse eligibility as a service.
- More than one team needs to deploy parts of the system on independent schedules.
- Email retries fail often enough that the 99% letter-generation target (QS-5) is missed.