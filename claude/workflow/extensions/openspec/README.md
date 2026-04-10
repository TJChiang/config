# OpenSpec Extension

This extension adds OpenSpec-specific planning and command support on top of the core workflow template.

## What It Adds

- `.claude/skills/openspec-*`
- `.claude/commands/opsx/*`

These files are intentionally outside the core template because they assume:
- OpenSpec is installed
- the repository uses OpenSpec as its planning system
- the team wants commands and skills built around OpenSpec artifacts

## When To Use It

Use this extension when:
- the repository already manages changes through OpenSpec
- the team wants proposal, design, spec, and task artifacts to drive implementation
- Claude should interact with OpenSpec commands directly during planning and execution

Do not use this extension when:
- the repository uses issues, tickets, docs, or another planning system instead
- OpenSpec is not installed in the environment
- the team wants the workflow without OpenSpec-specific commands and prompts

## Installation

Copy this extension's `.claude/` contents into the target repository's root `.claude/` directory.

After copying:
1. Review the `openspec-*` skills and remove any instructions that do not fit the target repository.
2. Review `opsx/*` command prompts and make sure the command names still match your intended workflow.
3. Update `.claude/settings.local.json` in the target repository if OpenSpec commands should be auto-allowed.
