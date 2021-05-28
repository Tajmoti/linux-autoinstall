#!/bin/bash

# Location for temporary install files
workdir="/tmp/tajmoinstall"

hamachi_url="https://www.vpn.net/installers/logmein-hamachi_2.1.0.203-1_amd64.deb"
insync_url="https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.4.0.40973-buster_amd64.deb"
netextender_url="https://software.sonicwall.com/NetExtender/NetExtender.Linux-10.2.824.x86_64.tgz"

# APT packages to install
apt_packages="\
cmake \
docker \
flatpak \
gnome-software-plugin-flatpak \
meld \
vim \
virt-manager \
"

# Flatpaks to install (mostly flom FlatHub)
flatpaks="\
com.discordapp.Discord \
com.github.PintaProject.Pinta \
com.github.ztefn.haguichi \
com.microsoft.Teams \
com.slack.Slack \
com.spotify.Client \
com.valvesoftware.Steam \
org.chromium.Chromium \
org.videolan.VLC \
org.flameshot.Flameshot \
org.flameshot.Flameshot \
"

# APT packages to purge
crapware="\
evolution \
gnome-calendar \
gnome-contacts \
gnome-clocks \
gnome-documents \
gnome-games \
gnome-maps \
gnome-music \
gnome-todo \
gnome-weather \
malcontent \
rhythmbox \
shotwell \
synaptic \
totem \
xterm \
yelp \
"

# Preparations
echo "Entering workdir '$workdir'"
mkdir "$workdir" && pushd "$workdir"

# Update APT cache
sudo apt update

# Install APT packages
echo "Installing APT packages"
sudo apt install -y $apt_packages

# Uninstall useless software
echo "Uninstalling crapware"
sudo apt purge --autoremove $crapware

# Upgrade packages
echo "Upgrading packages"
sudo apt upgrade

# Flatpak
echo "Setting up Flatpak"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo "Installing Flatpaks"
flatpak install -y $flatpaks

# Custom software
echo "Downloading custom software"
wget -O hamachi.deb "$hamachi_url"
wget -O teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
wget -O insync.deb "$insync_url"
wget -O jb-toolbox.tar.gz https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux
wget -O netextender.tar.gz "$netextender_url"

echo "Unpacking custom software"
tar -xf jb-toolbox.tar.gz
tar -xf netextender.tar.gz

echo "Installing custom software"
sudo apt install -y ./hamachi.deb
sudo apt install -y ./teamviewer.deb
sudo apt install -y ./insync.deb
jetbrains-toolbox*/jetbrains-toolbox
pushd netExtenderClient
sudo ./install
popd

# Cleanup
popd
rm -rf "$workdir"
