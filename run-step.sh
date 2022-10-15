#!/bin/bash -e
SCRIPT_NAME="$(basename "$1")"
HERE="$(cd "$(dirname "$0")" && pwd)"

cd "$HERE/steps"

if [ -z "$TMP" ]; then
  export TMP="$(mktemp -d)"
fi

export MANUAL=~/Desktop/README.txt

SCRIPT_PATH="$HERE/steps/$SCRIPT_NAME"

echo
echo -ne "\e[36m"
echo "Running $SCRIPT_PATH"
echo -ne "\e[0m"
if ! "$SCRIPT_PATH"; then
    echo
    echo "*********************************************************"
    echo "Failed in script $SCRIPT_PATH"
    echo "Fix the errors above manually; then try running $HERE/setup.sh again."
    exit 1
fi