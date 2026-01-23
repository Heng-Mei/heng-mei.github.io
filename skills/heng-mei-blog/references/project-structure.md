# Project Structure (Heng-Mei Blog)

## Top-level layout

- `hugo.toml` — site + theme configuration (FixIt).
- `content/` — all site content (posts, notes, algorithms).
- `archetypes/` — default front matter template (`archetypes/default.md`).
- `themes/FixIt/` — FixIt theme (submodule).
- `static/` — static assets copied as-is (avatar, favicon, etc.).
- `assets/` — Hugo asset pipeline files (SCSS/JS/images for processing).
- `resources/` — Hugo generated cache.
- `public/` — built site output (generated; don’t edit directly).
- `skills/` — project-specific skills and reference docs.

## Content layout in this repo

- `content/posts/` — primary blog posts and essays.
- `content/algorithms/` — algorithm notes/solutions.
- `content/notes/` — study notes.
- `content/**/_index.md` — section list pages.

Example post template used in this repo:
- `content/posts/doc-template.md`

## Theme and docs references

- Theme used: FixIt (`themes/FixIt`).
- FixIt documentation (submodule): `skills/heng-mei-blog/references/hugo-fixit-docs`.
- Hugo documentation (submodule): `skills/heng-mei-blog/references/hugo`.

## Fast navigation tips

- Search site config: `hugo.toml`.
- Search posts for usage patterns: `rg -n "^\\+\\+\\+|^---" content`.
- FixIt config and syntax docs:
  - `skills/heng-mei-blog/references/hugo-fixit-docs/content/zh-cn/documentation/getting-started/configuration/index.md`
  - `skills/heng-mei-blog/references/hugo-fixit-docs/content/zh-cn/documentation/content-management/markdown-syntax/extended/index.md`
  - `skills/heng-mei-blog/references/hugo-fixit-docs/content/zh-cn/documentation/content-management/introduction/index.md`
