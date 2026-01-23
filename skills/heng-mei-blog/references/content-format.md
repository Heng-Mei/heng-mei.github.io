# Content Formats and Authoring Guide

This project uses **Hugo + FixIt**. Most content is written in Markdown with TOML front matter (`+++`).

## Where to put content

- Blog posts: `content/posts/*.md`
- Algorithms: `content/algorithms/*.md`
- Notes: `content/notes/**/` (may include subfolders)
- Section list pages: `_index.md` inside each section folder

## Front matter (this repo)

Use TOML front matter by default. Minimal example:

```toml
+++
title = "Title"
date = "2025-01-01T10:00:00+08:00"
+++
```

Common fields used in this repo:

- `title`, `date`
- `tags`, `categories`, `collections`
- `draft = true|false`

Sample from `content/posts/doc-template.md`:

```toml
+++
title = "通用算法模块文档模板（C++ / C API）"
date = "2025-12-26T10:00:00+08:00"
tags = ["cpp", "文档"]
categories = ["cpp"]
+++
```

## FixIt Markdown extensions you can use

These are common FixIt Flavored Markdown features (see FixIt docs for the full list):

### 1) Alerts / Admonitions

FixIt supports GitHub/Obsidian-style alerts:

```markdown
> [!NOTE]
> 提示内容

> [!TIP]+ 可折叠标题
> 可折叠内容

> [!ABSTRACT]~
> 仅内容，无标题
```

Supported types include: `note`, `abstract/summary/tldr`, `info`, `todo`, `tip`,
`success`, `question/help/faq`, `warning`, `caution`, `failure/fail/missing`, `danger`, `bug`, `example`, `quote`.

### 2) Math / LaTeX

This site enables MathJax and Goldmark passthrough. You can use:

- Inline: `$ ... $` or `\( ... \)`
- Block: `$$ ... $$` or `\[ ... \]`

Example:

```markdown
行内公式 $E=mc^2$。

$$
\rho \frac{\mathrm{D} \mathbf{v}}{\mathrm{D} t}=\nabla \cdot \mathbb{P}+\rho \mathbf{f}
$$
```

MathJax packages enabled: `physics`, `xypic` (see `hugo.toml`).

### 3) Mermaid (if enabled in theme)

FixIt supports Mermaid diagrams; configure in `params.mermaid` (see FixIt docs). Example:

````markdown
```mermaid
flowchart TB
  A --> B
```
````

### 4) Shortcodes

FixIt adds many shortcodes (tabs, code, links, image processing, etc.).
See `skills/heng-mei-blog/references/fixit-docs-map.md` for the exact doc locations.

## Local resources (images, files)

Preferred order (FixIt docs):

1. Page bundle resources (same folder as the page)
2. `assets/` (pipeline)
3. `static/` (served as-is)

## Archetypes

Default front matter template in `archetypes/default.md`:

```toml
+++
date = '{{ .Date }}'
draft = true
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
+++
```

Use:

```bash
hugo new posts/your-post.md
```

## Useful local examples

- `content/posts/doc-template.md` — shows admonition usage and structure.
- `content/posts/_index.md` — section list page example.
