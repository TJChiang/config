# Specialized Agents Extension

This extension adds more opinionated role-specific agent prompts on top of the core workflow template.

## What It Adds

- `domain`
- `server`
- `reference-alignment`
- `test-guard`

These agents are separated from the core template because they are useful only when the repository has enough architectural or workflow complexity to justify narrower roles.

## When To Use It

Use this extension when:
- the repository has clear architectural boundaries
- the team wants more explicit separation between core logic, interface work, reference comparison, and validation strategy
- the default core agents feel too general for the work

Do not use this extension when:
- the repository is small or straightforward
- the extra roles would mostly duplicate the core workflow agents
- the team prefers fewer, broader prompts

## Agent Notes

- `domain`: focused on core logic, persistence, and shared business rules
- `server`: focused on interfaces, handlers, entrypoints, and delivery-layer work
- `reference-alignment`: focused on comparing current behavior against a reference implementation, contract, or legacy system
- `test-guard`: focused on regression risk and validation scope

## Installation

Copy this extension's `.claude/agents/` contents into the target repository's root `.claude/agents/` directory.

After copying:
1. Remove any agents that the target repository does not need.
2. Tune the prompts so they match the repository's architecture and vocabulary.
3. If these agents change the way the team uses the workflow, reflect that in `CLAUDE.md`.
