---
name: workflow-review
description: Perform independent code review on the current implementation and route it to refactor, back to plan, or to QA. Use when a planned slice has fresh implementation ready for review.
disable-model-invocation: true
context: fork
agent: reviewer
argument-hint: "[plan-name]"
---

Run the `review` phase of the repository workflow.

This phase acts like an independent senior engineer. It reviews the current implementation against the active plan and decides whether the work should go to `workflow-refactor`, back to `workflow-plan`, or to `workflow-test`.

Use the dedicated `reviewer` subagent for this phase by default.

**Steps**

1. Read context
   - Inspect the active plan.
   - Inspect the current diff and any changed tests.
   - Review any relevant contracts, docs, or reference behavior when they matter.

2. Review the implementation
   - Prioritize correctness, regression risk, missing tests, and avoidable complexity.
   - Separate blocking findings from optional suggestions.
   - Respect existing finding dispositions and only re-open a dispositioned finding when there is new evidence, a changed implementation state, or a changed plan.
   - Classify each material issue as either an implementation issue or a planning issue.

3. Route the work
   - If there are implementation issues, produce a concise review report and send the work to `workflow-refactor`.
   - If there are planning issues, produce a concise review report and send the work to `workflow-plan`.
   - If there are no material findings, say so clearly and send the work to `workflow-test`.

**Finding disposition handling**
- After `workflow-refactor` evaluates a review finding, it must record one of these dispositions:
  - `accepted`
  - `rejected-with-rationale`
- `workflow-review` must use the recorded disposition on the next pass:
  - `accepted`: verify the fix and either clear the finding or raise a new one if the implementation changed in a materially different way.
  - `rejected-with-rationale`: do not re-raise the same finding against the same implementation state without new evidence.

**Guardrails**
- Findings should be concrete and defensible.
- Prefer file-level guidance with rationale over vague advice.
- Do not edit code in this phase.
- Do not repeatedly re-raise the same finding against the same implementation state without a changed disposition, changed implementation, or changed plan.
