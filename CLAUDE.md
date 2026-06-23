# CLAUDE.md — DevLog Arca School

**Last Updated:** March 2026
**Status:** Site criado, deploy pendente (GitHub Pages + Hostinger DNS)
**Team:** DbonesDev
**Repo:** [DbonesDev/devlog-arca-school](https://github.com/DbonesDev/devlog-arca-school)

---

## O Projecto

**devlog-arca-school** é o blog público "build in public" da Arca School. Um site estático gerado com **Zola** (SSG escrito em Rust), hospedado no **GitHub Pages** com domínio customizado `devlog.arca.school`.

**O que é:**
- Blog estático (Markdown → HTML via Zola)
- Deploy automático via GitHub Actions (push to main → live em ~60s)
- Design "Monastic Modern" — tipografia clássica, layout moderno, apelativo para jovens
- Ferramenta `new-post.sh` para converter markdown em posts

**O que não é:**
- Não é uma aplicação dinâmica — sem backend, sem base de dados
- Não faz parte do deploy do Oracle Cloud (vive no GitHub Pages)
- Não requer Docker

---

## Stack

| Componente | Tecnologia | Função |
|:-----------|:-----------|:-------|
| SSG | Zola 0.19.2 | Compila Markdown + SCSS → site estático |
| Hosting | GitHub Pages | Serve o site em devlog.arca.school |
| CI/CD | GitHub Actions | Build automático no push to main |
| Estilos | SCSS (compilado por Zola) | Monastic Modern theme |
| Domínio | Hostinger (DNS) → GitHub Pages | CNAME devlog → DbonesDev.github.io |

---

## Estrutura do Repo

```
devlog-arca-school/
├── config.toml                  # Configuração Zola (base_url, feeds, search)
├── content/
│   ├── _index.md                # Root content config
│   ├── about.md                 # Página "About"
│   └── blog/
│       ├── _index.md            # Blog section config (paginação, template)
│       └── *.md                 # Posts (TOML front matter +++)
├── sass/
│   └── style.scss               # Todos os estilos (Monastic Modern theme)
├── templates/
│   ├── base.html                # Layout base (header, footer, meta)
│   ├── index.html               # Homepage (hero + últimos posts)
│   ├── blog.html                # Listagem de posts com paginação
│   ├── blog-page.html           # Post individual (OpenGraph, nav, reading time)
│   └── page.html                # Páginas genéricas (About, etc.)
├── static/
│   ├── css/                     # CSS extra (se necessário)
│   ├── images/                  # Imagens para posts e site
│   └── fonts/                   # Fontes locais (se necessário)
├── tools/
│   └── new-post.sh              # Conversor Markdown → Zola post
├── .github/
│   └── workflows/
│       └── deploy.yml           # Build Zola + deploy GitHub Pages
├── .vscode/
│   └── settings.json            # VS Code color: Forest Sage #3D5A3D
├── CLAUDE.md                    # Este ficheiro
└── .gitignore                   # Ignora public/
```

---

## Deploy & Configuração

### Setup Inicial (executar uma vez)

#### 1. Criar o repositório no GitHub
```bash
cd ~/arca-school/devlog-arca-school
git init
git add .
git commit -m "feat: initial Zola site with Monastic Modern theme"
gh repo create DbonesDev/devlog-arca-school --public --source=. --push
```

#### 2. Activar GitHub Pages
- Ir a: `https://github.com/DbonesDev/devlog-arca-school/settings/pages`
- **Build and deployment → Source:** seleccionar **GitHub Actions** (NÃO "Deploy from a branch")
- O workflow `.github/workflows/deploy.yml` faz o resto

#### 3. Verificar primeiro deploy
```bash
# Verificar que o workflow correu com sucesso
gh run list --repo DbonesDev/devlog-arca-school --limit 3

# Se falhou, ver logs
gh run view --repo DbonesDev/devlog-arca-school <run-id> --log-failed
```
Site temporário: `https://dbonesdev.github.io/devlog-arca-school/`

#### 4. Configurar domínio customizado no GitHub
- Ir a: `https://github.com/DbonesDev/devlog-arca-school/settings/pages`
- **Custom domain:** `devlog.arca.school`
- **Enforce HTTPS:** activar (pode demorar alguns minutos)

Ou via CLI:
```bash
# Criar ficheiro CNAME (GitHub Pages usa isto para custom domain)
echo "devlog.arca.school" > CNAME
git add CNAME && git commit -m "chore: add CNAME for custom domain" && git push
```

#### 5. Configurar DNS no Hostinger
No painel Hostinger → Domains → arca.school → DNS Records:
- **Apagar** o registo existente do subdomínio `devlog`
- **Adicionar novo CNAME:**
  - Type: `CNAME`
  - Name: `devlog`
  - Target: `DbonesDev.github.io`
  - TTL: `3600`

Propagação DNS: 5–30 minutos (máximo 24h).

#### 6. Verificar tudo
```bash
# Verificar DNS
dig devlog.arca.school CNAME +short
# Deve retornar: dbonesdev.github.io.

# Verificar site
curl -sI https://devlog.arca.school | head -5
# Deve retornar HTTP/2 200

# Verificar HTTPS
curl -sI https://devlog.arca.school | grep -i "strict-transport"
```

---

## GitHub Workflow — Issues como Fonte de Verdade

Este projecto tem User Stories menores (conteúdo, design). As issues vivem no GitHub.

### Antes de começar a trabalhar
```bash
# Ver issues abertas
gh issue list --repo DbonesDev/devlog-arca-school --state open --json number,title,labels --jq '.[] | "\(.number)\t\(.title)\t\(.labels | map(.name) | join(","))"'

# Ver uma issue específica
gh issue view <number> --repo DbonesDev/devlog-arca-school
```

### Ao concluir
```bash
gh issue close <number> --repo DbonesDev/devlog-arca-school --comment "✅ Concluído"
```

---

## Publicar Posts

### Converter markdown existente em post:
```bash
./tools/new-post.sh meu-draft.md
# Preencher título, tags, descrição
# Post criado em content/blog/slug.md

# Ou auto-publicar:
./tools/new-post.sh meu-draft.md --publish
```

### Criar post novo do zero:
```bash
./tools/new-post.sh
# Seguir os prompts interactivos
# Editar o ficheiro gerado
git add content/blog/slug.md
git commit -m "post: Título do Post"
git push origin main
```

### Formato do Front Matter
```toml
+++
title = "Título do Post"
date = 2026-03-08
description = "Descrição curta para SEO e cards"

[taxonomies]
tags = ["rust", "arquitectura", "devlog"]

[extra]
reading_time = 5
+++

Conteúdo em Markdown aqui...

<!-- more -->

Tudo acima do <!-- more --> aparece como resumo na listagem.
```

---

## Desenvolvimento Local

```bash
# Instalar Zola (macOS)
brew install zola

# Servidor local com hot reload
zola serve
# → http://127.0.0.1:1111

# Build estático (output em public/)
zola build

# Verificar links partidos
zola check
```

---

## Design — Monastic Modern

Design clássico mas moderno. Apelativo para jovens — clean, rápido, sem distrações.

### Design Tokens
| Token | Valor | Uso |
|:------|:------|:----|
| Font headings | Crimson Pro (serif) | h1–h4, logo |
| Font body | Inter (sans-serif) | Parágrafos, nav, meta |
| Font code | JetBrains Mono | Code blocks, inline code |
| Accent | `#2D5F2D` (sage green) | Links, tags, CTAs, borders |
| Accent hover | `#3D7A3D` | Hover states |
| Background | `#FAFAF5` (linen) | Body background |
| Surface | `#F0EDE6` | Blockquotes, code inline bg |
| Cards | `#FFFFFF` | Post cards |
| Border | `#E0DCD4` | Cards, dividers, footer |
| Text | `#1A1A1A` | Headings, body |
| Text muted | `#6B6B6B` | Meta, descriptions |
| Code bg | `#1D2433` | Pre blocks (dark) |

### Regras de Design
- **Nunca** adicionar cores vibrantes, gradients, ou animações excessivas
- **Sempre** manter whitespace generoso — o conteúdo respira
- Cards com `border-radius: 12px` e hover com `translateY(-2px)` + shadow
- Sticky header com `backdrop-filter: blur(12px)` para transparência
- Responsivo: breakpoint a 640px, font-size reduz de 18px para 16px
- Posts usam `max-width: 720px` para leitura confortável

---

## Troubleshooting

### Build falha no GitHub Actions
```bash
# Ver logs do último run
gh run view --repo DbonesDev/devlog-arca-school --log-failed

# Causas comuns:
# 1. Front matter inválido (verificar +++ delimiters)
# 2. Template Tera com erros de sintaxe
# 3. Link interno partido (usar zola check)
```

### DNS não propaga
```bash
# Verificar estado actual
dig devlog.arca.school CNAME +short
dig devlog.arca.school A +short

# Se apontar para IP antigo do Hostinger, esperar ou limpar cache DNS:
# macOS: sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
```

### HTTPS não funciona
- Verificar que **Enforce HTTPS** está activo nas settings do GitHub Pages
- GitHub precisa de validar o certificado — pode demorar até 1h após DNS propagar
- Não é possível forçar HTTPS antes do DNS CNAME apontar correctamente

### Site mostra 404
- Verificar que o workflow fez deploy (Actions → último run deve estar verde)
- Verificar que `base_url` no `config.toml` corresponde ao domínio final
- Se usar custom domain, o ficheiro `CNAME` deve existir no root do repo

---

## Conexão com o Ecossistema

| Projecto | Relação |
|:---------|:--------|
| arca-api | Conteúdo técnico dos posts (arquitectura, APIs, domain model) |
| arca-school-platform | Posts sobre frontend, UX, HTMX, SSR |
| slm-engine | Posts sobre IA, modelos pequenos, ML |
| scriptorium | Posts sobre gestão de conteúdo, textos clássicos |
| spec-machine | Posts sobre especificações, geração de conteúdo |
| deploy | Posts sobre infra, CI/CD, Oracle Cloud |
| arca.school | Landing page principal (link no footer do devlog) |

O devlog documenta o progresso de **todos** os repositórios. É o ponto público de contacto do projecto Arcasidian.

---

## VS Code

Este projecto usa **Forest Sage (#3D5A3D)** no VS Code para distinguir de outros projectos:
- arca-api: Navy Blue `#1E3A5F`
- slm-engine: Purple `#5C2D91`
- scriptorium: Sage Green `#2D5F2D`
- spec-machine: Dark Gold `#B8860B`
- arca-school-platform: Teal `#0E7C7B`
- deploy: Orange `#D45500`
- **devlog-arca-school: Forest Sage `#3D5A3D`**
