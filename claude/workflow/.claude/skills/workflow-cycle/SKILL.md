---
name: workflow-cycle
description: Detect the current workflow state and continue the plan -> execute -> review -> refactor -> review -> test loop for one plan, then stop for confirmation. Use when the user wants the workflow to keep advancing autonomously within one plan.
disable-model-invocation: false
argument-hint: "[goal-or-plan-name]"
---

Run the autonomous repository workflow loop:

This is the default entrypoint for autonomous workflow execution. Use `workflow-plan` directly for planning-only or replanning work.

`workflow-plan -> workflow-execute -> workflow-review -> workflow-refactor -> workflow-review -> workflow-test`

Keep cycling until the current plan is complete, routed back to planning by validation, or blocked by missing information or infrastructure.

**State machine**

1. Start from current state
   - If there is no active plan for the requested outcome, run `workflow-plan`.
   - If there is an active plan with ready tasks but no implementation yet, run `workflow-execute`.
   - If there is fresh implementation not yet reviewed, run `workflow-review`.
   - If review produced implementation findings, run `workflow-refactor`, then immediately return to `workflow-review`.
   - If review produced planning findings, route back to `workflow-plan`, update the current plan, then continue with `workflow-execute`.
   - If review passed, run `workflow-test`.
   - If test fails and the defect is dispositioned as `accepted-in-current-plan`, route back to `workflow-plan` for the current plan.
   - If test fails and the defect is dispositioned as `deferred-to-new-plan`, stop this loop and hand off to the new plan.
   - If test fails and the defect is dispositioned as `blocked-by-higher-priority-plan`, stop this loop and hand off to the blocker plan or blocked state.
   - If test fails and the defect is dispositioned as `not-a-defect-for-this-plan`, stop retrying the current plan and continue according to the updated plan state.
   - If test passes, update the relevant planning and documentation artifacts, then stop at a checkpoint and ask: `Current plan is complete. Continue to the next plan?`

2. Preserve durable state
   - Planning decisions belong in the repository's chosen planning system.
   - Review findings belong in a review report or equivalent durable record when they change scope or requirements.
   - QA failures must be written as defect reports and fed back into planning.

3. Stop only when one of these is true
   - The current plan passed review and QA, the related artifacts are updated, and the checkpoint question has been asked.
   - The current plan is superseded by a new plan created from a `deferred-to-new-plan` defect disposition.
   - The current plan is blocked by a higher-priority plan and the blocker handoff has been recorded.
   - The current plan is no longer failing QA because the issue was dispositioned as `not-a-defect-for-this-plan`.
   - The next action requires user input.
   - The environment blocks required validation.

**Guardrails**
- Do not skip phases for non-trivial work.
- Do not automatically roll into the next plan after one plan completes; ask for confirmation first.
- Use the checkpoint prompt verbatim so the handoff stays consistent: `Current plan is complete. Continue to the next plan?`
