# PROJECT KNOWLEDGE BASE

**Generated:** 2026-07-13
**Commit:** 6e01c9a
**Branch:** main

## OVERVIEW

Chinese-language personal tech blog (算法 / 笔记 / 随想 / 共思录). Hugo Extended static site + FixIt theme, deployed to GitHub Pages (primary) and Cloudflare Pages (secondary). Author-only repo — README states "不接受 Pull Request".

## STRUCTURE

```text
content/         # ALL authored content across 4 sections — see content/AGENTS.md
static/          # served as-is: avatar.jpg, favicon.ico, page-bundle images
assets/          # editor mapping + site-owned CSS/SCSS customizations
archetypes/      # default.md — TOML front matter template for `hugo new`
hugo.toml        # sole site config (276 lines: menus, MathJax, search, params)
build.sh         # Cloudflare Pages build (installs toolchain, then hugo build)
wrangler.toml    # Cloudflare Pages config (build cmd + serves ./public)
skills/          # AI skill + vendored reference submodules — see skills/AGENTS.md
themes/FixIt/    # theme (submodule, DO NOT edit — customize via hugo.toml)
public/          # build output — gitignored, generated, never hand-edit
resources/       # Hugo build cache — gitignored, generated
```

## WHERE TO LOOK

| Task | Location | Notes |
|------|----------|-------|
| Write/edit an article | `content/{posts,algorithms,notes}/` | See `content/AGENTS.md` |
| Convert a public GPT conversation | `content/dialogues/` | See `content/dialogues/AGENTS.md` |
| Change site behavior/menus/params | `hugo.toml` | FixIt v1 uses flattened `params` + snake_case keys |
| Adjust build/toolchain versions | `.github/workflows/static.yml` AND `build.sh` | Keep BOTH in sync (dual hosting) |
| Theme docs / Hugo API lookup | `skills/heng-mei-blog/references/` | Bundled offline submodules |
| Theme internals / shortcodes | `themes/FixIt/layouts/` | Submodule — read only |

## COMMANDS

```bash
hugo server -D                    # local dev, includes drafts
hugo --gc --minify                # production build (same as CI)
hugo new posts/your-post.md       # scaffold from archetypes/default.md
git submodule update --init --recursive   # after clone
```

Pinned toolchain (identical in CI + `build.sh`): Hugo **0.164.0** (extended+deploy), Go **1.26.5**, Node **24.18.0**, Dart Sass **1.101.0**.

## CONVENTIONS

- **Front matter is TOML (`+++`), never YAML (`---`).**
- Deploy config lives in TWO places (`static.yml` + `build.sh`) — version bumps must land in both.
- Commit style: Conventional Commits actually used here — `docs:`, `docs(scope):`, `chore:`, `fix:`, `ops:`. Keep short, action-oriented.
- **Only create git commits when the user explicitly asks.**

## ANTI-PATTERNS (THIS PROJECT)

- Do NOT edit `themes/FixIt/`, `skills/heng-mei-blog/references/hugo*`, or `.../vscode-markdownlint` — they are git submodules.
- Do NOT edit `public/` or `resources/` — generated + gitignored.
- Do NOT add a root `layouts/` to override the theme unless intentionally overriding FixIt.

## NOTES

- `.markdownlint.json` is referenced by `skills/.../markdownlint-guide.md` but does NOT exist at repo root — a known gap; lint relies on VS Code defaults.
- No `package.json` at root; Node is provisioned in CI only as a precaution.
- `content/_index.md` is just a GitHub contribution-chart image; the visible homepage profile is rendered by `[params.home.profile]` in `hugo.toml`.
