#!/bin/bash -e

lib/install.sh libgtk-3-dev
gsettings set org.gtk.Settings.Debug enable-inspector-keybinding true