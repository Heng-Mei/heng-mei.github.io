# CONTENT AUTHORING

All authored site content across 4 sections. TOML front matter only.

## SECTIONS

- `posts/`：随想；essays / thoughts；flat `.md` files。
- `algorithms/`：算法；LeetCode solutions；flat files，使用
  `weight = <LC number>` 排序。
- `dialogues/`：共思录；faithful archives of public AI conversations；
  flat `.md` files，详见 `dialogues/AGENTS.md`。
- `notes/`：笔记；study notes；nested page-bundle directories，
  例如 `effective-modern-cpp/`。

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
- New files scaffold from `../archetypes/default.md`（默认 `draft = true`；
  发布前改为 `false`）。
- Dialogue entries follow the stricter front matter and transcription contract in
  `dialogues/AGENTS.md`.

## FIXIT MARKDOWN

- **Alerts**: `> [!NOTE]`, `> [!TIP]+ 标题`（foldable）、
  `> [!ABSTRACT]~`（no title）。完整别名见
  `../skills/heng-mei-blog/references/content-format.md`。
- **Math**（MathJax，启用 `physics` + `xypic`）：inline `$...$` /
  `\(...\)`，block `$$...$$` / `\[...\]`。
- **Mermaid**: fenced ```mermaid blocks.
- A `---` after an admonition is cosmetic, not syntax.

## TYPOGRAPHY

- 中文散文引号统一使用 `「…」`（角引号）。
- 机器解析上下文中保留原样，不做替换：行内/围栏代码、数学公式、URL、
  Markdown 链接目标、HTML 属性、Hugo shortcode/template 语法、TOML 定界符。

## IMAGES / RESOURCES

Preference order: page-bundle（与 `.md` 同目录）→ `../assets/`（pipeline）→
`../static/`（served as-is）。现有 page-bundle 图片位于
`../static/posts/<slug>/`。

## GOTCHAS

- `hugo.toml` 中 `params.toc.auto = false`；只有在页面 front matter
  中设置 `toc = true` 才会渲染目录。
- MathJax passthrough 已启用：数学定界符之外的裸 `$` 会被解析为公式。
  应转义为 `\$` 或放入代码围栏。
- 新文章默认 `draft = true`，CI 不构建草稿；发布前改为 `draft = false`。

## ANTI-PATTERNS

- No YAML front matter (`---`) — TOML `+++` only.
- Do NOT drop the timezone offset on `date`/`lastmod`.
- `posts/doc-template.md` 是可复用的 C++/C-API 文档模板，不是正式文章；
  应复制使用，不得当作已发布内容。
