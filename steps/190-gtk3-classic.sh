#!/bin/bash -e

# If classic is already installed, do nothing.
if apt list --installed 2>/dev/null | grep --quiet "libgtk-3.*~classic"; then
    echo "gtk3-classic is already installed. Skipping."
    exit 0
fi

# gtk3-classic is distributed as a special version of the existing gtk3
# packages. I think this is because apps look for libgtk-3-0 etc. and there's
# no way to tell them to load a library with a different name instead. So
# installing gtk3-classic involves adding a repository with the classic
# version and then running `apt upgrade` to "upgrade" the packages.
#
# Unfortunately, this has the side effect of upgrading *every* package on the
# system. I don't know how to just upgrade libgtk-3-*.
#
# Based on the output of `apt list | grep ~classic | grep installed`, it looks
# like the solution might be:
# sudo apt install --only-upgrade gir1.2-gtk-3.0 gtk-3-examples gtk-update-icon-cache libgail-3-0 libgtk-3-0 libgtk-3-bin libgtk-3-common libgtk-3-dev

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