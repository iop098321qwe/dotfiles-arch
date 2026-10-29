# AGENTS.md completeness checklist

## Repository facts

- Entry points and main executables are identified.
- Build system and package manager(s) are documented.
- Runtime versions and toolchain versions are listed.
- Required env vars and secrets handling are described.
- Local setup steps are accurate and minimal.

## Commands and workflows

- Build, run, test, lint, format, and type-check commands are present.
- Commands reference the correct paths and config files.
- CI checks and required status gates are documented.
- Release and deploy steps are current.
- Commit rules require standalone changelog-ready headers, supplemental
  bodies and PR descriptions, and impact-based types. Release filters
  and section mappings are verified or marked as unknown.

## Architecture and structure

- Top-level directories are explained.
- Tracked source and config files are listed in directory order with
  one-line purposes.
- Tracked generated output is summarized at directory level or
  explicitly excluded from per-file listing.
- Core modules and boundaries are documented.
- Data flow and integration points are summarized.

## Standards and practices

- Best practices and industry standards are explicitly required.
- Security practices and secret handling are stated.
- Logging, error handling, and observability are described.
- Coding conventions and naming standards are included.
- The `todo.txt` manual-only protection rule is explicitly stated.

## Markdown quality

- Lines are <= 80 characters, exceptions documented.
- Section order matches the template.
- Bullets are short and action-focused.
- No stale or duplicated content remains.
- No update notes or logs appear in AGENTS.md.
