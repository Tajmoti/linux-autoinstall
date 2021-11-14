#!/bin/bash

script_dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Location for temporary install files
workdir="/tmp/tajmoinstall"

# Commands
cmd_wget="wget -q"
cmd_apt="apt -qq -o=Dpkg::Use-Pty=0"

# APT packages to install
apt_packages="\
apt-transport-https \
ca-certificates \
curl \
cmake \
docker-ce \
flatpak \
gnome-software-plugin-flatpak \
gnupg \
libccid \
lsb-release \
meld \
openjdk-11-jre \
opensc \
vim \
virt-manager \
"

# Flatpaks to install (mostly from FlatHub)
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
us.zoom.Zoom \
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

# DEB software URLs
deb_urls="https://www.vpn.net/installers/logmein-hamachi_2.1.0.203-1_amd64.deb \
https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.4.0.40973-buster_amd64.deb \
https://files.multimc.org/downloads/multimc_1.5-1.deb \
https://download.teamviewer.com/download/linux/teamviewer_amd64.deb \
"

# Generic software URLs
jb_toolbox_url="https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.20.8352.tar.gz"
netextender_url="https://software.sonicwall.com/NetExtender/NetExtender.Linux-10.2.824.x86_64.tgz"


# Preparations
echo "Entering workdir '$workdir'"
rm -rf "$workdir" && mkdir "$workdir" && pushd "$workdir"

# APT preparations
echo "Setting up APT keys and repositories"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 

# Update APT cache
echo "Updating APT cache"
sudo $cmd_apt update

# Install APT packages
echo "Installing APT packages"
sudo $cmd_apt install -y $apt_packages

# Uninstall useless software
echo "Uninstalling APT crapware"
sudo $cmd_apt purge -y --autoremove $crapware

# Flatpak
echo "Setting up Flatpak"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo "Installing Flatpaks"
flatpak install -y $flatpaks

mkdir "deb" && pushd "deb"

# Download DEB files
echo "Downloading DEB files"
$cmd_wget $deb_urls

# Install DEB files
echo "Installing DEB files"
sudo $cmd_apt install -y ./*.deb

popd

# Upgrade packages
echo "Upgrading APT packages"
sudo $cmd_apt upgrade -y

# Custom software
echo "Downloading custom software"
$cmd_wget -O jb-toolbox.tar.gz "$jb_toolbox_url"
$cmd_wget -O netextender.tar.gz "$netextender_url"

echo "Unpacking custom software"
tar -xf jb-toolbox.tar.gz
tar -xf netextender.tar.gz

echo "Installing custom software"
jetbrains-toolbox*/jetbrains-toolbox
pushd netExtenderClient
sudo ./install
popd

echo "Setting up docker"
sudo groupadd docker
sudo usermod -aG docker ${USER}

echo "Setting up environment"
souce "$script_dir/env.sh"

echo "Setting up ADB"
source "$script_dir/adb-udev.sh"

# Cleanup
echo "Cleaning up"
popd && rm -rf "$workdir"
