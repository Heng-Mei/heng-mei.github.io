# Heng-Mei Blog

这是我的个人技术博客源码仓库，使用 **Hugo + PaperMod** 构建，  
主要记录算法、学习笔记以及一些技术随想。

🌐 博客地址：<https://heng-mei.github.io/>

## 技术栈

- **Static Site Generator**: Hugo
- **Theme**: PaperMod
- **Hosting**: GitHub Pages
- **CI/CD**: GitHub Actions

## 目录结构

```text
content/
├── algorithms/   # 算法与题解（包含数学公式，使用 KaTeX 渲染）
├── notes/        # 学习笔记（支持公式与代码）
└── posts/        # 随想

layouts/
└── partials/
    ├── extend_head.html  # 扩展 <head>，注入 KaTeX 等资源
    └── math.html         # KaTeX 配置与加载逻辑

static/
└── favicon.ico           # 站点图标

themes/PaperMod/          # Hugo 主题（git submodule）
```

## 说明

- 本仓库用于博客源码管理与个人记录
- 内容会持续更新与调整
- 不接受 Pull Request
