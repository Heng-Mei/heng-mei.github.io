# SKILLS & REFERENCES

AI-agent tooling for this repo. `heng-mei-blog/SKILL.md` is the project guide; `references/` bundles Hugo/FixIt/markdownlint docs as **git submodules** for offline lookup.

## LAYOUT

```text
heng-mei-blog/
├── SKILL.md                    # project guide (read this first)
└── references/
    ├── *.md                    # 8 hand-written summaries (EDITABLE)
    ├── hugo/                   # submodule: gohugoio/hugo (READ ONLY)
    ├── hugo-fixit-docs/        # submodule: hugo-fixit/docs (READ ONLY)
    └── vscode-markdownlint/    # submodule: DavidAnson/vscode-markdownlint (READ ONLY)
```

## WHERE TO LOOK

| Need | File |
|------|------|
| Repo map / authoring / config summaries | `references/{project-structure,content-format,hugo-toml-summary}.md` |
| FixIt config + markdown syntax | `references/fixit-{config,markdown}-summary.md`, `references/fixit-docs-map.md` |
| Hugo API deep dive | `references/hugo-docs-map.md` → points into `references/hugo/docs/` |
| Lint rules | `references/markdownlint-guide.md` |

## ANTI-PATTERNS

- Do NOT edit the three submodule dirs (`hugo/`, `hugo-fixit-docs/`, `vscode-markdownlint/`) — pin/update via `git submodule`, never hand-edit.
- Hand-written `references/*.md` summaries ARE editable, but keep them in sync with the real `hugo.toml` / theme when config changes.
