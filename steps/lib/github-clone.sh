#!/bin/bash -eu

REPO="$1"
DEST="${2:-"$HOME/workspace/$REPO"}"

mkdir -p "$(dirname "$DEST")"
if ! [ -d "$DEST" ]; then
    echo git clone "https://github.com/${REPO}.git" "$DEST"
    git clone "https://github.com/${REPO}.git" "$DEST"
fi
