# Claude Workflow Template

This directory is a reusable starter built from the repository's current Claude Code workflow.

## What It Contains

- `CLAUDE.md`: top-level workflow guide with placeholders for project-specific context
- `.claude/agents/`: core workflow subagents for planning, execution, review, refactor, QA, and exploration
- `.claude/skills/`: core `workflow-*` skills for the delivery loop
- `.claude/settings.local.json`: local permission defaults for the core workflow
- `extensions/openspec/`: optional OpenSpec-specific skills and commands
- `extensions/specialized-agents/`: optional role-specific agents for domain, interface, reference-alignment, and test-guard work

## How To Use

1. Copy `CLAUDE.md` to the target repository root as `CLAUDE.md`.
2. Copy `.claude/` to the target repository root.
3. Edit `CLAUDE.md` first and replace every placeholder such as `<project-goal>` and `<docs-entrypoint>`.
4. Keep only the parts you want:
   - `.claude/agents/`, `.claude/skills/workflow-*`, and `.claude/settings.local.json` are the core template.
   - `extensions/openspec/` is optional if the target repo uses OpenSpec.
   - `extensions/specialized-agents/` is optional if the target repo wants more role-specific agent prompts.
5. Adjust `.claude/settings.local.json` to match the commands you actually want Claude Code to auto-allow.

## Customization Notes

- The workflow assumes a delivery loop of `plan -> execute -> review -> refactor -> review -> test`.
- The core template is only the workflow plus its core subagents and `workflow-*` skills.
- OpenSpec-specific files live entirely under `extensions/openspec/`.
- More opinionated non-core agents live under `extensions/specialized-agents/`.
- If you change the live workflow later, mirror the relevant changes back into this template so it does not drift.
