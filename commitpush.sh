#!/bin/bash
set -euo pipefail

# commitpush.sh
# Auto-adds content files (yaml/html/js/etc), commits, and pushes current branch.
# Safe: does not add ZIPs, pyc, or other ignored junk.

# Stage tracked modifications / deletions / renames
git add -u

# Add new content in known directories (recursive, safe)
git add assets/ docs/ overrides/ || true

# Add new root-level content files (optional)
git add *.html *.yml *.md *.sh *.py || true

# Nothing staged?
if git diff --cached --quiet; then
  echo "⚠️  Nothing to commit."
  exit 0
fi

git commit -m "Update content"

BRANCH=$(git rev-parse --abbrev-ref HEAD)
git push origin "$BRANCH"

echo "✅ Changes pushed to $BRANCH. Run publish.sh to update the site."
