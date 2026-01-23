# FixIt Flavored Markdown Summary

Source file:

- `skills/heng-mei-blog/references/hugo-fixit-docs/content/zh-cn/documentation/content-management/markdown-syntax/extended/index.md`

## Key extensions (quick map)

- Alerts / Admonitions (types + aliases in FixIt docs)
- Color preview blocks
- Task lists
- Inserted text (underline)
- Marked text (highlight)
- Subscript / Superscript
- Emoji
- Math formulas (KaTeX/MathJax)
- Ruby (phonetic annotations)
- Fractions
- Font Awesome icons
- Escape characters
- Markdown attributes
- Extended code fences

## Minimal examples

### Alerts / Admonitions (with aliases)

```markdown
> [!note]
> 默认提示

> [!abstract]+ 可折叠摘要
> 摘要内容

> [!warning]- 可折叠警告
> 警告内容
```

Supported types and aliases (per FixIt docs):
`note`, `abstract` (alias: `summary`, `tldr`), `info`, `todo`,
`tip` (alias: `hint`, `important`), `success` (alias: `check`, `done`),
`question` (alias: `help`, `faq`), `warning` (alias: `caution`, `attention`),
`failure` (alias: `fail`, `missing`), `danger` (alias: `error`), `bug`, `example`,
`quote` (alias: `cite`).

### Task list

```markdown
- [x] done
- [ ] todo
```

### Marked text

```markdown
==highlight==
```

### Subscript / Superscript

```markdown
H~2~O
x^2^
```

### Ruby

```markdown
{[漢字](かんじ)}
```

### Font Awesome

```markdown
:fas fa-camera:
```

### Extended code fences

````markdown
```go {linenos=true}
fmt.Println("hello")
```
````

For exact syntax variants, read the FixIt markdown doc referenced above.
