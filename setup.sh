#!/bin/bash

HERE="$(cd "$(dirname "$0")" && pwd)"

cd "$HERE/steps"

export TMP="$(mktemp -d)"

STEPS=($(ls *.sh | sort -n))
for STEP in "${STEPS[@]}"; do
  "$HERE/run-step.sh" "$STEP" || exit 1
done
