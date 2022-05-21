run() {
  echo "$@"
  "$@" || exit 1
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

# install xclip
run sudo apt install xclip

# install pip3, for xkeysnail
run sudo apt install python3-pip
run sudo pip3 install xkeysnail

# install strace
run sudo apt install systemtap-sdt-dev

# install Obsidian
run flatpak install flathub md.obsidian.Obsidian

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

manual "Reboot for changes to take effect."
