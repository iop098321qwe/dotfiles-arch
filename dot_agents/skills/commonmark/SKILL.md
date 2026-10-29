---
name: commonmark
description: >-
  Edit and review Markdown files using CommonMark-first rules. Use when
  working in `.md` files, rewriting Markdown structure, resolving syntax
  ambiguities around headings, lists, block quotes, code fences, links,
  emphasis, raw HTML, or line breaks, or deciding whether existing Markdown
  depends on a repo-specific dialect. Check repo or file-specific Markdown
  rules first; if none are verified, default to CommonMark 0.31.2. Do not use
  this skill for files inside an Obsidian vault with a `.obsidian/` parent.
---

# commonmark

## Default dialect

- Read repo or file-specific docs, tooling, and surrounding files first.
- If the repo explicitly uses GFM, MDX, Docusaurus, Obsidian, or another
  dialect, follow that verified dialect where it differs from CommonMark.
- If no verified override exists, treat CommonMark 0.31.2 as the default
  Markdown syntax and behavior model.
- Use `references/commonmark-spec.md` as the local reference for syntax
  rules, precedence, and tricky edge cases.

## Editing rules

- Preserve the existing document structure and voice unless the user asks
  for a rewrite.
- Make the smallest change that gives the intended parse result under the
  verified dialect.
- Prefer syntax that is unambiguous under CommonMark: explicit fences,
  clear blank-line separation, stable indentation, and explicit link or
  image forms.
- Avoid introducing extension-only syntax such as tables, task lists,
  footnotes, strikethrough, or autolink literals unless the repo already
  uses them or the user explicitly wants them.
- Keep heading levels consistent and do not skip levels unless the file
  already uses that structure intentionally.
- Avoid raw HTML unless Markdown cannot express the requirement or the file
  already relies on HTML.
- Reflow edited prose to the file's established line-length convention. If
  no convention is obvious, prefer about 80 characters per line.
- Never make direct changes to `CHANGELOG.md`. Follow repo release tooling
  or ask for guidance.

## Obsidian exception

- Before editing a Markdown file, check its parent directories.
- If any parent contains `.obsidian/`, treat the file as an Obsidian vault
  file and do not use this skill.
- Fall back to repo-specific instructions for that vault instead of
  applying CommonMark defaults.

## Ambiguity checks

- Read `references/commonmark-spec.md` before changing syntax when the edit
  involves:
  - ambiguous list indentation or list interruption
  - setext versus thematic break behavior
  - fenced versus indented code block behavior
  - link reference definitions
  - nested emphasis, code spans, or links and images
  - raw HTML blocks or inline raw HTML
  - hard versus soft line breaks
- When repo behavior is unclear, prefer syntax that is valid in both
  CommonMark and common extended dialects.

## Workflow

1. Inspect the target file and nearby repo guidance for dialect or
   formatting rules.
2. Decide whether CommonMark or a verified override controls the edit.
3. Consult `references/commonmark-spec.md` for ambiguous parsing rules.
4. Apply only the necessary Markdown changes.
5. Re-read the affected blocks and inline spans to confirm they still
   parse the intended way.
