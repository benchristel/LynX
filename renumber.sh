#!/bin/bash

HERE="$(cd "$(dirname "$0")" && pwd)"

N=10

ls "$HERE/steps" | grep ".sh" | sort -n | \
    while read FILENAME; do
        NO_NUMBER="$(echo "$FILENAME" | sed -E 's|^[0-9]+||')"
        RENUMBERED="${N}${NO_NUMBER}"
        if [ "$FILENAME" != "$RENUMBERED" ]; then
            mv --no-clobber "$HERE/steps/$FILENAME" "$HERE/steps/$RENUMBERED"
        fi
        N=$((N + 10))
    done