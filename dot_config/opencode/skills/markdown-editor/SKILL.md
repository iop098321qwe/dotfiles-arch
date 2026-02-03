---
name: markdown-editor
description: "Edit or update Markdown files (.md) following best practices and
industry standards. ALWAYS use for any .md edit or review, even if the user does
not explicitly request it, unless the file is inside a directory that contains a
.obsidian/ folder (treat as Obsidian vault and do not use this skill)."
---

# Markdown editing guidance

## Core rules

- Always invoke this skill for any .md edit or review unless the Obsidian
  exception applies.
- Use GitHub Flavored Markdown unless the repo specifies otherwise.
- Preserve the existing file style and structure.
- Keep heading levels consistent and sequential.
- Add blank lines around headings, lists, and code blocks.
- Avoid raw HTML unless Markdown cannot express the requirement.
- Default to 80 characters per line, but preserve the established line-length
  convention when it is clearly present in the file.

## Obsidian exception

- Before editing any .md file, check its parent directories.
- If any parent directory contains a `.obsidian/` folder, treat the file as an
  Obsidian vault file and do not use this skill.

## Editing workflow

1. Read the file and identify the existing style and conventions.
2. Apply only the necessary changes while preserving formatting.
3. Reflow lines to the correct line-length rule when editing text.
4. Re-check headings, spacing, and list formatting for consistency.
