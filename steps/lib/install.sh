#!/bin/bash -eu

PACKAGE="$1"

if apt list --installed "$PACKAGE" 2>/dev/null | grep -q "$PACKAGE"; then
    echo "$PACKAGE is already installed. Skipping."
    exit 0
fi

sudo apt install -y "$PACKAGE"
