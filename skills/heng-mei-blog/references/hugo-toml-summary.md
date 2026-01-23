# Site Configuration Summary (`hugo.toml`)

This file is the authoritative site configuration for this repo.

## Global Hugo settings

- `baseURL = "https://heng-mei.github.io/"`
- `title = "Heng-Mei Blog"`
- `theme = "FixIt"`
- `languageCode = "zh-cn"`, `defaultContentLanguage = "zh"`
- `enableRobotsTXT = true`, `enableEmoji = true`
- `mainSections = ["posts", "algorithms", "notes"]`

## Outputs

- `home = ["html", "rss", "archives", "offline", "readme", "baidu_urls", "search"]`
- `page = ["html", "markdown"]`
- `section = ["html", "rss"]`
- `taxonomy = ["html"]`
- `term = ["html", "rss"]`

## Taxonomies

- `archive = "archives"`
- `category = "categories"`
- `tag = "tags"`
- `collection = "collections"`

## Theme params (FixIt)

### Global flags

- `params.capitalizeTitles = false`

### Navigation and layout

- `params.breadcrumb.enable = true`
- `params.backToTop.enable = true`, `params.backToTop.scrollpercent = true`
- `params.home.profile.enable = true`
- `params.home.posts.enable = false`

### Author and social

- `params.author.name = "Heng-Mei"`
- `params.author.email = "l888999666y@gmail.com"`
- `params.author.link = "https://github.com/Heng-Mei"`
- `params.author.avatar = "/avatar.jpg"`
- `params.social.GitHub = "Heng-Mei"`
- `params.social.RSS = false`

### Home profile (header)

- `params.home.profile.avatarURL = "/avatar.jpg"`
- `params.home.profile.avatarMenu = "github"`
- `params.home.profile.title` includes a custom emoji image
- `params.home.profile.subtitle` uses the quote: “横眉冷对千夫指，俯首甘为孺子牛。”
- `params.home.profile.typeit = true`
- `params.home.profile.social = true`

### Footer

- `params.footer.enable = true`
- `params.footer.copyright = true`
- `params.footer.author = true`
- `params.footer.since = "2025"`
- `params.footer.license` uses CC BY-NC-SA 4.0
- `params.footer.powered.enable = false`

### Search (Fuse)

- `params.search.enable = true`
- `params.search.type = "fuse"`
- `params.search.contentLength = 4000`
- `params.search.maxResultLength = 10`
- `params.search.snippetLength = 30`
- `params.search.highlightTag = "em"`
- `params.search.absoluteURL = false`
- `params.search.fuse` section is explicitly configured (threshold, distance, etc.)

### Recently updated

- `params.recentlyUpdated` enabled for none (`archives/section/list` are false)

### Page defaults

- `params.page.related.enable = true`, `count = 5`
- `params.page.license = CC BY-NC-SA 4.0`
- `params.page.linkToMarkdown = false`
- `params.page.linkToSource = false`
- `params.page.linkToEdit = false`
- `params.page.linkToReport = false`
- `params.page.linkToVscode = false`
- `params.page.pageStyle = "normal"`
- `params.page.wordCount = true`
- `params.page.readingTime = true`
- `params.page.collectionList = true`

### TOC / headings

- `params.page.toc.auto = false`
- `params.page.toc.ordered = true`
- `params.page.heading.number.enable = true`
- `params.page.heading.number.format` uses hierarchical numbering (h1..h6)
- `params.page.heading.toc.ordered.enable = true`

### Sharing

- `params.page.share.enable = false`

### Math / LaTeX

- `markup.goldmark.extensions.passthrough` is enabled, with delimiters for `$...$`, `$$...$$`, `\( \)`, `\[ \]`.
- `params.page.math.enable = true`
- `params.page.math.type = "mathjax"`
- MathJax CDN and packages configured (physics + xypic), with loader paths.

### Syntax highlighting

- `markup.highlight.codeFences = true`
- `markup.highlight.lineNumbersInTable = true`
- `markup.highlight.noClasses = false`

### Verification

- `params.verification.google` and `params.verification.bing` set.

## Menu

Top nav menu includes:

- GitHub link (icon-only)
- `/posts/`, `/algorithms/`, `/notes/`, `/archives/`, `/collections/`, `/categories/`, `/tags/`

## Caches

- Image cache configured to `:cacheDir/images`.

## Where to edit

- Global behavior: `hugo.toml`
- Per-page overrides: front matter in the content files
- Theme defaults: `themes/FixIt/hugo.toml` (reference only; do not edit unless updating theme behavior)
