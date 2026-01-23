# FixIt Docs Map (Submodule)

FixIt docs live in `skills/heng-mei-blog/references/hugo-fixit-docs`.

## Most important docs (start here)

- Theme configuration (full list):
  - `content/zh-cn/documentation/getting-started/configuration/index.md`
- Content management overview + front matter:
  - `content/zh-cn/documentation/content-management/introduction/index.md`
- Markdown extensions (FixIt flavored markdown):
  - `content/zh-cn/documentation/content-management/markdown-syntax/extended/index.md`

## Specialized topics

- Shortcodes (extended):
  - `content/zh-cn/documentation/content-management/shortcodes/extended/introduction/index.md`
- Mermaid diagrams:
  - `content/zh-cn/documentation/content-management/diagrams-support/mermaid/index.md`
- MathJax support:
  - `content/zh-cn/documentation/content-management/mathjax-support/index.md`
- JSON viewer:
  - `content/zh-cn/documentation/content-management/json-viewer/index.md`
- Related content:
  - `content/zh-cn/documentation/content-management/related/index.md`
- Advanced configuration (admonition/task list/custom partials):
  - `content/en/documentation/advanced/index.md` (English, but has the most examples)

## Theme defaults

- Theme default config file:
  - `skills/heng-mei-blog/references/hugo-fixit-docs` points to the FixIt repo,
    but the authoritative default config is in `themes/FixIt/hugo.toml` (submodule).

## Search tips

From repo root:

```bash
rg -n "params\.page|params\.home|params\.footer|params\.header" \
  skills/heng-mei-blog/references/hugo-fixit-docs/content/zh-cn/documentation/getting-started/configuration/index.md
```
