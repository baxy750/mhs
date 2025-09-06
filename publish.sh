#!/bin/bash

set -e  # Stop on error

BUILD_DIR="_site_temp"

echo "💾 Saving any uncommitted changes on main..."
git add .
git commit -m "Auto-commit before publish: $(date +'%Y-%m-%d %H:%M:%S')" || echo "⚠️ Nothing to commit"

echo "🔧 Building site..."
mkdocs build -d "$BUILD_DIR"

echo "🚀 Switching to gh-pages..."
git switch gh-pages

echo "🧹 Cleaning old site files..."
git rm -rf . > /dev/null 2>&1 || true

echo "📁 Copying new site files..."
cp -r "../$BUILD_DIR"/. .

echo "📦 Committing and pushing changes..."
git add .
git commit -m "Publish site: $(date +'%Y-%m-%d %H:%M:%S')" || echo "⚠️ Nothing to commit"
git push origin gh-pages

echo "🔙 Switching back to main..."
git switch main

echo "🧹 Cleaning up..."
rm -rf "$BUILD_DIR"

echo "✅ Done. Site published at: https://baxy750.github.io/mhs/"
