#!/bin/bash -eu

REPO="$1"

mkdir -p ~/workspace/"$(dirname "$REPO")"
if ! [ -d ~/workspace/"$REPO" ]; then
    git clone "https://github.com/${REPO}.git" ~/workspace/"$REPO"
fi
