# polished-linux

Configures Linux Mint to work more or less like macOS.

The target is Mac OSX 10.6.

![screenshot](screenshot.png)

## Getting Started

1. [Install Linux Mint Cinnamon 20.3 Edge](https://www.linuxmint.com/edition.php?id=296)
1. Run the following in the terminal. You will be prompted for your password.
   ```bash
   cd `mktemp -d`
   wget -O polished-linux.zip https://github.com/benchristel/polished-linux/archive/refs/heads/main.zip
   unzip polished-linux.zip
   polished-linux-main/setup.sh
   ```

## What's in the box?

- OSX-style window borders and controls
- Dock configuration and theme
- macOS keybindings (e.g. Super+C instead of Ctrl+C to copy)
- OSX-style icons and cursors
- The classic OSX "Flurry" screensaver
- ...and more!

## Map of Files Created/Modified

```
~/
  .bashrc
  .bashrc.d/
  .cinnamon/configs/
  .config/
    redshift.conf
    autostart/
      docky.desktop
      redshift-gtk.desktop
      xscreensaver-daemon.desktop
    gtk-3.0/
      gtk.css
      osx-gtk-overrides.css
  .icons/
    osx/
    macos-cursor-theme/
  .local/share/
    docky/themes/Frost/
    fonts/
  .rubies/
  .themes/osx/
  workspace/benchristel/autokeyconf/
```

## Updating

The installed themes are all git repos. To get the latest, do:

```
git -C ~/.icons/osx pull
git -C ~/.icons/macos-cursor-theme pull
git -C ~/.local/share/docky/themes/Frost pull
git -C ~/.themes/osx pull
~/.themes/osx/install.sh
```