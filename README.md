# Heng-Mei Blog

这是我的个人技术博客源码仓库，使用 **Hugo + FixIt** 构建，  
主要记录算法、学习笔记以及一些技术随想。

🌐 博客地址：[Heng-Mei Blog](https://heng-mei.github.io/)

## 技术栈

- **Static Site Generator**: [Hugo](https://gohugo.io/)
- **Theme**: [FixIt](https://github.com/hugo-fixit/FixIt)
- **Hosting**: GitHub Pages
- **CI/CD**: GitHub Actions

## 目录结构

```text
archetypes/              # 内容模板（默认 front matter）
assets/                  # 资源管道（可被 Hugo 处理的资源）
content/                 # 文章与页面
├── algorithms/           # 算法与题解
├── notes/                # 学习笔记
└── posts/                # 随想
public/                  # 生成的静态站点输出（可忽略/不手改）
resources/               # Hugo 构建缓存
skills/                  # 项目专用技能与参考文档
static/                  # 站点静态资源（头像/图标等）
themes/FixIt/            # Hugo 主题（submodule）
hugo.toml                # 站点配置
README.md                # 项目说明
```

## 说明

- 本仓库用于博客源码管理与个人记录
- 内容会持续更新与调整
- 不接受 Pull Request
