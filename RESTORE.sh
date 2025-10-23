#!/usr/bin/env bash

echo
echo
echo
echo "WARNING: This will erase all local changes!"
echo
echo "This script will RESTORE your local code to the previous version."
echo
echo "It will ERASE any local changes you have made. They will be LOST."
echo
echo "First, please take a backup to ZIP using  zipall.sh  etc."
echo
echo "You can press CTRL+C now to exit."
echo
echo "Do you want to lose changes? Return to the last GIT version?"
echo
echo
echo

read -r -p "Type  YESSS  to proceed, or CTRL+C to cancel : "
echo

if [[ "$REPLY" != "YESSS" ]]
then
	echo "Aborting RESTORE. Nothing changed."
	exit 1
fi

# go ahead with RESTORE
echo "Proceeding with RESTORE now..."
sleep 5

# restores modified files in working directory to their last GIT commit
# does not remove untracked files
echo "Restoring to last GIT version..."
git restore .
git clean -fd

echo
echo "RESTORE complete."
echo "You are back to the last GIT version."
echo
