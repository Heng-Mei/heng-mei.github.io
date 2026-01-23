# Markdownlint Guide (VS Code Extension)

This repo uses the `DavidAnson.vscode-markdownlint` extension for Markdown linting.
The extension is included as a reference submodule at:

- `skills/heng-mei-blog/references/vscode-markdownlint`

## Project configuration

Local config file:

- `.markdownlint.json`

Current settings:

- `MD013` disabled (line-length)
- `MD041` enabled with `front_matter_title: "title"` to support Hugo front matter
- `MD033` disabled (inline HTML), which is common in Hugo/shortcode content

## Key rules to keep in mind

- Headings must be surrounded by blank lines (MD022).
- Lists must be surrounded by blank lines (MD032).
- Fenced code blocks must be surrounded by blank lines (MD031) and specify a language (MD040).
- No bare URLs in prose; wrap with Markdown links (MD034).
- Avoid trailing whitespace and multiple blank lines (MD009, MD012).

## How to use in VS Code

- Run `markdownlint.lintWorkspace` to scan all Markdown files.
- Run `Format Document` or `markdownlint.fixAll` to auto-fix supported rules.

## References

- Extension README: `skills/heng-mei-blog/references/vscode-markdownlint/README.md`
- Rules list: `skills/heng-mei-blog/references/vscode-markdownlint/README.md` (Rules section)
