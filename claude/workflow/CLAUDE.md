# Claude Local Workflow Template

Use this file as the project-facing guide for a Claude Code workflow.

Replace the placeholder sections below before adopting it in another repository.

## Project Context
- This repository is focused on `<project-goal>`.
- Preserve `<core-behavior-or-contract>` while adapting implementation to the repository's boundaries and conventions.
- Use `<docs-entrypoint>` as the main documentation entrypoint.

## Planning Inputs
- Start from `<docs-entrypoint>` for repository knowledge and document routing.
- Use `<workflow-doc-path>` for the boundary between durable docs and active change artifacts.
- Use whatever planning system this repository adopts to discover the active plan and inspect its current state.

## Core Rules
- Do not start non-trivial implementation without an active plan artifact.
- Keep planning and task tracking in one agreed system of record. Do not create parallel handoff or task files outside that system.
- Update the active plan when planning, implementation, review, or QA changes scope, sequencing, or acceptance criteria.
- Follow the formatter, linter, and test commands that are standard for this repository.
- Add or update tests whenever implementation reaches or changes behavior.

## Workflow
- Default delivery loop is `plan -> execute -> review -> refactor -> review -> test`.
- The loop is scoped to one plan at a time.
- `workflow-cycle` is the default entrypoint for autonomous workflow execution.
- `workflow-plan` is the manual entrypoint for planning-only or replanning work.
- Handle `plan`, `review`, and `test` with dedicated subagents by default: `planner`, `reviewer`, and `qa`.
- Use dedicated `executor` and `refactorer` subagents when the implementation or refactor scope is large enough to justify the extra handoff and context cost.
- `plan` owns scope, task ordering, reprioritization, and selection of the single next task to execute.
- `execute` implements only the highest-priority ready task from the current plan, uses Clean Code, Clean Architecture, and SOLID pragmatically, and adds matching tests.
- `review` routes implementation issues to `refactor`, planning issues back to `plan`, and only sends clean work to `test`.
- `refactor` responds only to implementation issues, improves the design pragmatically, and then returns the work to `review`.
- `test` validates the current plan, reports defects back through `plan`, and must not keep retrying the same issue without a recorded state change.
- When one plan completes the full loop, stop and ask whether to continue with the next plan.
- Do not skip `review` or `test` for non-trivial work.

## Commands And Agents
- Workflow skills live in `.claude/skills/workflow-*/`.
- Role definitions live in `.claude/agents/`.
- Local permission overrides live in `.claude/settings.local.json`.
- Optional extensions should live under `extensions/` so the core workflow stays minimal.

## Documentation Boundaries
- Put durable repository knowledge in `<durable-docs-path>`.
- Put active change planning, task tracking, and acceptance updates in `<active-change-path>`.
- Put stable capability requirements in `<stable-spec-path>`.

## Language Rules
- If I write in English, fix only unnatural or incorrect English, briefly.
- If I write in Chinese, do not correct the Chinese; suggest natural English phrasing first, then continue with the technical response.
