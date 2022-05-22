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
    echo "  bash setup.sh $TXN_ID"
    echo "To skip this step, run:"
    echo "  bash setup.sh $((TXN_ID + 1))"
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

# set up bashrc
if ! grep '. ~/.bash_customizations' ~/.bashrc; then
  cat >> ~/.bashrc <<EOF
if [ -f ~/.bash_customizations ]; then
  . ~/.bash_customizations
fi
EOF
fi

run curl -o ~/.bash_customizations https://raw.githubusercontent.com/benchristel/polished-linux/main/bash_customizations
# install cursor theme
# this should be done before setting up ~/.config, since the dconf database
# references this theme.
run git clone https://github.com/benchristel/macos-cursor-theme ~/.icons/macos-cursor-theme

# install icon theme
# this should be done before setting up ~/.config, since the dconf database
# references this theme.
run git clone https://github.com/benchristel/linux-mint-icons-osx ~/.icons/osx

# install theme for controls and window borders
run git clone https://github.com/benchristel/Mint-X-Hacks ~/.themes/osx

# create ~/.config
manual "Move or delete your ~/.config directory."
run git clone https://github.com/benchristel/config ~/.config

# set up xkeysnail with macOS keybindings
run git clone https://github.com/benchristel/xkeysnail-macos-keymap ~/workspace/xkeysnail-macos-keymap
echo "Creating .config/autostart/xkeysnail.desktop"
>~/.config/autostart/xkeysnail.desktop cat <<EOF
[Desktop Entry]
Name=xkeysnail
Comment=remap keyboard input
Exec=sudo /home/${USER}/workspace/xkeysnail-macos-keymap/run
Type=Application
EOF
run sudo su root -c "echo '$USER ALL=NOPASSWD:/home/$USER/workspace/xkeysnail-macos-keymap/run' >/etc/sudoers.d/xkeysnail"
run sudo su root -c "chmod 440 /etc/sudoers.d/xkeysnail"

manual "Right-click the Linux Mint menu in the lower left corner of the screen, choose Configure from the menu that pops up, and change the 'keyboard shortcut to open and close the menu' to Super+Space"

manual "In the Firefox location bar, go to about:config, search for ui.key.menuAccessKeyFocuses, and set the Value to false."

manual "Reboot for changes to take effect."
