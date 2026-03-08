#!/bin/bash
# =============================================================================
# new-post.sh — Convert a markdown file (or create from scratch) into a
# Zola-compatible blog post for devlog.arca.school
#
# Usage:
#   ./tools/new-post.sh                          # Interactive: create new post
#   ./tools/new-post.sh my-draft.md              # Convert existing .md file
#   ./tools/new-post.sh my-draft.md --publish    # Convert and git push
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BLOG_DIR="$(cd "$SCRIPT_DIR/../content/blog" && pwd)"
PUBLISH=false

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()  { printf "${GREEN}[✓]${NC} %s\n" "$1"; }
info() { printf "${BLUE}[i]${NC} %s\n" "$1"; }
warn() { printf "${YELLOW}[!]${NC} %s\n" "$1"; }

# --- Parse args ---
SOURCE_FILE=""
for arg in "$@"; do
  case "$arg" in
    --publish) PUBLISH=true ;;
    *.md)      SOURCE_FILE="$arg" ;;
  esac
done

# --- Gather metadata ---
echo ""
echo "  ╔══════════════════════════════════════╗"
echo "  ║   Arca School DevLog — New Post      ║"
echo "  ╚══════════════════════════════════════╝"
echo ""

read -rp "  Title: " TITLE
if [ -z "$TITLE" ]; then
  echo "  Error: Title is required."
  exit 1
fi

# Generate slug from title
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')
read -rp "  Slug [$SLUG]: " CUSTOM_SLUG
SLUG="${CUSTOM_SLUG:-$SLUG}"

TODAY=$(date +%Y-%m-%d)
read -rp "  Date [$TODAY]: " CUSTOM_DATE
POST_DATE="${CUSTOM_DATE:-$TODAY}"

read -rp "  Description (one-liner): " DESCRIPTION

read -rp "  Tags (comma-separated, e.g. rust,architecture,devlog): " TAGS_RAW
# Format tags for TOML
if [ -n "$TAGS_RAW" ]; then
  TAGS_TOML=$(echo "$TAGS_RAW" | sed 's/[[:space:]]*,[[:space:]]*/", "/g')
  TAGS_TOML="[\"$TAGS_TOML\"]"
else
  TAGS_TOML='["devlog"]'
fi

# Estimate reading time
if [ -n "$SOURCE_FILE" ] && [ -f "$SOURCE_FILE" ]; then
  WORD_COUNT=$(wc -w < "$SOURCE_FILE")
  READING_TIME=$(( (WORD_COUNT + 249) / 250 ))
else
  READING_TIME=5
fi

# --- Build the post ---
POST_DIR="$BLOG_DIR"
POST_FILE="$POST_DIR/$SLUG.md"

if [ -f "$POST_FILE" ]; then
  warn "File already exists: $POST_FILE"
  read -rp "  Overwrite? [y/N]: " CONFIRM
  if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "  Aborted."
    exit 0
  fi
fi

# Front matter
FRONT_MATTER=$(cat <<EOF
+++
title = "$TITLE"
date = $POST_DATE
description = "$DESCRIPTION"

[taxonomies]
tags = $TAGS_TOML

[extra]
reading_time = $READING_TIME
+++
EOF
)

if [ -n "$SOURCE_FILE" ] && [ -f "$SOURCE_FILE" ]; then
  # Check if source already has Zola front matter
  if head -1 "$SOURCE_FILE" | grep -q '^\+\+\+'; then
    info "Source file already has front matter — copying as-is"
    cp "$SOURCE_FILE" "$POST_FILE"
  else
    # Strip any existing YAML front matter (---) if present
    if head -1 "$SOURCE_FILE" | grep -q '^\-\-\-'; then
      CONTENT=$(sed '1{/^---$/d}; /^---$/,/^---$/d' "$SOURCE_FILE")
    else
      CONTENT=$(cat "$SOURCE_FILE")
    fi
    printf '%s\n\n%s\n' "$FRONT_MATTER" "$CONTENT" > "$POST_FILE"
  fi
  log "Converted: $SOURCE_FILE → $POST_FILE"
else
  # Create new post with template
  cat > "$POST_FILE" <<EOF
$FRONT_MATTER

Write your post here. Some tips:

- Use \`## Headings\` for sections
- Use \`> blockquotes\` for callouts
- Code blocks with \`\`\`rust get syntax highlighting
- Add images with \`![alt text](image-url)\`

<!-- more -->

This line and everything above it becomes the post summary on the blog listing.

## First Section

Start writing...
EOF
  log "Created new post: $POST_FILE"
fi

# --- Publish ---
if $PUBLISH; then
  info "Publishing..."
  cd "$SCRIPT_DIR/.."
  git add "content/blog/$SLUG.md"
  git commit -m "post: $TITLE"
  git push origin main
  log "Published! It'll be live in ~60 seconds."
else
  echo ""
  info "Post saved at: content/blog/$SLUG.md"
  info "To publish:"
  echo "    git add content/blog/$SLUG.md"
  echo "    git commit -m \"post: $TITLE\""
  echo "    git push origin main"
  echo ""
  info "Or re-run with --publish flag"
fi
