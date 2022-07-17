#!/bin/bash

HERE="$(cd "$(dirname "$0")" && pwd)"

cd "$HERE/steps"

export MANUAL="/tmp/manual.txt"
rm -f "$MANUAL"

ls *.sh | sort -n | \
    while read SCRIPT_NAME; do
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
    done

if [ "$?" == 0 ]; then
    echo
    echo "-------------------------------------------------------------"
    echo "Almost done! You just need to:"
    echo "- cat $MANUAL for recommended manual setup steps"
    echo "- Reboot for all changes to take effect."
fi