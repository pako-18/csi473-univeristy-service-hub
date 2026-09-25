# Student Completion Verification and Digital Letter Issuance System

## Project Overview

This project proposes a software system for verifying whether students have completed the academic requirements of their programme and issuing a digital letter of completion.

The system is intended to reduce delays in the manual processing of completion letters by checking a student's academic credits and programme requirements and supporting the generation and delivery of a completion letter.

## Problem Statement

Students may experience delays in receiving their letters of completion after completing the requirements of their academic programme.

The proposed system aims to improve the completion verification process by providing a structured way to:

- Verify student academic requirements.
- Check completed credits against programme requirements.
- Identify outstanding requirements.
- Support the approval of completion.
- Generate a digital letter of completion.
- Deliver the letter electronically to the student.

## Project Objectives

The main objectives of the system are to:

1. Verify whether a student has fulfilled the requirements of their programme.
2. Calculate and validate the student's completed credits.
3. Identify any outstanding academic requirements.
4. Reduce delays associated with manual completion verification.
5. Support the generation of a digital completion letter.
6. Provide a reliable record of the completion verification process.

## Stakeholders

The main stakeholders identified for the system include:

- Students
- Academic departments
- Faculty or programme administrators
- Examinations/records officers
- University management
- IT/System administrators

## Repository Structure

| Folder / file | Purpose |
|---|---|
| `requirements.md` | Functional requirements FR-01 to FR-15 (canonical) |
| `use-cases.md` | Use cases UC-01 to UC-11 (UC-04 withdrawn) |
| `docs/` | Actors, business rules, CRC cards, traceability and consistency matrices, review checklist, architecture drivers |
| `docs/use cases/` | Quality scenarios (QS-1 to QS-5) and acceptance criteria |
| `docs/archive/` | Superseded early drafts, not part of the assessed baseline |
| `models/` | Editable Mermaid sources (`.mmd`) and SVG exports of all models |
| `decisions/` | Decision records (D-002 domain modelling) |
| `submissions/` | Phase 1 report source (`phase1-report.md`) and submitted PDF |

## Phase 1 Submission

- **Tag:** `phase1-submission`. Run `git checkout phase1-submission` to see
  exactly what was submitted.
- **Submitted PDF:** `submissions/CSI473_A2_Phase1_TeamNN.pdf`
- **Report source:** `submissions/phase1-report.md`
- **Model sources → exports:** `models/*.mmd` → `models/*.svg`. Regenerate an
  export with
  `npx -p @mermaid-js/mermaid-cli mmdc -i models/<name>.mmd -o models/<name>.svg`
- **Review record:** `docs/phase1-review-checklist.md`

## Team

This project is being developed as a group for CSI473 Software Engineering.

## Project Status

**Current stage:** Phase 1 (requirements and analysis) submitted; Phase 2 (architecture and design) in progress.