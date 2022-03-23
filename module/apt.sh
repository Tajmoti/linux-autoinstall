#!/bin/bash

# Commands
cmd_wget="wget -q"
cmd_apt="apt -qq -o=Dpkg::Use-Pty=0"

# APT packages to install
apt_packages="$(cat $script_dir/config/apt-install.txt)"

# APT packages to purge
crapware="$(cat $script_dir/config/apt-purge.txt)"

# DEB software URLs
deb_urls="https://www.vpn.net/installers/logmein-hamachi_2.1.0.203-1_amd64.deb \
https://download.teamviewer.com/download/linux/teamviewer_amd64.deb \
"

# APT preparations
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
codename=$(lsb_release -c | cut -d$'\t' -f2)
echo "deb http://apt.insync.io/debian $codename non-free contrib" | sudo tee /etc/apt/sources.list.d/insync.list

# Update APT cache
echo "Updating APT cache"
sudo $cmd_apt update

# Install APT packages
echo "Installing APT packages"
sudo $cmd_apt install -y $apt_packages

# Uninstall useless software
echo "Uninstalling APT crapware"
sudo $cmd_apt purge -y --autoremove $crapware

# Prepare for DEB file installation
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
