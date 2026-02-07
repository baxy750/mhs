#!/usr/bin/env bash
#set -euo pipefail

## Always run from the script's directory
#cd "$(dirname "$0")"
#proj="$(pwd -W 2>/dev/null || pwd)"  # -W for proper Windows path if available

## Hand off to PowerShell (exec releases this script, avoiding 'busy' errors)
#exec powershell -NoProfile -Command "
#  \$proj = '$proj'
#  \$dest = Join-Path \$proj 'MHS.ZIP'
#  if (Test-Path \$dest) { Remove-Item -Force \$dest }

#  Add-Type -AssemblyName System.IO.Compression.FileSystem
#  \$tmp = Join-Path \$env:TEMP ('BACKUP_' + (Get-Date -Format yyyyMMdd_HHmmss) + '.zip')

#  # Create zip of the project folder (recursive, includes hidden files)
#  [IO.Compression.ZipFile]::CreateFromDirectory(\$proj, \$tmp, [IO.Compression.CompressionLevel]::Optimal, \$true)

#  Move-Item -Force \$tmp \$dest
#"
#