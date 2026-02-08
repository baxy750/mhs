#!/bin/bash
set -euo pipefail

# commitpush.sh
# Auto-adds content files (yaml/html/js/etc), commits, and pushes current branch.
# Safe: does not add ZIPs, pyc, or other ignored junk.

# Stage tracked modifications / deletions / renames
git add -u

# Try to add new content files (ignore if none exist)
git add -- '*.yml' '*.yaml' '*.html' '*.htm' '*.js' '*.css' '*.md' '*.json' \
          '*.py' '*.png' '*.jpg' '*.jpeg' '*.gif' '*.svg' '*.webp' || true

# Nothing staged?
if git diff --cached --quiet; then
  echo "⚠️  Nothing to commit."
  exit 0
fi

git commit -m "Update content"

BRANCH=$(git rev-parse --abbrev-ref HEAD)
git push origin "$BRANCH"

echo "✅ Changes pushed to $BRANCH. Run publish.sh to update the site."
