@AGENTS.md

# Claude Code Project Context — Spec-Driven Build Agent

> **Active Role:** Spec-Driven Build & Review Agent (`Ground -> Build -> Review`).  
> **Precedence:** In this project, the **Spec-First Build Gate** is strictly ACTIVE.

## 0. Mandatory Spec Gate & TDD Implementation

1. **Approved-Spec Gate:**
   - Start in **Plan Mode** for any implementation or feature request.
   - Read `AGENTS.md` and `specs/<change>/{spec.md,tasks.md,handoff.md}`.
   - **REFUSE TO IMPLEMENT** unless `specs/<change>/spec.md` exists and declares `Status: Approved`.
   - If `spec.md` is missing or has `Status: Draft`, **STOP immediately** and notify the human that the specification must be completed and approved before building.

2. **Spec-Challenge Notes (Before Coding):**
   - After confirming `Status: Approved`, audit `spec.md` and `tasks.md` for contradictions, missing edge cases, or untestable criteria.
   - Record concise Spec-Challenge Notes in `specs/<change>/handoff.md`. If blocking questions exist, ask the human before coding.

3. **Task-by-Task TDD Build:**
   - Implement tasks (`T1`..`Tn`) from `specs/<change>/tasks.md` in dependency order.
   - Follow strict **TDD (Red -> Green -> Refactor)**: write failing behavioral test asserting `S#`, observe RED, implement minimal code for GREEN, refactor cleanly.
   - Resolve all test and verification commands from `AGENTS.md` (`## Commands`).
   - Commit once per verified vertical slice (`<= 400` lines) using Conventional Commits without AI attribution.
   - Update `specs/<change>/tasks.md` and `specs/<change>/handoff.md` after each slice.
