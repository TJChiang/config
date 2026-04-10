# Template Extensions

This directory contains optional add-ons for the core Claude workflow template.

The core template is intentionally minimal:
- `.claude/agents/`
- `.claude/skills/workflow-*`
- `.claude/settings.local.json`
- `CLAUDE.md`

Use the extensions only when the target repository actually benefits from them.

## Available Extensions

### `openspec/`

Adds OpenSpec-specific workflow support:
- `openspec-*` skills
- `opsx/*` command wrappers

Use this extension when:
- the repository already uses OpenSpec
- the team wants change proposals, design docs, specs, and tasks managed through OpenSpec
- the workflow should drive implementation from OpenSpec artifacts

Do not use this extension when:
- the repository uses a different planning system
- the team prefers lightweight planning in issues, docs, or tickets
- OpenSpec commands are not installed in the environment

### `specialized-agents/`

Adds more opinionated role-specific agents:
- `domain`
- `server`
- `reference-alignment`
- `test-guard`

Use this extension when:
- the repository benefits from stronger role specialization
- the team wants agents focused on core logic, delivery-layer code, reference alignment, or testing strategy
- the core workflow agents feel too general for the codebase

Do not use this extension when:
- the repository is small and the core agents are enough
- the extra roles would create unnecessary complexity
- the repository does not have clear architectural boundaries that justify specialized prompts

## Installation Approach

Copy only the extension directories you want into the target repository and merge their `.claude/` contents into the root `.claude/` directory.

After copying:
1. Review the prompts and remove any rules that do not fit the target repository.
2. Update `CLAUDE.md` if the extension changes the expected workflow.
3. Adjust `.claude/settings.local.json` if the extension introduces commands that should be auto-allowed.
