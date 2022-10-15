#!/bin/bash

HERE="$(cd "$(dirname "$0")" && pwd)"

cd "$HERE/steps"

export TMP="$(mktemp -d)"

ls *.sh | sort -n | \
    while read SCRIPT_NAME; do
        "$HERE/run-step.sh" "$SCRIPT_NAME"
    done
