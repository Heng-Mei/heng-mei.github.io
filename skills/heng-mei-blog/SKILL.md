---
name: heng-mei-blog
description: Project guide for the Heng-Mei Hugo + FixIt blog. Use when working in this repo to understand structure, author content, adjust site or theme config (hugo.toml), and locate FixIt/Hugo documentation in the bundled submodules.
---

# Heng-Mei Blog Skill

## Overview

Use this skill to quickly understand the repository layout, author posts, and navigate FixIt/Hugo documentation without external web browsing.

## Quick start (read in order)

1. Repo map: `skills/heng-mei-blog/references/project-structure.md`
2. Actual site config summary: `skills/heng-mei-blog/references/hugo-toml-summary.md`
3. Content authoring guide: `skills/heng-mei-blog/references/content-format.md`
4. FixIt config map: `skills/heng-mei-blog/references/fixit-config-summary.md`
5. FixIt markdown summary: `skills/heng-mei-blog/references/fixit-markdown-summary.md`
6. Markdownlint guide: `skills/heng-mei-blog/references/markdownlint-guide.md`
7. Deep docs locations:
  - FixIt: `skills/heng-mei-blog/references/fixit-docs-map.md`
  - Hugo: `skills/heng-mei-blog/references/hugo-docs-map.md`

## Core workflows

### 1) Understand repo structure

- Read `skills/heng-mei-blog/references/project-structure.md`.
- Confirm where content lives (`content/`), where theme lives (`themes/FixIt`), and where site config lives (`hugo.toml`).

### 2) Add or edit posts

- Read `skills/heng-mei-blog/references/content-format.md`.
- Use TOML front matter (`+++`).
- Follow existing section structure (`content/posts`, `content/algorithms`, `content/notes`).
- Use FixIt markdown extensions (alerts, math, shortcodes) when needed.

### 3) Adjust site config

- Read `skills/heng-mei-blog/references/hugo-toml-summary.md` to see current settings.
- For FixIt options not in this repo, consult `skills/heng-mei-blog/references/fixit-config-summary.md` and then open the FixIt doc files referenced there.

### 4) Resolve formatting/feature questions

- Search FixIt docs in `skills/heng-mei-blog/references/hugo-fixit-docs`.
- Search Hugo docs in `skills/heng-mei-blog/references/hugo/docs`.

## Local references (bundled docs)

- FixIt docs (submodule): `skills/heng-mei-blog/references/hugo-fixit-docs`
- Hugo docs (submodule): `skills/heng-mei-blog/references/hugo`
- Markdownlint docs (submodule): `skills/heng-mei-blog/references/vscode-markdownlint`

## Practical search commands

```bash
rg -n "params\.page|params\.home|params\.footer|params\.header" hugo.toml
rg -n "admonition|alert|markdown" skills/heng-mei-blog/references/hugo-fixit-docs/content/zh-cn
rg -n "front matter|page bundles|archetypes" skills/heng-mei-blog/references/hugo/docs/content/en
```

## Output expectations for future chats

- Start with the repo map and current config summary.
- If a format or shortcode is needed, check FixIt docs first.
- If a core Hugo behavior is unclear, check Hugo docs.

## Git commit conventions

Use Conventional Commits, following the patterns already in this repo:

- `docs: ...`
- `docs(scope): ...`

Keep messages short and action-oriented.
Examples from this repo:

- `docs(skills): add skill docs and hugo/fixIt reference submodules`
- `docs(recommender): reorder subgraphs in flowchart`
