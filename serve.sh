#!/bin/bash
# serve.sh
set -e
mkdocs serve &
sleep 5
echo -e "\nmkdocs process started:"
ps | grep mkdocs
start "" http://127.0.0.1:8000
echo "use ps to find then kill mkdocs process"
