#!/bin/bash -e

# TODO: this should really be split up into separate files for each
# application being configured, for maintainability (i.e. if I remove an app
# I'd like the config to go with it).

mkdir -p ~/.config
TEMP="$(mktemp -d)"
curl -o "$TEMP/dconf.ini" \
  https://raw.githubusercontent.com/benchristel/config/main/dconf.ini
dconf load / <"$TEMP/dconf.ini"