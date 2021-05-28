#!/bin/bash

workdir="/tmp/tajmoinstall"
flatpaks="\
com.discordapp.Discord \
com.github.ztefn.haguichi \
com.microsoft.Teams \
com.slack.Slack \
com.spotify.Client \
org.chromium.Chromium \
org.flameshot.Flameshot \
org.flameshot.Flameshot \
"

# Preparations
echo "Entering workdir '$workdir'"
mkdir "$workdir" && cd "$workdir"

# Flatpak
echo "Setting up flatpak"
sudo apt install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
wget https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux

echo "Installing flatpaks"
flatpak install $flatpaks

# Steam
sudo apt install -y steam

