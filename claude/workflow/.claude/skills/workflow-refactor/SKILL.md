---
name: workflow-refactor
description: Apply high-value refactors in response to review feedback, then send the result back to review. Use when review finds implementation issues that should be fixed within the current plan.
disable-model-invocation: true
argument-hint: "[plan-name]"
---

Run the `refactor` phase of the repository workflow.

This phase acts like a senior engineer responding to review. It evaluates review findings, makes the worthwhile code changes, preserves behavior, and returns the work to `workflow-review`.

Use the dedicated `refactorer` subagent when the refactor scope is large enough to justify the extra handoff and context cost. For small, tightly coupled fixes, this phase may stay in the main thread.

Refactoring should improve clarity and maintainability while staying within the current plan.

**Steps**

1. Read the latest review report and the active plan.
2. Decide which findings to adopt, narrow, or reject, with reasons.
3. Record a disposition for each finding:
   - `accepted`
   - `rejected-with-rationale`
4. Apply the chosen refactors and keep tests aligned.
   - Prefer refactors that improve readability, cohesion, dependency direction, and testability.
5. Summarize what changed, include the finding dispositions, and explicitly hand the work back to `workflow-review`.

**Guardrails**
- Do not apply suggestions that reduce clarity, weaken behavior, or widen scope without enough payoff.
- Do not force pattern-driven refactors that add indirection without clear maintenance value.
- If a finding turns out to be a planning issue rather than an implementation issue, stop refactoring and route it back to `workflow-plan`.
