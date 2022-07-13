#!/bin/bash -eu

FILE="$1"
BACKUP="/tmp/$(basename "$FILE").$(date +%Y-%m-%d-%H-%M-%S)"

if [ -e "$FILE" ]; then
    echo "Backing up $FILE to $BACKUP"
    mv "$FILE" "$BACKUP"
fi