#!/bin/bash

# Flatpaks to install (mostly from FlatHub)
flatpaks="$(cat $script_dir/config/flatpak-install.txt)"

# Flatpak
echo "Setting up Flatpak"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo "Installing Flatpaks"
flatpak install -y $flatpaks
