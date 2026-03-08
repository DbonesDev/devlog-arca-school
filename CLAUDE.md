# DevLog Arca School

## What Is This
Static blog built with Zola (Rust-based SSG). Hosted on GitHub Pages at devlog.arca.school.
Design: "Monastic Modern" — classical typography (Crimson Pro) + modern layout (Inter). Sage green accents (#2D5F2D), linen background (#FAFAF5).

## Structure
```
content/blog/         — Blog posts (markdown with +++ TOML front matter)
content/about.md      — About page
sass/style.scss       — All styles (compiled by Zola)
templates/            — Zola Tera templates
static/               — Static assets (images, fonts)
tools/new-post.sh     — Markdown → blog post converter
.github/workflows/    — GitHub Actions deploy to Pages
```

## Publishing a Post

### From an existing markdown file:
```bash
./tools/new-post.sh my-draft.md
# or auto-publish:
./tools/new-post.sh my-draft.md --publish
```

### Create a new post from scratch:
```bash
./tools/new-post.sh
# Follow prompts for title, tags, description
# Edit the generated file, then git push
```

### Manual:
1. Create `content/blog/your-slug.md` with TOML front matter
2. `git add . && git commit -m "post: Title" && git push`
3. GitHub Actions builds and deploys in ~60 seconds

## Front Matter Format
```toml
+++
title = "Post Title"
date = 2026-03-08
description = "One-line description for SEO and cards"

[taxonomies]
tags = ["rust", "architecture"]

[extra]
reading_time = 5
+++
```

## Local Development
```bash
zola serve    # http://127.0.0.1:1111 with hot reload
zola build    # Generate static site in public/
```

## Design Tokens
- Headings: Crimson Pro (serif)
- Body: Inter (sans-serif)
- Code: JetBrains Mono
- Accent: #2D5F2D (sage green)
- Background: #FAFAF5 (linen)
- Cards: #FFFFFF with #E0DCD4 borders
