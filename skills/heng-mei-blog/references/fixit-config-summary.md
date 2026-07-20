# FixIt Theme Configuration Summary (Reference)

This is a structured summary of FixIt v1 theme configuration areas.
FixIt v1 is currently unreleased. Use the pinned `themes/FixIt/hugo.toml` as the
configuration contract; the bundled public docs still contain some v0.4 examples.

Primary sources:
- `themes/FixIt/hugo.toml`
- `themes/FixIt/layouts/_partials/init/detection-deprecated.html`

## 1) Hugo global config (used by FixIt)

- `baseURL`, `title`, `theme`, `locale`, `defaultContentLanguage`
- `outputs` (FixIt uses extra outputs: archives, search, etc.)
- `taxonomies`
- `menu` (main navigation)

## 2) Root `params` (FixIt)

### Site identity

- `params.title`, `params.subtitle`, `params.description`
- `params.author` (name, email, link, avatar)
- `params.logo` (site logo)
- `params.app` (theme color, icons)

### Header / Navigation

- `params.header` (navbar options)
- `params.header.title`, `params.header.subtitle`
- `params.breadcrumb`
- `params.navigation` (logo, menu)

### Footer

- `params.footer`, `params.footer.powered`, `params.footer.site_time`, `params.footer.order`

### Search

- `params.search` with `type` (algolia/fuse)
- `params.search.algolia`
- `params.search.fuse`
- `params.cse` (Google/Bing custom search)

### Home page

- `params.home.profile`
- `params.home.posts`

### Lists / archives / tag cloud

- `params.archives`
- `params.section` (and `section.feed`)
- `params.list` (and `list.feed`)
- `params.tag_cloud`
- `params.recently_updated`

### Social & profile

- `params.social` (GitHub, Twitter, etc.)
- `params.gravatar`
- `params.github_corner`

### Typography / UX

- `params.typeit`
- `params.pangu`
- `params.watermark`

### Media & assets

- `params.image` (default images)
- `params.cdn` (static asset CDN)

### Analytics / SEO / verification

- `params.analytics` (google, fathom, baidu, umami, plausible, cloudflare, splitbee)
- `params.seo`
- `params.verification`

### Third-party counters and consent

- `params.busuanzi`
- `params.cookieconsent`

### Compatibility and dev options

- `params.compatibility`
- `params.dev`

## 3) Page-level defaults (`params.*`)

FixIt v1 removes the `params.page` table. Page-level defaults live directly under
`params` and most can be overridden by front matter.

- Root defaults such as `params.page_style`, `params.word_count`, and `params.reading_time`
- `params.toc` (auto/ordered)
- `params.heading` (section numbering)
- `params.math` (katex/mathjax, macros)
- `params.mapbox`
- `params.related`
- `params.reward`
- `params.share`
- `params.comment` (artalk, disqus, gitalk, valine, waline, giscus, etc.)
- `params.library` (custom CSS/JS)
- `params.seo`
- `params.expiration_reminder`
- `params.post_link` (Markdown/source/edit/report/editor links)

## 4) Other FixIt feature configs

- `params.admonition` (customize alert styles)
- `params.task_list` (task list rendering)
- `params.repo_version` (version shortcode)
- `params.mermaid` (diagram support)
- `params.codeblock` (code copy buttons, etc.)
- `params.json_viewer`

## 5) Content management and front matter

Use FixIt front matter fields to override defaults:

- Standard: `title`, `date`, `tags`, `categories`, `draft`, `summary`, `images`
- FixIt-specific: `featured_image`, `lightgallery`, `toc`, `math`, `comment`, etc.

See:
- `content/zh-cn/documentation/content-management/introduction/index.md`

## 6) Markdown and shortcodes

FixIt extends markdown with alerts/admonitions, math, ruby, fractions, icons, tabs, etc.
See:
- `content/zh-cn/documentation/content-management/markdown-syntax/extended/index.md`
- `content/zh-cn/documentation/content-management/shortcodes/extended/introduction/index.md`

## 7) Advanced configuration

- Custom admonitions, task list styles, custom partials
- Theme components and inheritance

See:
- `content/en/documentation/advanced/index.md`
- `content/en/documentation/advanced/index.md#custom-partials`

## How this repo uses FixIt

Use `skills/heng-mei-blog/references/hugo-toml-summary.md` for the actual settings used in this project.
