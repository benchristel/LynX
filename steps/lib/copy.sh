#!/bin/bash -e

SRC="$1"
DEST="$2"

if [ -e "$DEST" ]; then
    echo "File $DEST already exists. Leaving it alone."
    exit 0
fi

mkdir -p "$(dirname "$DEST")"
cp "$SRC" "$DEST"