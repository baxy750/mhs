#!/usr/bin/env bash
set -euo pipefail

cd ~/mhs
git archive --format=zip --output=../MHS.ZIP HEAD

echo "✅ Backup written to ../MHS.ZIP"