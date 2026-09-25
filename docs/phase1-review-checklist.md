# Phase 1 Review Checklist

**Project:** Student Completion Verification and Digital Letter Issuance System
**Laboratory:** 6 — Phase 1 final review and submission readiness
**Submission:** `submissions/CSI473_A2_Phase1_TeamNN.pdf` (source:
`submissions/phase1-report.md`)
**Repository tag:** `phase1-submission`

---

## 1. Approval conditions

<!-- Copy each condition the lecturer attached to your project approval
     (from the approval email/feedback), then state how it was addressed. -->

| # | Approval condition (from lecturer feedback) | How addressed | Evidence | Status |
|---|---|---|---|---|
| A1 | *e.g. Keep scope to completion verification and letter issuance* | Financial clearance (UC-04) removed as out of scope | `use-cases.md`, report §8 | ☐ |
| A2 | | | | ☐ |
| A3 | | | | ☐ |

## 2. Required Phase 1 sections

| Section | Present | Location | Readable export |
|---|---|---|---|
| Problem statement and objectives | ☑ | report §2–3, `README.md` | PDF |
| Scope, assumptions, constraints, privacy/risks | ☑ | report §4 | PDF |
| Stakeholders and actors | ☑ | report §5, `docs/actors.md` | PDF |
| Functional requirements with acceptance criteria | ☑ | `requirements.md` (FR-01 to FR-15) | PDF |
| Quality scenarios | ☑ | `docs/use cases/quality-scenarios.md` (QS-1 to QS-5) | PDF |
| Use cases with alternative flows | ☑ | `use-cases.md` | PDF |
| Acceptance criteria | ☑ | `docs/use cases/acceptance-criteria.md` | PDF |
| Domain model | ☑ | `models/domain-model.mmd` | `.svg`, in PDF |
| Responsibility allocation (CRC) | ☑ | `docs/crc-cards.md` | — |
| Sequence diagram (UC-02) | ☑ | `models/sequence-core-use-case.mmd` | `.svg`, in PDF |
| Lifecycle model (`LetterRequest`) | ☑ | `models/lifecycle-letter-request.mmd` | `.svg`, in PDF |
| Decision record | ☑ | `decisions/D-002.md` | PDF §10 |
| Traceability matrix | ☑ | `docs/traceability-matrix.md` | — |
| Consistency matrix | ☑ | `docs/consistency-matrix.md` | — |

## 3. Rubric-based consistency and traceability review

| Rubric criterion | Check | Result |
|---|---|---|
| Purpose and traceability | Every FR maps to a use case, analysis element and verification | ☑ FR-01 to FR-15 all traced; FR-09 corrected (F-02) |
| Technical correctness | Notation valid; all diagrams render from source | ☑ All `.mmd` re-exported to `.svg` |
| Design rationale | Each decision states choice, alternative, consequence | ☑ `decisions/D-002.md`, Decisions 1–4 |
| Consistency | Same names across use cases, domain model, sequence, lifecycle, CRC | ☑ After F-01, F-03 and CRC update |
| Evidence and revision | Editable source + export + revision commit | ☑ Revision commit on branch `lab-06` |

## 4. Diagram, identifier and reproducibility inspection

| Check | Result |
|---|---|
| Diagrams readable at A4 in the PDF | ☑ Embedded from SVG exports |
| Identifiers consistent (FR-xx, UC-xx, QS-x, D-xxx) | ☑ QS headings renamed to QS-1 to QS-5; UC-04 retired, not reused |
| One canonical file per artefact | ☑ Duplicate early drafts moved to `docs/archive/` |
| README lets another person find the sources and exports | ☑ "Phase 1 submission" section added to `README.md` |
| Tag `phase1-submission` points at the submitted commit | ☐ Create after merge (see README) |

## 5. Peer review: three highest-risk findings

<!-- Record the reviewing team's name and anything they raise. The three
     findings below came from our own review; replace or add to them with
     the peer team's findings if they differ. -->

**Reviewed by:** Team ___

| ID | Finding | Risk | Correction | Commit |
|---|---|---|---|---|
| F-01 | UC-04 / UC-02 step 4 require financial clearance, but no FR covers it and it is out of scope | High: use cases contradict requirements and scope | UC-04 withdrawn; UC-02 step 4 and A4 removed; matrices and report updated | ___ |
| F-02 | Traceability matrix describes FR-09 as "update records" (UC-11); `requirements.md` says FR-09 is "review assessment" | High: the requirement is traced to the wrong behaviour | FR-09 re-traced to UC-05; lifecycle label fixed; UC-11 gap recorded | ___ |
| F-03 | FR-15 audit has no link from `ApprovalDecision`, `CompletionLetter` or `VerificationRequest` in the domain model | Medium–High: the sequence diagram and domain model disagree | Associations added; SVG re-exported; CRC card for `AuditEntry` added | ___ |

Other issues corrected: report §7 listed only four of the five quality
scenarios; the sequence diagram's scope is now stated; CRC typos fixed and four
cards added; the evidence index wrongly labelled the sequence diagram "UC-04".

## 6. Items knowingly carried into Phase 2

- UC-08 and UC-11 have no requirement of their own (FR-16/FR-17 proposed).
- The team must confirm whether letter issuance needs Registry Officer approval
  (current baseline: **yes**, per FR-10 and UC-05).

## 7. Submission

| Step | Done |
|---|---|
| Final PDF built from `submissions/phase1-report.md` and renamed with the team number | ☐ |
| Revision committed and merged into `main` | ☐ |
| Tag `phase1-submission` created and pushed | ☐ |
| PDF uploaded to Moodle: Assignment 2, Project Phase 1 | ☐ |
