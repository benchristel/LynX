#!/bin/bash -eu

if ! [ -f "$MANUAL" ]; then
    >>"$MANUAL" echo "Thanks for trying LynX!

There are a few more things we recommend doing to set up your new computer. \
This file is saved to your desktop as $(basename "$MANUAL"), so you can \
refer to it later if you don't want to do these steps now."
fi

>>"$MANUAL" echo
>>"$MANUAL" echo "■ $1"
