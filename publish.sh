#!/bin/bash

set -e  # stop on error

BUILD_DIR="_site_temp"

echo "🔧 Building site..."
mkdocs build -d "$BUILD_DIR"

echo "🚀 Switching to gh-pages..."
git switch gh-pages

echo "🧹 Cleaning old site files..."
git rm -rf . > /dev/null 2>&1 || true

echo "📁 Copying new site files..."
cp -r ../$BUILD_DIR/* .

echo "📦 Committing changes..."
git add .
git commit -m "Publishing update: $(date +'%Y-%m-%d %H:%M:%S')" || echo "Nothing to commit"

echo "⏫ Pushing to GitHub..."
git push origin gh-pages

echo "🧽 Cleaning up..."
git switch main
rm -rf "$BUILD_DIR"

echo "✅ Done. Site published at: https://baxy750.github.io/mhs/"
