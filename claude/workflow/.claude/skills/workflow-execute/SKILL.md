---
name: workflow-execute
description: Implement the highest-priority ready task from the active plan and add matching tests. Use when the current plan is ready for implementation.
disable-model-invocation: true
argument-hint: "[plan-name]"
---

Run the `execute` phase of the repository workflow.

This phase acts like a senior engineer. It reads the current plan, implements the top ready task, and adds or updates tests before handing off to review.

Use the dedicated `executor` subagent when the implementation scope is large enough to justify the extra handoff and context cost. For small, tightly coupled changes, this phase may stay in the main thread.

Design and implementation should improve clarity and maintainability pragmatically within the current plan scope.

**Steps**

1. Select the active plan
   - If the user named a plan, use it.
   - Otherwise inspect the repository's planning artifacts and infer the active plan from context.
   - If no suitable plan exists, stop and run `workflow-plan`.

2. Read execution context
   - Read the current planning artifacts for the selected plan.
   - Identify the highest-priority ready task and its acceptance criteria.
   - If the task is under-specified, stop and send the work back to `workflow-plan`.

3. Implement
   - Make the smallest safe code change that satisfies the task.
   - Prefer cohesive modules, explicit dependency boundaries, readable naming, and small interfaces where they materially improve the design.
   - Add or update the tests needed for the slice.
   - Update task progress in the planning artifacts as work is completed.

4. Prepare handoff
   - Summarize what changed.
   - Note the commands run and any gaps or assumptions.
   - Hand the work to `workflow-review`.

**Guardrails**
- Stay inside the plan.
- Do not skip tests that clearly belong with the code change.
- Do not introduce abstraction solely to satisfy a principle in the abstract; the design improvement must help the current codebase.
- If implementation reveals a plan defect, update the planning artifacts before continuing.
