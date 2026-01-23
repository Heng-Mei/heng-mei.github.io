# FixIt Theme Configuration Summary (Reference)

This is a structured summary of FixIt theme configuration areas, based on FixIt docs.
Use it as a map, and jump to the docs in `skills/heng-mei-blog/references/hugo-fixit-docs` for details.

Primary source:
- `content/zh-cn/documentation/getting-started/configuration/index.md`

## 1) Hugo global config (used by FixIt)

- `baseURL`, `title`, `theme`, `languageCode`, `defaultContentLanguage`
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

- `params.footer`, `params.footer.powered`, `params.footer.siteTime`, `params.footer.order`

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
- `params.tagcloud`
- `params.recentlyUpdated`

### Social & profile

- `params.social` (GitHub, Twitter, etc.)
- `params.gravatar`
- `params.githubCorner`

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

## 3) Page-level defaults (`params.page.*`)

These define default behaviors for all pages. Most can be overridden by front matter.

- `params.page` (root defaults)
- `params.page.toc` (auto/ordered)
- `params.page.heading` (section numbering)
- `params.page.math` (katex/mathjax, macros)
- `params.page.mapbox`
- `params.page.related`
- `params.page.reward`
- `params.page.share`
- `params.page.comment` (artalk, disqus, gitalk, valine, waline, giscus, etc.)
- `params.page.library` (custom CSS/JS)
- `params.page.seo`
- `params.page.repost`
- `params.page.expirationReminder`

## 4) Other FixIt feature configs

- `params.admonition` (customize alert styles)
- `params.taskList` (task list rendering)
- `params.repoVersion` (version shortcode)
- `params.mermaid` (diagram support)
- `params.codeblock` (code copy buttons, etc.)
- `params.jsonViewer`

## 5) Content management and front matter

Use FixIt front matter fields to override defaults:

- Standard: `title`, `date`, `tags`, `categories`, `draft`, `summary`, `images`
- FixIt-specific: `featuredImage`, `lightgallery`, `toc`, `math`, `comment`, etc.

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
