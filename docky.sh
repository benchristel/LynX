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

  # configure docky
  gconftool-2 --set "/apps/docky-2/Docky/Services/ThemeService/Theme" --type string Glass
  gconftool-2 --set "/apps/docky-2/Docky/Services/ThemeService/UrgentHue" --type int 0
)
