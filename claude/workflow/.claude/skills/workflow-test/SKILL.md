---
name: workflow-test
description: Run validation on the current planned slice and either return defects to planning or finalize documentation and plan updates. Use when review has passed and the slice is ready for validation.
disable-model-invocation: true
context: fork
agent: qa
argument-hint: "[plan-name]"
---

Run the `test` phase of the repository workflow.

This phase acts like QA. It validates the implemented slice against the active plan with broader checks where appropriate.

Use the dedicated `qa` subagent for this phase by default.

**Steps**

1. Read the active plan and its acceptance criteria.
2. Build the smallest validation matrix that proves the slice works as planned.
   - Include broader integration or end-to-end style checks when the change crosses module or workflow boundaries.
3. Run the validation.
4. Route the result
   - If behavior is wrong, incomplete, or inconsistent with the plan, produce a defect report and send the work back to `workflow-plan` as the default highest-priority item.
   - If validation passes, update tasks, docs, and other durable records as needed, mark the current plan complete, and hand off to the workflow checkpoint.
5. Workflow checkpoint
   - After the current plan is complete, ask: `Current plan is complete. Continue to the next plan?`
   - Do not automatically begin the next planning cycle without explicit confirmation.

**Defect disposition handling**
- After `workflow-plan` evaluates a defect, it must record one of these dispositions:
  - `accepted-in-current-plan`
  - `deferred-to-new-plan`
  - `blocked-by-higher-priority-plan`
  - `not-a-defect-for-this-plan`
- `workflow-test` must use the recorded disposition on the next pass:
  - `accepted-in-current-plan`: re-validate after the fix is implemented.
  - `deferred-to-new-plan`: do not re-raise the defect against the current plan; follow the new plan instead.
  - `blocked-by-higher-priority-plan`: stop re-raising the defect for the current plan until the blocker plan changes state.
  - `not-a-defect-for-this-plan`: do not treat the issue as a failure of the current plan.
- If the disposition is `deferred-to-new-plan` or `blocked-by-higher-priority-plan`, hand off control back to the workflow loop with that status instead of continuing retries on the current plan.

**Defect report format**
- Reproduction steps
- Expected behavior
- Actual behavior
- Scope impact
- Recommended planning follow-up

**Guardrails**
- Do not treat review as a substitute for validation.
- Do not silently accept known gaps between implementation and plan.
- Do not repeatedly re-raise the same defect against the same plan without a changed disposition or implementation state.
