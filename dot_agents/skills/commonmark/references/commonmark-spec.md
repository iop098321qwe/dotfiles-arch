# CommonMark 0.31.2 Reference

Source: <https://spec.commonmark.org/0.31.2/>

Derived from "CommonMark Spec" Version 0.31.2 (2024-01-28) by John
MacFarlane.

License: Creative Commons Attribution-ShareAlike 4.0 International
License (<https://creativecommons.org/licenses/by-sa/4.0/>).

## Purpose

- This file is a local derived reference for the `commonmark` skill.
- It keeps the upstream section order and preserves the rules, terms,
  precedence, and compatibility notes most likely to matter during
  Markdown editing.
- It condenses repetitive examples and background prose.
- If this file and the upstream spec ever diverge, the upstream spec is
  authoritative.

## Structure

- `1 Introduction`: background, motivation, and conformance model.
- `2 Preliminaries`: character classes, escaping, tabs, and entities.
- `3 Blocks and inlines`: the high-level parsing model.
- `4 Leaf blocks`: headings, code blocks, HTML blocks, paragraphs, and
  reference definitions.
- `5 Container blocks`: block quotes, list items, and lists.
- `6 Inlines`: code spans, emphasis, links, images, HTML, and line
  breaks.
- `Appendix`: the two-phase parsing strategy used by the spec.

## 1 Introduction

### 1.1 What is Markdown?

- Markdown is a plain-text format for structured documents.
- Its design goal is readability of the source text itself.
- CommonMark standardizes Markdown behavior so the same source parses the
  same way across implementations.

### 1.2 Why is a spec needed?

- Original Markdown documentation left many cases ambiguous.
- The CommonMark spec exists to resolve real parsing disagreements, not
  just obscure edge cases.

Ambiguities the spec explicitly addresses include:

- how much indentation a sublist needs
- whether a blank line is needed before headings or block quotes
- whether a blank line is needed before an indented code block
- when a list is tight versus loose
- whether list markers themselves may be indented
- whether a line is a thematic break or a list item
- whether changing marker types starts a new list
- precedence between code spans, links, emphasis, and block structure
- whether list items may contain headings
- whether empty list items are valid
- whether reference definitions may appear inside containers
- which duplicate reference definition wins

### 1.3 About this document

- The upstream spec uses Markdown-to-HTML examples as conformance tests.
- The HTML output in those examples is a test harness, not a claim that
  every rendering detail is part of the normative syntax.
- For example, URL percent-encoding details in rendered HTML may vary by
  renderer even when the parse is conforming.
- In upstream examples, the `→` character is used to show a tab.

## 2 Preliminaries

### 2.1 Characters and lines

- Any sequence of Unicode code points is a valid CommonMark document.
- A character is a Unicode code point.
- A line is zero or more characters other than carriage return or line
  feed, followed by a line ending or end of file.
- A line ending is one of:
  - line feed
  - carriage return not followed by line feed
  - carriage return followed by line feed
- A blank line contains only spaces or tabs, or no characters at all.

Character classes used throughout the spec:

- Unicode whitespace character: a Unicode `Zs` character, tab, line
  feed, form feed, or carriage return.
- Unicode whitespace: one or more Unicode whitespace characters.
- Tab: `U+0009`.
- Space: `U+0020`.
- ASCII control character: `U+0000` through `U+001F`, or `U+007F`.
- ASCII punctuation character: punctuation in the ASCII ranges used by
  the spec for escaping and delimiter logic.
- Unicode punctuation character: a character in Unicode category `P` or
  `S`.

### 2.2 Tabs

- Tabs are not globally expanded into spaces.
- In contexts where indentation affects block structure, tabs behave as
  if expanded to tab stops every 4 columns.
- A tab can therefore stand in for four spaces in an indented code
  block.
- Internal tabs inside code remain literal tabs.
- Tabs can change container indentation in ways that are easy to misread,
  especially in lists and block quotes.

Practical consequences:

- A tab after a block quote marker can create enough indentation for an
  indented code block inside the quote.
- A tab after a list marker can change whether following content is a
  paragraph continuation, nested list, or code block.

### 2.3 Insecure characters

- `U+0000` must be replaced by the Unicode replacement character
  `U+FFFD`.

### 2.4 Backslash escapes

- Any ASCII punctuation character may be escaped with `\`.
- Escaped punctuation is treated as a literal character and loses its
  Markdown meaning.
- Backslashes before other characters stay literal.
- An escaped backslash does not escape the next character.
- A backslash at end of line creates a hard line break.

Backslash escapes do not work in:

- code spans
- indented code blocks
- fenced code blocks
- autolinks
- raw HTML

Backslash escapes do work in:

- link destinations
- link titles
- link reference definitions
- fenced code block info strings

Examples:

```markdown
\*not emphasized\*
\# not a heading
1\. not a list
```

```markdown
foo\
bar
```

### 2.5 Entity and numeric character references

- Valid HTML5 entity references and valid numeric character references are
  recognized almost everywhere except code spans and code blocks.
- They cannot replace structural syntax.
- `&#42;` is literal `*`, not an emphasis delimiter or list marker.
- Named entities must end with `;`.
- Decimal numeric references use `&#` plus 1 to 7 digits plus `;`.
- Hex references use `&#x` or `&#X` plus 1 to 6 hex digits plus `;`.
- Invalid code points become `U+FFFD`.
- Invalid entities stay literal text.

Important limits:

- Entity references do not work as substitutes for emphasis markers,
  list markers, thematic breaks, heading markers, or other structural
  tokens.
- Entity references in code spans and code blocks stay literal source
  text.

Examples:

```markdown
&amp; &copy; &#35; &#x22;
```

```markdown
\*foo\*
_foo_
```

The first line stays literal `*foo*`; the second produces emphasis.

## 3 Blocks and inlines

### 3.1 Precedence

- Block structure always takes precedence over inline structure.
- Parse block structure first.
- Parse inline structure second, after block boundaries are known.
- Link reference definitions are collected during block parsing and used
  later during inline parsing.

Example:

```markdown
- `one
- two`
```

This is a two-item list, not one list item containing a code span.

### 3.2 Container blocks and leaf blocks

- Container blocks can contain other blocks.
- Leaf blocks cannot contain blocks; they contain inline content or
  literal text.

Common container blocks:

- block quotes
- list items
- lists

Common leaf blocks:

- paragraphs
- headings
- thematic breaks
- code blocks
- HTML blocks
- link reference definitions

## 4 Leaf blocks

### 4.1 Thematic breaks

- A thematic break is a line with up to 3 leading spaces, followed by 3
  or more matching `-`, `_`, or `*` characters.
- Spaces and tabs may appear between those characters.
- Only spaces and tabs may appear besides the repeated marker.
- Four leading spaces is too much; that becomes indented code.

Rules to remember:

- The repeated marker characters must all be the same.
- `*-*` is not a thematic break.
- Blank lines before or after are not required.
- A thematic break can interrupt a paragraph.

Precedence rules:

- If a dash line could be either a thematic break or a setext heading
  underline, setext heading wins.
- If a line could be either a thematic break or a list item, thematic
  break wins.

Examples:

```markdown
---
---

---
```

```markdown
## Foo
```

The second example is a setext heading, not a paragraph plus a thematic
break.

### 4.2 ATX headings

- An ATX heading uses 1 to 6 unescaped `#` characters.
- The opening `#` run may be indented up to 3 spaces.
- The opening run must be followed by a space, a tab, or end of line.
- More than 6 `#` characters does not create a heading.
- The content is parsed as inline content.
- Optional closing `#` characters are allowed.

Closing sequence rules:

- The closing `#` run must be preceded by a space or tab.
- Only spaces or tabs may follow the closing run.
- Escaped `#` characters do not count as closing markers.

Compatibility note:

- Many Markdown implementations accept `#hashtag` as a heading.
- CommonMark does not. A space or tab is required after the opening run
  unless the heading is empty.

Examples:

```markdown
# foo

## foo

### foo
```

```markdown
#5 bolt
#hashtag
```

The second block is paragraph text, not headings.

### 4.3 Setext headings

- A setext heading is one or more lines of paragraph-like text followed
  by an underline of `=` or `-`.
- The text lines may be indented up to 3 spaces.
- The underline may be indented up to 3 spaces.
- `=` creates level 1; `-` creates level 2.
- The heading text is parsed as inline content.

Important behavior:

- Multi-line setext headings are allowed.
- The text lines must be interpretable as a paragraph if the underline
  were absent.
- The underline cannot contain internal spaces or tabs.
- Setext headings cannot be empty.
- A setext heading cannot interrupt an existing paragraph.

Blank-line rule:

- If a paragraph is followed by a setext heading, a blank line is needed
  to keep them separate.
- Without the blank line, the paragraph text becomes part of the heading.

Compatibility note:

- CommonMark explicitly allows multi-line setext headings.
- Many older implementations do not.

Examples:

```markdown
# Foo _bar_
```

```markdown
Foo
Bar

---
```

The second example is one multiline level-2 heading.

### 4.4 Indented code blocks

- An indented code block is one or more indented chunks.
- Each nonblank line in a chunk has at least 4 spaces of indentation.
- Blank lines may separate chunks.
- The block content is literal text with 4 spaces removed from each
  indented line.
- Indented code blocks have no info string.

Important behavior:

- An indented code block cannot interrupt a paragraph.
- A blank line is required between a paragraph and a following indented
  code block.
- If indentation could belong to a list item instead, the list-item
  interpretation wins.

Examples:

```markdown
    code
      more code
```

```markdown
Foo
bar
```

The second example stays inside the paragraph, not a code block.

### 4.5 Fenced code blocks

- A code fence is at least 3 consecutive backticks or at least 3
  consecutive tildes.
- Opening fences may be indented up to 3 spaces.
- The fence characters may not be mixed.
- An optional info string may follow the opening fence.
- If the opening fence uses backticks, the info string may not contain
  backticks.

Closing rules:

- The closing fence must use the same character as the opening fence.
- It must be at least as long as the opening fence.
- It may be indented up to 3 spaces.
- Only spaces or tabs may follow it.
- It has no info string.

Content behavior:

- Fenced code blocks can interrupt paragraphs.
- Blank lines before or after are not required.
- Content is literal text.
- If the opening fence was indented `N` spaces, up to `N` spaces are
  stripped from each content line.
- If no closing fence appears, the block runs to the end of the current
  container or the end of the document.

Gotchas:

- Four leading spaces before the opening fence produce an indented code
  block, not a fenced one.
- Common renderers often use the first word of the info string as a
  language name, but the spec does not standardize language handling.
- Unclosed fences do not trigger backtracking; they simply consume to the
  end.

Examples:

````markdown
```js
const x = 1;
```
````

```markdown

```

literal text

```

```

### 4.6 HTML blocks

HTML blocks begin after up to 3 spaces of indentation when the line
matches one of 7 start conditions.

Type 1:

- Start: `<pre`, `<script`, `<style`, or `<textarea` followed by a
  space, tab, `>`, or end of line.
- End: a line containing the corresponding end tag.

Type 2:

- Start: `<!--`
- End: the first following `-->`.

Type 3:

- Start: `<?`
- End: the first following `?>`.

Type 4:

- Start: `<!` followed by an ASCII letter.
- End: the first following `>`.

Type 5:

- Start: `<![CDATA[`.
- End: the first following `]]>`.

Type 6:

- Start: `<` or `</` followed by one of these block tag names:
  `address`, `article`, `aside`, `base`, `basefont`, `blockquote`,
  `body`, `caption`, `center`, `col`, `colgroup`, `dd`, `details`,
  `dialog`, `dir`, `div`, `dl`, `dt`, `fieldset`, `figcaption`,
  `figure`, `footer`, `form`, `frame`, `frameset`, `h1`, `h2`, `h3`,
  `h4`, `h5`, `h6`, `head`, `header`, `hr`, `html`, `iframe`,
  `legend`, `li`, `link`, `main`, `menu`, `menuitem`, `nav`,
  `noframes`, `ol`, `optgroup`, `option`, `p`, `param`, `search`,
  `section`, `summary`, `table`, `tbody`, `td`, `tfoot`, `th`,
  `thead`, `title`, `tr`, `track`, or `ul`.
- End: the next blank line.

Type 7:

- Start: a complete open tag or complete closing tag on a line by itself,
  excluding `pre`, `script`, `style`, and `textarea`.
- End: the next blank line.

General rules:

- Types 1 through 6 may interrupt paragraphs.
- Type 7 may not interrupt a paragraph.
- Once an HTML block starts, later lines that resemble Markdown remain
  raw until the block ends.
- Types 6 and 7 end on the next blank line rather than on balanced HTML.

Gotchas:

- Recognition is syntactic, not semantic. The spec does not validate that
  the HTML is well-formed.
- Type 6 can start from an opening tag, closing tag, or tag-like text
  that fits the HTML-block grammar.
- For types 6 and 7, insert a blank line if you want Markdown parsing to
  resume.

### 4.7 Link reference definitions

- A link reference definition begins with up to 3 leading spaces, then a
  label in `[]`, then `:`, then a link destination.
- Optional spaces or tabs may appear around the destination.
- At most one line ending may separate the label and destination.
- An optional title may follow, separated from the destination by spaces
  or tabs.
- The title may span lines but may not contain a blank line.
- `<>` is allowed as an empty destination.

Behavior and scope:

- Link reference definitions are metadata, not rendered content.
- They cannot interrupt a paragraph.
- They may appear before or after their uses.
- They may appear inside block quotes or list items and still apply to
  the whole document.
- Matching is case-insensitive after whitespace normalization.
- If multiple definitions normalize to the same label, the first one
  wins.

Things that prevent recognition:

- four-space indentation
- placement inside a code block
- extra trailing content after the definition

Examples:

```markdown
[foo]: /url "title"
```

```markdown
> [foo]: /url
```

The second example defines a reference for the document, not only for the
block quote.

### 4.8 Paragraphs

- A paragraph is a sequence of nonblank lines that could not instead be
  parsed as a different block.
- Paragraph contents are parsed as inline content.
- A paragraph ends at a blank line or when another block start takes over.

Important behavior:

- Final spaces or tabs are stripped before inline parsing.
- That means a paragraph ending with trailing spaces does not produce a
  hard line break at block end.
- Paragraphs are the default interpretation for text that is not claimed
  by a higher-precedence block rule.

### 4.9 Blank lines

- Blank lines separate many block structures, but they are not required
  everywhere.
- Blank lines can make a list loose.
- Blank lines can terminate HTML blocks of types 6 and 7.
- Blank lines are sometimes required to avoid accidental paragraph
  continuation.

Practical rule:

- If a block transition feels ambiguous, add the blank line unless the
  target syntax intentionally forbids or changes the result.

## 5 Container blocks

### 5.1 Block quotes

- A block quote marker is `>` with an optional following space.
- The marker may be indented up to 3 spaces.
- In the basic form, each quoted content line begins with its own marker.

Laziness rule:

- Paragraph continuation lines may omit the marker.
- This is called lazy continuation.
- Laziness only works for paragraph continuation lines.
- If the next unmarked line would start another block, omitting `>` ends
  the block quote instead.

Other behavior:

- Blank lines may appear inside block quotes.
- Empty block quotes are valid.
- A blank line is often needed between a block quote and a following
  normal paragraph to avoid lazy continuation.

Indentation gotcha:

- An indented code block inside a block quote needs enough indentation
  after accounting for the quote marker.

Example:

```markdown
> quote
> continued
```

The second line stays in the quote only because it is a lazy paragraph
continuation.

### 5.2 List items

- A list item starts with either a bullet list marker or an ordered list
  marker.
- Bullet markers are `-`, `+`, or `*`.
- Ordered markers use 1 to 9 digits followed by `.` or `)`.
- At least one following space or tab is required.

Indentation model:

- Let `W` be the width of the marker.
- Let `N` be the number of spaces after the marker, where `1 <= N <= 4`
  in the basic case.
- Content belongs to the item when it is indented `W + N` spaces past the
  current container context.
- The rule is based on marker width, not on a universal 2-space or
  4-space indent rule.

Special cases:

- If an item starts with indented code, only `W + 1` indentation is
  needed for the code block.
- If an item starts with one blank line, following content also uses the
  `W + 1` rule.

Interruption rules:

- A list item may interrupt a paragraph.
- If it does, an ordered item must start with `1`.
- An item that interrupts a paragraph may not start with a blank line.
- Empty list items cannot interrupt paragraphs.

Other gotchas:

- Thematic-break lines are never list items.
- Ordered markers may have leading zeros.
- Negative numbers are not list markers.
- Marker indentation over 3 spaces is not allowed.
- Empty items are valid.

Example:

```markdown
1.  item

    continuation paragraph
```

The continuation paragraph belongs to the item because its indentation is
measured from the marker width plus following spaces.

### 5.3 Lists

- A list is one or more list items of the same type.
- Bullet lists must use the same bullet character throughout a single
  list.
- Ordered lists must use the same delimiter throughout a single list:
  either all `.` or all `)`.
- The ordered-list start number comes from the first item only.
- Later explicit numbers do not affect the list numbering model.

Tight versus loose:

- A list is loose if items are separated by blank lines.
- A list is also loose if an item directly contains two block elements
  separated by a blank line.
- Otherwise, the list is tight.

Practical consequences:

- Tight lists usually render item paragraphs without surrounding `<p>`.
- Loose lists render those paragraphs as full paragraphs.
- Outer and inner lists can differ. One may be tight while the other is
  loose.

Separation rules:

- Changing bullet character starts a new list.
- Changing ordered delimiter starts a new list.
- Blank lines alone do not split same-type lists.
- If two same-type lists must be separate with no visible content between
  them, a blank HTML comment is the usual separator.

Example:

```markdown
1. one

2. two
3. three
```

This is one loose list, not two separate ordered lists.

## 6 Inlines

### 6.1 Code spans

- A backtick string is one or more backticks not immediately preceded or
  followed by another backtick.
- A code span opens and closes with equal-length backtick strings.

Normalization rules:

- Line endings inside the code span become spaces.
- If the resulting text begins and ends with a space, and is not all
  spaces, strip exactly one space from both ends.
- Only ordinary spaces are stripped by that rule.

Precedence and behavior:

- Code spans bind tighter than emphasis and links.
- Backslashes are literal inside code spans.
- Unmatched backticks stay literal.
- Use longer backtick strings to include literal backticks in code.

Examples:

```markdown
`` `code` ``
```

```markdown
`a
b`
```

The second example becomes a single code span with a space between `a`
and `b`.

### 6.2 Emphasis and strong emphasis

The emphasis algorithm is delimiter-based rather than purely regular.

Core terms:

- A delimiter run is a sequence of one or more `*` or one or more `_`
  characters that is not immediately adjacent to an unescaped matching
  character.
- A left-flanking delimiter run can open based on surrounding whitespace
  and punctuation rules.
- A right-flanking delimiter run can close based on surrounding
  whitespace and punctuation rules.

Opening and closing rules:

- `*` can open emphasis when left-flanking.
- `*` can close emphasis when right-flanking.
- `_` can open or close, but intraword use is more restricted.
- `**` and `__` follow the same logic for strong emphasis.

Matching rules:

- Opening and closing delimiters must use the same character.
- They must come from separate delimiter runs.
- If one side can both open and close, the sum-of-run-lengths mod-3 rule
  applies unless both run lengths are themselves multiples of 3.

Resolution preferences the spec preserves:

- Prefer fewer nestings over more nestings.
- Prefer `<em><strong>...</strong></em>` over the reverse nesting when
  both are possible.
- When spans overlap, earlier closers win.
- With the same closer, the later opener wins.

Practical guidance:

- Intraword `*` emphasis is allowed.
- Intraword `_` emphasis is generally disallowed unless punctuation rules
  allow it.
- Code spans, links, images, and raw HTML bind tighter than emphasis.
- If the intended emphasis is visually unclear, rewrite rather than rely
  on a tricky delimiter interaction.

Examples:

```markdown
_foo *bar* baz_
```

```markdown
foo_bar_baz
```

The second example stays literal under CommonMark.

### 6.3 Links

Link text:

- Link text is inline content inside `[]`.
- Links may not contain other links.
- Link text may contain code spans, emphasis, images, and raw HTML.

Inline links:

- An inline link is link text immediately followed by `(` and `)`.
- No whitespace is allowed between the closing `]` and the opening `(`.
- The destination may be:
  - enclosed in `<...>`
  - or a bare destination with no spaces or control characters and only
    balanced parentheses unless escaped
- An optional title may follow the destination.

Title forms:

- `"title"`
- `'title'`
- `(title)`

Reference links:

- Full reference: `[text][label]`
- Collapsed reference: `[text][]`
- Shortcut reference: `[text]`

Label rules:

- A label needs at least one non-whitespace character.
- Unescaped brackets are not allowed inside the label.
- Labels normalize by trimming, collapsing internal whitespace, and doing
  Unicode case folding.
- The first matching reference definition wins.
- Labels are limited to 999 characters.

Precedence rules:

- Inline links beat reference links.
- Full and collapsed reference links beat shortcut references.
- Code spans, autolinks, and raw HTML tags bind tighter than link
  brackets.
- Link grouping binds tighter than emphasis.

Gotchas:

- Empty inline link text and empty inline destinations are allowed.
- Empty reference labels are not allowed.
- `[link] (url)` is not a link because whitespace breaks adjacency.
- `[link]("title")` treats `"title"` as the destination, not the title.
- A nonbreaking space does not count as the normal separator between a
  destination and title.

### 6.4 Images

- Images use the same forms as links, but begin with `![`.
- Image descriptions follow the same bracketed-inline rules as link text.
- Unlike link text, image descriptions may contain links.
- Inline, full-reference, collapsed-reference, and shortcut-reference
  image forms all reuse the link destination and title grammar.

Accessibility note from the spec model:

- A renderer that produces HTML should use the plain textual content of
  the description as the image `alt` text.
- Formatting is stripped from that `alt` text.

Gotchas:

- Empty alt text is allowed.
- Escape `[` if you need literal text that would otherwise start an
  image description.
- Escape `!` if you need a literal `!` before a normal link.

### 6.5 Autolinks

- Autolinks are only recognized inside `<...>`.
- They must be either:
  - an absolute URI
  - or an email address matching the HTML5-style grammar used by the spec

URI rules:

- The scheme must be 2 to 32 characters.
- It must start with an ASCII letter.
- Remaining scheme characters may be ASCII letters, digits, `+`, `.`, or
  `-`.
- After `:`, the URI may not contain spaces, control characters, `<`, or
  `>`.

Email rules:

- Email autolinks render as `mailto:` links.
- Uppercase addresses are allowed.

Gotchas:

- Bare URLs like `https://example.com` are not autolinks in CommonMark.
- Backslash escapes do not work inside autolinks.
- Many syntactically valid URI schemes are allowed even if they are not
  common on the public web.

### 6.6 Raw HTML

- Inline raw HTML is recognized when text matches one of the inline HTML
  tag forms defined by the spec.
- This includes:
  - open tags
  - closing tags
  - comments
  - processing instructions
  - declarations
  - CDATA sections

Behavior:

- Raw HTML binds tighter than emphasis and links.
- Invalid tag syntax falls back to literal text.
- The spec parses and preserves raw HTML; it does not sanitize it.
- Entities inside attributes remain part of the raw HTML source.
- Backslash escapes do not work inside raw HTML attributes.

### 6.7 Hard line breaks

- Outside code spans and HTML tags, a line ending becomes a hard line
  break when it is preceded by 2 or more spaces.
- A backslash before the line ending also creates a hard line break.
- The line ending must not be at the end of a block.
- Leading spaces on the next line are ignored.

Practical guidance:

- The backslash form is clearer than relying on trailing spaces.
- Trailing spaces or backslashes at the end of a paragraph or heading do
  not create a hard line break.

### 6.8 Soft line breaks

- Any other regular line ending outside code spans and HTML tags is a
  soft line break.
- Trailing spaces on the previous line and leading spaces on the next are
  removed as part of soft-break handling.
- A renderer may emit either a literal line ending or a space for a soft
  break.

Practical note:

- Hard-wrapped source text usually does not force a visible line break in
  rendered output.

### 6.9 Textual content

- Anything not consumed by earlier inline rules is literal text.
- CommonMark generally leaves nearly-valid markup as text rather than
  raising syntax errors.
- Internal spaces are preserved verbatim unless a specific inline rule
  says otherwise.

## Appendix: A parsing strategy

### Overview

- The upstream spec describes parsing as a two-phase process.
- Phase 1 discovers block structure and reference definitions.
- Phase 2 parses inline structure inside leaf blocks that accept inlines.

### Phase 1: block structure

- Read lines in order.
- Maintain the open container stack.
- Check whether each line continues existing containers.
- Open new containers or leaf blocks when matching block-start rules.
- Finalize blocks when a line can no longer continue them.
- Collect link reference definitions during this pass.

### Phase 2: inline structure

- Parse paragraphs, headings, and other inline-capable leaf blocks.
- Resolve code spans, raw HTML, autolinks, links, images, and emphasis
  using the collected reference definitions.
- Because block structure is already fixed, inline parsing can be treated
  separately per block.

## Editing heuristics for skill use

- Prefer explicit fenced code blocks over indentation when preserving the
  parse matters more than matching a particular visual style.
- Prefer ATX headings over setext headings when moving content around,
  unless the file clearly standardizes on setext headings.
- Add blank lines when switching between paragraphs, lists, headings,
  thematic breaks, and HTML blocks if the transition is at all ambiguous.
- Do not rely on intraword underscore emphasis.
- Avoid shortcut reference links when the same label could become
  ambiguous after edits.
- When a raw HTML block is already present, inspect its start and end
  conditions before inserting Markdown nearby.
