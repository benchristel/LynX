#!/bin/bash -eu

if ! [ -f "$MANUAL" ]; then
    >>"$MANUAL" echo "Recommended manual setup steps:"
    >>"$MANUAL" echo
fi

>>"$MANUAL" echo "- $1"