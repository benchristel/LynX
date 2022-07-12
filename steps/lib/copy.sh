#!/bin/bash -e

SRC="$1"
DEST="$2"

if [ -e "$DEST" ]; then
    exit 0
fi

mkdir -p "$(dirname "$DEST")"
cp "$SRC" "$DEST"