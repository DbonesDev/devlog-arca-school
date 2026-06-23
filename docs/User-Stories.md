# DevLog Arca School — User Stories

> **Goal:** Deploy a static blog at devlog.arca.school via GitHub Pages + Zola.
> **Quarter:** Q1 2026
> **Repo:** `DbonesDev/devlog-arca-school`

---

## US-DEVLOG-001: Create GitHub repo and enable GitHub Pages

- **As a** developer
- **I want** the devlog repo on GitHub with Pages enabled via GitHub Actions
- **So that** pushing to main automatically publishes the site

**Tasks:**
- [ ] `git init` + initial commit with full Zola structure
- [ ] `gh repo create DbonesDev/devlog-arca-school --public`
- [ ] Enable GitHub Pages in repo settings (Source: GitHub Actions)
- [ ] Verify first deploy workflow passes (green check)
- [ ] Site loads at `dbonesdev.github.io/devlog-arca-school`

**Estimate:** 1 session (~15min)

---

## US-DEVLOG-002: Configure custom domain (devlog.arca.school)

- **As a** reader
- **I want** to access the devlog at `devlog.arca.school`
- **So that** the URL is professional and branded

**Tasks:**
- [ ] Set custom domain in GitHub Pages settings: `devlog.arca.school`
- [ ] Add CNAME file to repo root
- [ ] Update Hostinger DNS: CNAME `devlog` → `DbonesDev.github.io`
- [ ] Verify DNS propagation: `dig devlog.arca.school CNAME +short`
- [ ] Enable and verify HTTPS enforcement
- [ ] `curl -sI https://devlog.arca.school` returns HTTP 200

**Depends on:** US-DEVLOG-001
**Estimate:** 1 session (~30min, mostly DNS wait)

---

## US-DEVLOG-003: Migrate existing blog posts

- **As a** reader
- **I want** the existing blog content available on the new site
- **So that** there's no loss of content during migration

**Tasks:**
- [ ] Verify 2 existing posts render correctly with Zola
- [ ] Check front matter (title, date, description, tags)
- [ ] Verify post listing on homepage shows both posts
- [ ] Check reading time calculation
- [ ] Verify atom.xml feed includes both posts

**Depends on:** US-DEVLOG-001
**Estimate:** 1 session (~15min)

---

## US-DEVLOG-004: Validate Monastic Modern theme responsiveness

- **As a** reader on mobile
- **I want** the site to look clean on all screen sizes
- **So that** the devlog is accessible to youth audience on any device

**Tasks:**
- [ ] Test desktop (1440px+): hero, post cards, post page, about
- [ ] Test tablet (768px): layout adapts, readable
- [ ] Test mobile (375px): navigation collapses, font sizes reduce
- [ ] Verify Google Fonts loading (Crimson Pro, Inter, JetBrains Mono)
- [ ] Test dark mode via `prefers-color-scheme` (if applicable)
- [ ] Lighthouse performance score > 90

**Depends on:** US-DEVLOG-001
**Estimate:** 1 session (~30min)

---

## US-DEVLOG-005: Cancel Hostinger hosting and verify

- **As a** project owner
- **I want** to stop paying Hostinger hosting fees
- **So that** the devlog runs for free on GitHub Pages

**Tasks:**
- [ ] Confirm devlog.arca.school loads correctly from GitHub Pages
- [ ] Confirm arca.school main domain still works on Hostinger
- [ ] Cancel Hostinger hosting plan (keep domain registration)
- [ ] Verify no DNS disruption after cancellation

**Depends on:** US-DEVLOG-002
**Estimate:** 1 session (~15min)

---

## US-DEVLOG-006: Write and publish first "building in public" post

- **As a** reader
- **I want** a fresh English post about the Arca School project setup
- **So that** the devlog starts with real content and signals the project is active

**Tasks:**
- [ ] Write post about the weekend infrastructure setup (GitHub Projects, CI/CD, DDI)
- [ ] Use `./tools/new-post.sh` to create the post
- [ ] Verify post renders correctly (headings, code blocks, links)
- [ ] Push and confirm live on devlog.arca.school

**Depends on:** US-DEVLOG-001
**Estimate:** 1 session (~45min)

---

## Summary

| US | Title | Sprint | Depends | Estimate |
|----|-------|--------|---------|----------|
| US-DEVLOG-001 | Create GitHub repo + enable Pages | 20 | — | 15min |
| US-DEVLOG-002 | Configure custom domain | 20 | 001 | 30min |
| US-DEVLOG-003 | Migrate existing posts | 20 | 001 | 15min |
| US-DEVLOG-004 | Validate theme responsiveness | 20 | 001 | 30min |
| US-DEVLOG-005 | Cancel Hostinger hosting | 20 | 002 | 15min |
| US-DEVLOG-006 | Write first "building in public" post | 20 | 001 | 45min |

**Total: 6 US, ~2h30 de trabalho**
