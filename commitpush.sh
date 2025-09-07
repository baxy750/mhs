#!/bin/bash

# commitpush.sh

# Stages all local changes and commits them to the main branch
# Then pushes the commit to the remote repository on GitHub (origin/main)
# After pushing, run publish.sh to build and deploy the site to gh-pages

set -e

git add .

# Check if anything is staged for commit
if git diff --cached --quiet; then
  echo "⚠️  No changes staged for commit."
else
  git commit -m "Update content"
  git push origin main
  echo "✅ Changes pushed. Now run publish.sh to update the site."
fi





