#!/bin/bash -e

if ! [ -e /etc/apt/sources.list.d/lah7-gtk3-classic-focal.list ]; then
    sudo add-apt-repository ppa:lah7/gtk3-classic
fi

# I ran sudo apt dist-upgrade here but it might not have been necessary
# sudo apt dist-upgrade

sudo apt update \
    -o Dir::Etc::sourcelist="sources.list.d/lah7-gtk3-classic-focal.list" \
    -o Dir::Etc::sourceparts="-" \
    -o APT::Get::List-Cleanup="0"

sudo apt upgrade