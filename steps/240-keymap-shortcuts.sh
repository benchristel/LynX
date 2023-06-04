#!/bin/bash -e

lib/copy.sh data/swap-win-and-alt.desktop ~/Desktop/"Swap Alt and Windows Keys".desktop
lib/copy.sh data/restore-win-and-alt.desktop ~/Desktop/"Restore Alt and Windows Keys".desktop

lib/manual.sh "Use the shortcuts on your desktop named 'Swap/Restore Alt and \
Windows Keys' to configure your keyboard to your liking. If you are used to \
touch-typing on a Mac, and are now using a Windows keyboard, we recommend \
swapping Alt and Windows."