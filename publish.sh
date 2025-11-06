#!/bin/bash

set -e  # Stop on error

BUILD_DIR="$HOME/_site_temp"

echo "🧹 Cleaning previous site build..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo "💾 Saving any uncommitted changes on main..."
git add .
git commit -m "Auto-commit before publish: $(date +'%Y-%m-%d %H:%M:%S')" || echo "⚠️ Nothing to commit"

echo "🔧 Building site..."
python -m mkdocs build -d "$BUILD_DIR"

echo "🚀 Switching to gh-pages..."
git switch gh-pages

echo "🧹 Cleaning old site files..."
git rm -rf . > /dev/null 2>&1 || true

echo "📁 Copying new site files..."
cp -r "$BUILD_DIR"/. .

echo "📦 Committing and pushing changes..."
git add .
git commit -m "Publish site: $(date +'%Y-%m-%d %H:%M:%S')" || echo "⚠️ Nothing to commit"
git push origin gh-pages --force

echo "🔙 Switching back to main..."
git switch main

echo "✅ Done. Site published at: https://baxy750.github.io/mhs/"
echo "📂 Built files remain in: $BUILD_DIR"

echo ""
echo "If you see an error which leaves you on the wrong branch, use:"
echo "  git switch main"
echo "...to get back onto main branch"
