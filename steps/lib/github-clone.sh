#!/bin/bash -eu

REPO="$1"
DEST="${2:-"$HOME/workspace/$REPO"}"

mkdir -p "$(dirname "$DEST")"
if [ -d "$DEST/.git" ]; then
    echo "$DEST already exists and is a Git repo. Skipping."
    exit 0
fi

echo git clone "https://github.com/${REPO}.git" "$DEST"

# clone and checkout as separate steps to overwrite any existing files
# in the directory. This is needed for the ~/.cinnamon/configs directory,
# to work around a race condition where Cinnamon writes to a file in the
# directory while the clone is in progress.
git clone --no-checkout "https://github.com/${REPO}.git" "$DEST"
git -C "$DEST" checkout -f HEAD