#!/bin/bash -e

lib/manual.sh "In Firefox, navigate to about:config, search for ui.key.menuAccessKeyFocuses, \
and set the Value to false. This prevents the menus from interfering with \
keyboard shortcuts."
lib/manual.sh "In Firefox's settings, change the default font to Times New Roman. \
Many older websites assume Times New Roman is the default \
font. This change allows those sites to display correctly."
