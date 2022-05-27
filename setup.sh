TXN_ID=0
START_AT="${1:-0}"

announce() {
  echo -ne "\e[36m"
  echo "$@"
  echo -ne "\e[0m"
}

transact() {
  TXN_ID=$((TXN_ID + 1))
  if [ "$START_AT" -gt "$TXN_ID" ]; then
    return 0
  fi
  "$@" || {
    echo
    echo "*** FAILED ***"
    echo "Fix up the error; then try again by running:"
    echo "  bash $0 $TXN_ID"
    echo "To skip this step, run:"
    echo "  bash $0 $((TXN_ID + 1))"
    exit 1
  }
}

run() {
  announce "$@"
  transact "$@"
}

manual() {
  echo "*** MANUAL ACTION REQUIRED ***"
  echo "$1"
  echo -n "Then press ENTER to continue."
  read
}

backup() {
  mv "$1" "/tmp/$(basename "$1").$(date +%Y-%m-%d-%H-%M-%S)"
}

run mkdir -p ~/workspace

# upgrade kernel to 5.14
run sudo apt install linux-oem-20.04d

# install vim
run sudo apt install vim

# install git
run sudo apt install git
run git config --global alias.co checkout
run git config --global alias.st status

# install xclip
run sudo apt install xclip

# install pip3, for xkeysnail
run sudo apt install python3-pip
run sudo pip3 install xkeysnail

# install strace
run sudo apt install systemtap-sdt-dev

# install Obsidian
run flatpak install flathub md.obsidian.Obsidian

# install ccsm
run sudo apt install compizconfig-settings-manager

# install gconf-editor
run sudo apt install gconf-editor

# install the GTK inspector
run sudo apt install libgtk-3-dev
gsettings set org.gtk.Settings.Debug enable-inspector-keybinding true

# install default Windows fonts: Andale Mono, Arial Black, Arial, Comic Sans,
# Courier New, Georgia, Impact, Times New Roman, Trebuchet, Verdana, Webdings
run sudo apt install ttf-mscorefonts-installer

# set up bashrc
if ! grep '. ~/.bash_customizations' ~/.bashrc; then
  cat >> ~/.bashrc <<EOF
if [ -f ~/.bash_customizations ]; then
  . ~/.bash_customizations
fi
EOF
fi

run curl -o ~/.bash_customizations https://raw.githubusercontent.com/benchristel/polished-linux/main/bash_customizations

# install docky
# Name the install script after the user, to avoid collisions with install
# scripts that other users may have placed in /tmp by running this script.
DOCKY_INSTALL_SCRIPT=/tmp/docky-${USER}.sh
run curl -o "$DOCKY_INSTALL_SCRIPT" https://raw.githubusercontent.com/benchristel/polished-linux/main/docky.sh
run bash "$DOCKY_INSTALL_SCRIPT"
cat > ~/.config/autostart/docky.desktop <<EOF
[Desktop Entry]
Name=Docky
Type=Application
Exec=docky
Terminal=false
Icon=docky
Comment=The finest dock no money can buy.
NoDisplay=false
Categories=Utility;
EOF

# install cursor theme
# this should be done before setting up ~/.config, since the dconf database
# references this theme.
# The || test -d at the end recovers from a git clone error if the repository
# already exists.
run bash -c "git clone https://github.com/benchristel/macos-cursor-theme ~/.icons/macos-cursor-theme || test -d ~/.icons/macos-cursor-theme"

# install icon theme
# this should be done before setting up ~/.config, since the dconf database
# references this theme.
run bash -c "git clone https://github.com/benchristel/linux-mint-icons-osx ~/.icons/osx || test -d ~/.icons/osx"

# install theme for controls and window borders
run bash -c "git clone https://github.com/benchristel/Mint-X-Hacks ~/.themes/osx || test -d ~/.themes/osx"
run ~/.themes/osx/install.sh

# set up ~/.config
run curl -o ~/.config/dconf.ini \
  https://raw.githubusercontent.com/benchristel/config/main/dconf.ini
run curl -o ~/.config/cinnamon-monitors.xml \
  https://raw.githubusercontent.com/benchristel/config/main/cinnamon-monitors.xml
run dconf load / < ~/.config/dconf.ini

# configure cinnamon
# Name the tmp repo after the user to avoid collisions with other users who may
# be running this script simultaneously
TMP_CINNAMON_CONFIG=/tmp/cinnamon-config-$USER
run bash -c "git clone https://github.com/benchristel/cinnamon-config '$TMP_CINNAMON_CONFIG' || test -d '$TMP_CINNAMON_CONFIG'"
run backup ~/.cinnamon/configs
run mv "$TMP_CINNAMON_CONFIG" ~/.cinnamon/configs

# configure redshift
run curl -o ~/.config/redshift.conf \
  https://raw.githubusercontent.com/benchristel/config/main/redshift.conf
run curl -o ~/.config/autostart/redshift-gtk.desktop \
  https://raw.githubusercontent.com/benchristel/config/main/autostart/redshift-gtk.desktop

# set up xkeysnail with macOS keybindings
run bash -c "git clone https://github.com/benchristel/xkeysnail-macos-keymap ~/workspace/xkeysnail-macos-keymap || test -d ~/workspace/xkeysnail-macos-keymap"
echo "Creating .config/autostart/xkeysnail.desktop"
>~/.config/autostart/xkeysnail.desktop cat <<EOF
[Desktop Entry]
Name=xkeysnail
Comment=remap keyboard input
Exec=sudo /home/${USER}/workspace/xkeysnail-macos-keymap/run
Type=Application
EOF
run sudo su root -c "echo '$USER ALL=NOPASSWD:/home/$USER/workspace/xkeysnail-macos-keymap/run' >/etc/sudoers.d/xkeysnail-$USER"
run sudo su root -c "chmod 440 /etc/sudoers.d/xkeysnail-$USER"

manual "Right-click the Linux Mint menu in the lower left corner of the screen, choose Configure from the menu that pops up, and change the 'keyboard shortcut to open and close the menu' to Super+Space"

manual "In the Firefox location bar, go to about:config, search for ui.key.menuAccessKeyFocuses, and set the Value to false."

manual "In Firefox's settings, change the default font to Times New Roman"

# TODO: automate this if it turns out that gtk3-classic is a good idea
manual "Install gtk3-classic. See the polished-linux wiki for instructions"

echo
echo "*** Success! ***"
echo "Reboot for changes to take effect."
