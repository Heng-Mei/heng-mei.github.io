# Site Configuration Summary (`hugo.toml`)

This file is the authoritative site configuration for this repo.

## Global Hugo settings

- `baseURL = "https://heng-mei.github.io/"`
- `title = "Heng-Mei Blog"`
- `theme = "FixIt"`
- `locale = "zh-cn"`, `defaultContentLanguage = "zh"`
- `enableRobotsTXT = true`, `enableEmoji = true`
- `mainSections = ["dialogues", "posts", "algorithms", "notes"]`

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

- `params.version = "1.0.X"`
- `params.capitalize_titles = false`

### Navigation and layout

- `params.breadcrumb.enable = true`
- `params.back_to_top.enable = true`, `params.back_to_top.scrollpercent = true`
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

- `params.home.profile.avatar_url = "/avatar.jpg"`
- `params.home.profile.avatar_menu = "github"`
- `params.home.profile.title` includes a custom emoji image
- `params.home.profile.subtitle` uses the quote: “横眉冷对千夫指，俯首甘为孺子牛。”
- `params.home.profile.typeit = true`
- `params.home.profile.social = true`

### Footer

- `params.footer.enable = true`
- `params.footer.copyright = true`
- `params.footer.author = true`
- `params.footer.since = "2025"`
- `params.footer.license` links to the MIT license
- `params.footer.powered.enable = false`

### Search (Fuse)

- `params.search.enable = true`
- `params.search.type = "fuse"`
- `params.search.content_length = 4000`
- `params.search.max_result_length = 10`
- `params.search.snippet_length = 30`
- `params.search.highlight_tag = "em"`
- `params.search.absolute_url = false`
- `params.search.fuse` section is explicitly configured (threshold, distance, etc.)

### Recently updated

- `params.recently_updated` enabled for none (`archives/section/list` are false)

### Page defaults

- `params.related.enable = true`, `count = 5`
- `params.license = CC BY-NC-SA 4.0`
- `params.post_link.markdown/source/edit/report = false`
- `params.post_link.editor = ""`
- `params.page_style = "normal"`
- `params.word_count = true`
- `params.reading_time = true`
- `params.collection_list = true`

### TOC / headings

- `params.toc.auto = false`
- `params.toc.ordered = true`
- `params.heading.number.enable = true`
- `params.heading.number.format` uses hierarchical numbering (h1..h6)

### Sharing

- `params.share.enable = false`

### Math / LaTeX

- `markup.goldmark.extensions.passthrough` is enabled, with delimiters for `$...$`, `$$...$$`, `\( \)`, `\[ \]`.
- `params.math.enable = true`
- `params.math.type = "mathjax"`
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
- `/dialogues/`, `/posts/`, `/algorithms/`, `/notes/`, `/archives/`, `/collections/`, `/categories/`, `/tags/`

## Caches

- Image cache configured to `:cacheDir/images`.

## Where to edit

- Global behavior: `hugo.toml`
- Per-page overrides: front matter in the content files
- Theme defaults: `themes/FixIt/hugo.toml` (reference only; do not edit unless updating theme behavior)

## FixIt v1 migration note

- This branch pins an unreleased FixIt v1 commit. Use `themes/FixIt/hugo.toml` and
  `themes/FixIt/layouts/_partials/init/detection-deprecated.html` as the current
  configuration contract.
- The bundled public documentation still contains some v0.4 examples. Do not copy
  `[params.page]` or camelCase theme keys back into the site configuration.
