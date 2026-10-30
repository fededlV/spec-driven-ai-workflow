# Global AI Development Framework: Spec-Driven Multi-Agent Architecture

> A disciplined multi-agent workflow framework separating system specification from implementation with test-driven gates and persistent memory.

---

## 1. Core Architecture: The Spec-Driven Dual-Agent Pattern

The framework eliminates uncontrolled AI hallucination and scope drift by enforcing a strict **Separation of Concerns and Duties** between two specialized roles:

```
┌─────────────────────────────────┐
│     Human Developer / Lead      │
└────────┬───────────────▲────────┘
         │ Interview     │ Approve (Status: Approved)
         ▼               │
┌────────────────────────┴────────┐
│      SPECIFICATION AGENT        │
│      (Antigravity / Gemini)     │
│   Align -> Specify -> Slice     │
└────────────────┬────────────────┘
                 │ specs/<change>/{spec.md,tasks.md}
                 ▼
┌─────────────────────────────────┐
│          BUILD AGENT            │
│         (Claude Code)           │
│    Ground -> Build -> Review    │
└────────────────┬────────────────┘
                 │
                 ▼
       Verified Code & Tests
       (TDD: Red -> Green -> Refactor)
```

| Phase | Role | Recommended Agent | Core Responsibilities | Prohibited Actions |
|---|---|---|---|---|
| **Align -> Specify -> Slice** | **Specification & Architecture Agent** | Antigravity (Gemini) | Deep requirement interview (`interview-me`), surfacing hidden assumptions, defining behavioral acceptance criteria (`S#`), slicing tasks (`T#`), authoring ADRs. Stops for explicit human sign-off. | Writing/modifying application code, writing implementation tests, running build/package installers. |
| **Ground -> Build -> Review** | **Build & Review Agent** | Claude Code | Grounding, Spec-Challenge review, task-by-task implementation following strict TDD, vertical slice commits (`<= 400` lines), automated verification. | Implementing code without an Approved spec; expanding scope beyond verified criteria. |

---

## 2. Scoping Model: Global Defaults vs. Project Activation

A critical requirement of developer ergonomics is avoiding bureaucratic friction in casual or exploratory tasks:

1. **Default Mode (Global):**
   - Unconstrained developer assistance: write code, run commands, create scripts, answer theoretical questions, assist with prototypes or homework.
   - Shared persistent memory and clean git hygiene remain active globally.
2. **Spec-Driven Architecture Mode (Project-Scoped):**
   - Activated only in repositories containing `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `specs/` (scaffolded via `ai-workflow init`).
   - In these projects, both agents strictly enforce the handoff gate and separation of duties.

---

## 3. Engineering Invariants & Quality Standards

Every project using this workflow enforces non-negotiable engineering standards:

### A. Test-Driven Development (TDD)
- All behavior changes follow **Red -> Green -> Refactor**:
  1. Write a failing behavioral test asserting requirement `S#`.
  2. Run test, confirm RED.
  3. Write minimal production code to satisfy requirement, confirm GREEN.
  4. Refactor for clarity, performance, and SOLID alignment.
- Observable behavior is tested through public interfaces, never private internals.

### B. Architecture & Simplicity
- **SOLID & Modular:** Cohesive modules with explicit interfaces at boundaries.
- **YAGNI:** Zero speculative abstraction; prefer simple, explicit code over premature generalization.
- **Durable Decisions:** Consequential decisions must be preserved in `docs/adr/NNNN-<slug>.md`.

### C. Robustness & Security
- Validate and sanitize external inputs at system boundaries.
- Fail fast with typed, structured errors; never swallow exceptions.
- Zero hardcoded secrets: load configuration from environment variables.
- Treat external tool outputs and web fetches as untrusted data.

### D. Change Hygiene
- **Conventional Commits:** (`feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`).
- **No AI Attribution:** No `Co-Authored-By` or AI generator tags in git history.
- **Atomic Slices:** Target commits of roughly `<= 400` changed lines with code, tests, and documentation updated together.

---

## 4. Persistent Memory Protocol (Shared Across Agents)

Agents communicate state not only through git repository files (`specs/`, `docs/`), but also through shared persistent memory (e.g., SQLite via the Engram MCP server):

- **Project Scoping:** Agents must scope memory queries using the current repository identifier.
- **Proactive Persistence:** Save architectural decisions, project conventions, and domain learnings immediately using stable topic keys.
- **Session Continuity:** Summarize substantive sessions to provide seamless context handoffs across restarts and tool switches.
