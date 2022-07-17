#!/bin/bash -e

lib/install.sh autokey-common
lib/install.sh autokey-gtk

# Set up macOS-like keybindings
lib/github-clone.sh benchristel/autokeyconf
pushd ~/workspace/benchristel/autokeyconf
    # ~/.bashrc early-exits if not run from an interactive shell, so source
    # ~/.bashrc.d/chruby directly
    source ~/.bashrc.d/chruby
    chruby 3
    ./autokeyconf example_config.yaml
popd

# Launch AutoKey at startup
lib/copy.sh data/autokey.desktop ~/.config/autostart/autokey.desktop