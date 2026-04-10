---
name: workflow-plan
description: Inspect the current project state and prepare or update the next implementation slice. Use when the user wants planning, reprioritization, or the next implementation slice selected.
disable-model-invocation: true
context: fork
agent: planner
argument-hint: "[goal-or-plan-name]"
---

Run the `plan` phase of the repository workflow.

This phase acts like a project manager. It inspects the current repository, active plans, unfinished tasks, and recent defects, then prepares the next highest-priority implementation slice.

Use this skill directly for planning-only or replanning work. For autonomous execution of the full workflow, enter through `workflow-cycle`.

Use the dedicated `planner` subagent for this phase by default.

**Primary outcome**
- A current plan with clear scope, sequencing, acceptance criteria, and validation expectations.

**Steps**

1. Inspect current state
   - Start with the `Planning Inputs` section in `CLAUDE.md`, then follow the referenced docs and planning artifacts needed for the current decision.
   - Inspect the active plan set used by the repository.
   - Inspect unfinished tasks before planning new work.
   - Review git diff, recent failures, and any outstanding implementation or QA feedback relevant to prioritization.
   - Treat defects reported by `test` for the current plan as the default highest-priority input.

2. Choose the next highest-priority slice
   - Classify it as a feature, bug fix, refactor, hardening task, or optimization.
   - Prefer the smallest slice that materially advances the project.
   - If there is no active plan for that slice, create one in the repository's chosen planning system.
   - If unfinished tasks already exist, decide whether to continue one of them or explicitly re-prioritize ahead of them.
   - Do not add new tasks while unfinished tasks remain unless you record why reprioritization is necessary, which task is being displaced, and why the new task has higher priority.
   - If `test` reported a defect for the current plan, schedule fixing that defect before new feature or optimization work unless you explicitly record why it is deferred.
   - If a `test`-reported defect is outside the current plan scope, create or assign a separate plan for it instead of silently folding it into the current plan.

3. Bring the plan up to date
   - Create or update the repository's planning artifacts as needed.
   - Ensure the tasks are ordered for execution, review, and QA.
   - Reorder tasks by dependency, risk, and value.
   - Record a disposition for each `test`-reported defect:
     - `accepted-in-current-plan`
     - `deferred-to-new-plan`
     - `blocked-by-higher-priority-plan`
     - `not-a-defect-for-this-plan`
   - Add acceptance criteria and expected validation for the slice.

4. Exit with a clear handoff to `execute`
   - State the selected plan.
   - State the exact next task to execute.
   - If other unfinished tasks were deferred, state why they are not next.
   - If a `test` defect was dispositioned, state that disposition and the follow-up plan.
   - State what evidence will be required in review and test.

**Guardrails**
- Do not write production code in this phase.
- Do not leave plan changes only in chat when they materially affect implementation.
- If planning is blocked by missing information, stop with explicit questions or assumptions.
