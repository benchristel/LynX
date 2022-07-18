#!/bin/bash -e

if ! which docky >/dev/null; then
    mkdir -p /tmp/docky
    (
        cd /tmp/docky

        # install dependencies
        wget -c http://archive.ubuntu.com/ubuntu/pool/universe/g/gnome-sharp2/libgconf2.0-cil_2.24.2-4_all.deb
        wget -c http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1_amd64.deb
        wget -c http://archive.ubuntu.com/ubuntu/pool/universe/libg/libgnome-keyring/libgnome-keyring-common_3.12.0-1build1_all.deb
        wget -c http://archive.ubuntu.com/ubuntu/pool/universe/libg/libgnome-keyring/libgnome-keyring0_3.12.0-1build1_amd64.deb
        wget -c http://archive.ubuntu.com/ubuntu/pool/universe/g/gnome-keyring-sharp/libgnome-keyring1.0-cil_1.0.0-5_amd64.deb

        sudo apt-get install ./*.deb

        # install docky
        wget -c http://archive.ubuntu.com/ubuntu/pool/universe/d/docky/docky_2.2.1.1-1_all.deb
        sudo apt-get install ./docky_2.2.1.1-1_all.deb
    )
fi

# configure docky
gconftool-2 --set "/apps/docky-2/Docky/Services/ThemeService/UrgentHue" --type int 0
gconftool-2 --set "/apps/docky-2/Docky/Items/DockyItem/ShowDockyItem" --type bool false
gconftool-2 --set "/apps/docky-2/Docky/Interface/DockPreferences/Dock1/Launchers" \
  --type list --list-type string \
"[file:///usr/share/applications/nemo.desktop,\
file:///usr/share/applications/mintinstall-kde.desktop,\
file:///usr/share/applications/firefox.desktop,\
file:///usr/share/applications/rhythmbox.desktop,\
file:///usr/share/applications/libreoffice-writer.desktop,\
file:///usr/share/applications/libreoffice-calc.desktop,\
file:///usr/share/applications/libreoffice-impress.desktop,\
file:///usr/share/applications/thunderbird.desktop,\
file:///usr/share/applications/org.gnome.Calendar.desktop,\
file:///usr/share/applications/cinnamon-settings.desktop]"

gconftool-2 --set "/apps/docky-2/Docky/Interface/DockPreferences/Dock1/SortList" \
  --type list --list-type string \
"[/usr/share/applications/nemo.desktop,\
/usr/share/applications/mintinstall-kde.desktop,\
/usr/share/applications/firefox.desktop,\
/usr/share/applications/rhythmbox.desktop,\
/usr/share/applications/libreoffice-writer.desktop,\
/usr/share/applications/libreoffice-calc.desktop,\
/usr/share/applications/libreoffice-impress.desktop,\
/usr/share/applications/org.gnome.Calendar.desktop,\
/usr/share/applications/cinnamon-settings.desktop,\
TrashCan]"

# Launch on login
lib/copy.sh data/docky.desktop ~/.config/autostart/docky.desktop

# install Frost theme
lib/github-clone.sh benchristel/docky-frost ~/.local/share/docky/themes/Frost
gconftool-2 --set "/apps/docky-2/Docky/Services/ThemeService/Theme" --type string Frost
gconftool-2 --set "/apps/docky-2/Docky/Interface/DockPreferences/Dock1/IconSize" --type int 64
gconftool-2 --set "/apps/docky-2/Docky/Interface/DockPreferences/Dock1/IndicateMultipleWindows" --type bool false
gconftool-2 --set "/apps/docky-2/Docky/Interface/DockPreferences/Dock1/ThreeDimensional" --type bool true
gconftool-2 --set "/apps/docky-2/Docky/Interface/DockPreferences/Dock1/ZoomEnabled" --type bool true
gconftool-2 --set "/apps/docky-2/Docky/Interface/DockPreferences/Dock1/ZoomPercent" --type float 1.5
gconftool-2 --set "/apps/docky-2/Docky/Interface/DockPreferences/Dock1/Plugins" --type list --list-type string "[Trash]"