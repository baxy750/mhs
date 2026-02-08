#!/bin/bash

# commitpush.sh

# Stages all local changes and commits them to the main branch
# Then pushes the commit to the remote repository on GitHub (origin/main)
# After pushing, run publish.sh to build and deploy the site to gh-pages

#set -e

#git add .

## Check if anything is staged for commit
#if git diff --cached --quiet; then
#  echo "⚠️  No changes staged for commit."
#else
#  git commit -m "Update content"
#  git push origin main
#  echo "✅ Changes pushed. Now run publish.sh to update the site."
#fi




##!/bin/bash
#set -euo pipefail

## fast check — exit if no changes
#if [ -z "$(git status --porcelain)" ]; then
#  echo "⚠️  No changes to commit."
#  exit 0
#fi

## stage tracked files only (faster than adding lots of untracked files)
#git add -u

## nothing staged?
#if git diff --cached --quiet; then
#  echo "⚠️  Nothing staged after git add -u."
#  exit 0
#fi

## commit and push quickly (skip local hooks). Remove --no-verify if you rely on hooks.
#git commit -m "Update content" --no-verify

#BRANCH=$(git rev-parse --abbrev-ref HEAD)
#git push --no-verify origin "$BRANCH"

#echo "✅ Changes pushed to $BRANCH. Run publish.sh to update the site."







#!/bin/bash
set -euo pipefail

# commitpush.sh
# Stages tracked changes, commits, and pushes current branch.
# This will NOT add new untracked files (like backup ZIPs) unless you add them explicitly.

# exit if no changes at all
if [ -z "$(git status --porcelain)" ]; then
  echo "⚠️  No changes to commit."
  exit 0
fi

# stage tracked files only (safe: won't add new backups)
git add -u

# nothing staged?
if git diff --cached --quiet; then
  echo "⚠️  Nothing staged after git add -u."
  exit 0
fi

git commit -m "Update content"

BRANCH=$(git rev-parse --abbrev-ref HEAD)
git push origin "$BRANCH"

echo "✅ Changes pushed to $BRANCH. Run publish.sh to update the site."
