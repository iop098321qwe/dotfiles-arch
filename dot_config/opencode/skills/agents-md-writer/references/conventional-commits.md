# Conventional Commits requirement

## Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Types

- feat: new feature
- fix: bug fix
- docs: documentation change
- style: formatting-only change
- refactor: code change with no behavior change
- perf: performance improvement
- test: test-only change
- build: build system or dependencies
- ci: CI configuration change
- chore: maintenance work

## Examples

- feat(api): add token refresh endpoint
- fix(ui): handle empty state in dashboard
- docs: document release workflow
- refactor(parser): simplify AST traversal

## Rules

- Use present tense and imperative mood.
- Keep the summary concise and meaningful.
- Use scope when it improves clarity.
