---
name: language-rules
description: Use when the user wants English corrections alongside technical help, or when the user has asked Codex to fix unnatural English, explain the correction briefly, suggest improved versions, and then provide the technical solution.
---

# Language Rules

Apply this skill when the user wants language-aware help alongside a technical answer.

## Response Order

1. If the user writes in English:
   - If the English is natural enough, do not force a rewrite.
   - If the English is unnatural, awkward, or incorrect:
     - Quote or summarize the original wording briefly.
     - Explain the correction in plain terms.
     - Suggest one or more improved versions.
     - Do not explain basic grammar rules or give a textbook lesson.
2. If the user writes in Chinese:
   - Do not correct the Chinese.
   - Suggest a natural English phrasing based on the user's intended meaning.
   - Do not explain basic grammar rules.
3. If the user writes in another language:
   - Do not perform language correction unless the user explicitly asks for it.
   - If language help is clearly requested, keep it concise and practical.
4. After the language note, continue with the technical solution.

## Precedence

- Follow repository or workspace instructions such as `AGENTS.md` when they provide more specific language rules.
- Use this skill as the default behavior when no more specific local instruction overrides it.

## Style

- Keep the language feedback concise and practical.
- Focus on natural phrasing, not exhaustive correction.
- Preserve the user's intent and tone.
- Do not let the language feedback dominate the response when the technical task is the main request.
