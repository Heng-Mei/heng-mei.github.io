# CONTENT AUTHORING

All authored site content across 4 sections. TOML front matter only.

## SECTIONS

| Dir | Menu | Purpose | Layout |
|-----|------|---------|--------|
| `posts/` | 随想 | Essays / thoughts | flat `.md` files |
| `algorithms/` | 算法 | LeetCode solutions | flat; `weight = <LC number>` orders them |
| `dialogues/` | 共思录 | Faithful archives of public AI conversations | nested page bundles; see `dialogues/AGENTS.md` |
| `notes/` | 笔记 | Study notes | nested page-bundle dirs (e.g. `effective-modern-cpp/`) |

Each section has an `_index.md` (list page) using `[cascade]\ntype = "..."`.

## FRONT MATTER

```toml
+++
title = "标题"
date = "2025-12-21T00:00:00+08:00"   # ISO 8601 WITH +08:00 offset
lastmod = "2026-01-23T14:26:54+08:00"
tags = ["分治", "构造"]
categories = ["算法"]
collections = ["算法"]               # feeds the /collections/ taxonomy
draft = false
weight = 932                         # algorithms only: LC number
+++
```

- `title` + `date` required. `date` MUST carry the `+08:00` offset.
- New files scaffold from `../archetypes/default.md` (`draft = true` by default — flip to `false` to publish).
- Dialogue entries follow the stricter front matter and transcription contract in `dialogues/AGENTS.md`.

## FIXIT MARKDOWN

- **Alerts**: `> [!NOTE]`, `> [!TIP]+ 标题` (foldable), `> [!ABSTRACT]~` (no title). Full alias list in `../skills/heng-mei-blog/references/content-format.md`.
- **Math** (MathJax, `physics`+`xypic` enabled): inline `$...$` / `\(...\)`, block `$$...$$` / `\[...\]`.
- **Mermaid**: fenced ```mermaid blocks.
- A `---` after an admonition is cosmetic, not syntax.

## IMAGES / RESOURCES

Preference order: page-bundle (same folder as the `.md`) → `../assets/` (pipeline) → `../static/` (served as-is). Existing page-bundle images live under `../static/posts/<slug>/`.

## GOTCHAS

- `params.page.toc.auto = false` in `hugo.toml` — a page TOC only renders if you set `toc = true` in that page's front matter.
- MathJax passthrough is on: a bare `$` outside a math span gets parsed as math. Escape as `\$` or wrap in a code fence.
- New posts are `draft = true` by default and CI does NOT build drafts — flip to `draft = false` to publish.

## ANTI-PATTERNS

- No YAML front matter (`---`) — TOML `+++` only.
- Do NOT drop the timezone offset on `date`/`lastmod`.
- `doc-template.md` in `posts/` is a reusable C++/C-API doc template, not a real post — copy it, don't treat it as published content.
