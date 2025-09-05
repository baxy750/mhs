#!/bin/bash

# Get current branch name
BRANCH=$(git symbolic-ref --short HEAD)

# Check if we're on gh-pages
if [ "$BRANCH" != "gh-pages" ]; then
  echo "You are on branch '$BRANCH'."
  echo "Please switch to 'gh-pages' to publish:"
  echo "  git checkout gh-pages"
  exit 1
fi

# Add all changes
git add .

# Commit with a timestamp
git commit -m "Site update: $(date +'%Y-%m-%d %H:%M:%S')" || {
  echo "Nothing to commit."
  exit 0
}

# Push to origin
git push origin gh-pages

# Open the site in the default browser
echo "Opening: https://baxy750.github.io/mhs/"
start "" "https://baxy750.github.io/mhs/"
