# AGENTS.md self-audit loop

## When to run

- After any code change (feature, fix, refactor, config, or docs).
- After dependency updates, build script changes, or CI changes.
- After new directories, services, or workflows are introduced.

## Audit steps

1. Re-scan the repo structure and tooling.
2. Re-scan tracked files and update the file list section.
3. Verify all commands still run and point to the right files.
4. Compare AGENTS.md sections to current repo state.
5. Update AGENTS.md where mismatches exist.
6. Remove any update notes or logs from AGENTS.md.

## Failure rules

- If AGENTS.md conflicts with the repo, the file must be updated.
- Do not leave known mismatches in place.
