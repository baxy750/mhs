#!/bin/bash
# commitpush.sh
set -e
git add .
git commit -m "Update content"
git push origin main
echo "now run publish.sh"
