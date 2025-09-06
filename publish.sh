#!/bin/bash

# Exit on error
set -e

# Ensure we're on main
BRANCH=$(git symbolic-ref --short HEAD)
if [ "$BRANCH" != "main" ]; then
  echo "You are on branch '$BRANCH'. Please switch to 'main' to publish."
  exit 1
fi

# Build the site
echo "🔧 Building site..."
mkdocs build

# Save current branch (should be 'main')
CURRENT_BRANCH=$(git symbolic-ref --short HEAD)

# Switch to gh-pages
echo "🚀 Switching to gh-pages..."
git switch gh-pages

# Clean everything except .git
echo "🧹 Cleaning old site files..."
find . -maxdepth 1 ! -name '.git' ! -name '.' -exec rm -rf {} +

# Copy fresh build
echo "📁 Copying new site files..."
cp -r site/* .

# Commit and push
echo "📦 Committing and pushing..."
git add .
git commit -m "Site update: $(date +'%Y-%m-%d %H:%M:%S')" || echo "No changes to commit."
git push origin gh-pages

# Return to main
echo "🔁 Returning to main..."
git switch "$CURRENT_BRANCH"

# Open in browser
echo "🌐 Opening live site..."
start "" "https://baxy750.github.io/mhs/"
