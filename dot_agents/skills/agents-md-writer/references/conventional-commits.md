# Conventional Commits requirement

## Format

```
<type>[optional scope][!]: <description>

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
- Treat `<description>` as the short header subject, not the commit body.
- Write the header as a standalone changelog entry with the concrete outcome.
  Commit bodies and PR descriptions supply context omitted from entries.
- Choose types by actual impact, not file extension or branch name. Use `fix`
  for faulty skill workflow guidance, `feat` for new skill capability, and
  `docs` for explanation-only changes.
- Check verified release filters and section mappings; do not assume all types
  are published or mislabel a change to force changelog inclusion.
- Apply the same standalone-header check to squash-merge PR titles.
- Use `!` for breaking changes and keep required `BREAKING CHANGE:` footers;
  name the incompatible behavior in the header even if footers are omitted
  from the changelog entry.
