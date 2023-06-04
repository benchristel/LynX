#!/bin/bash -e

lib/install.sh xscreensaver
lib/install.sh xscreensaver-data
lib/install.sh xscreensaver-data-extra
lib/install.sh xscreensaver-gl
lib/install.sh xscreensaver-gl-extra

lib/copy.sh /usr/share/xscreensaver/xscreensaver-daemon.desktop ~/.config/autostart/xscreensaver-daemon.desktop

lib/manual.sh "Run the Screensaver app and choose a screensaver. The 'Flurry' screensaver from Mac OSX is available."