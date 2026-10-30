# Adapting the Workflow to Other AI Tools & Assistants

While this repository highlights **Antigravity (Gemini)** as the Specification Agent and **Claude Code** as the Build Agent, the **Spec-Driven Architecture Pattern** is agnostic and can be applied to any modern AI coding tool.

---

## The Universal Pattern

Regardless of which tool you use, the core workflow remains:
1. **Planner / Architect Role:** Focuses on requirements interview, edge cases, behavioral specs, and ADRs.
2. **Approval Gate:** Human engineer signs off on `specs/<feature>/spec.md` (`Status: Approved`).
3. **Builder Role:** Implements code using strict TDD, bounded slices, and project verification commands.

---

## 1. Adapting to Cursor

In Cursor, rules can be applied via `.cursor/rules/` or `.cursorrules`:

### Specification Mode in Cursor:
Create `.cursor/rules/spec-agent.mdc`:
```markdown
---
description: Spec Agent mode for authoring behavioral requirements
globs: specs/**, docs/**
alwaysApply: false
---
You are operating in Specification Agent mode.
- Proactively interview the user to clarify assumptions and boundary conditions.
- Author behavioral Given/When/Then acceptance criteria in specs/<change>/spec.md.
- Slices tasks in specs/<change>/tasks.md (<= 400 lines).
- DO NOT generate application source code. Stop and wait for human approval.
```

### Builder Mode in Cursor:
Create `.cursor/rules/build-agent.mdc`:
```markdown
---
description: Build Agent mode for TDD implementation
globs: src/**, tests/**
alwaysApply: false
---
You are operating in Build Agent mode.
- Read AGENTS.md and specs/<change>/spec.md.
- Refuse to implement code unless specs/<change>/spec.md contains "Status: Approved".
- Implement task-by-task using strict TDD (Red -> Green -> Refactor).
- Execute the test commands defined in AGENTS.md.
```

---

## 2. Adapting to OpenAI Codex / ChatGPT Codex CLI

When using Codex CLI or custom agent sessions:

1. **System Prompt / Profile for Planning:**
   Configure your planner profile to consume `config/templates/GEMINI.md` as system instructions.
2. **Execution Profile:**
   Configure your coding profile to load `AGENTS.md` and enforce the `Status: Approved` check before touching files outside `specs/`.

---

## 3. Adapting to GitHub Copilot (CLI & Workspace)

- **Workspace Instructions:** Place the content of `config/templates/AGENTS.md` into `.github/copilot-instructions.md`.
- **Pre-commit / Git Hooks:** You can enforce the Spec Gate using a simple git pre-commit hook that verifies whether a modified feature has an approved `spec.md`.

---

## 4. Adapting to Windsurf / Cascade

- Windsurf natively reads `.windsurfrules` in the repository root.
- Add an `@AGENTS.md` import or paste the verification commands and boundary rules directly into `.windsurfrules`.
- Instruct Cascade to operate in "Planning Mode" when generating files in `specs/`, and "Implementation Mode" when working on code in `src/`.

---

## 5. Adapting to Aider

When using Aider in terminal:
```bash
# 1. Spec phase: architect mode (docs only)
aider --architect specs/my-feature/spec.md specs/my-feature/tasks.md

# 2. Human approval: review and edit spec.md -> Status: Approved

# 3. Build phase: implement with test command
aider --test-cmd "npm test" src/ tests/
```
