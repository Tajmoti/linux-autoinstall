#!/bin/bash

# Generic software URLs
jb_toolbox_url=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' | sed -rn 's|^.*"linux":\{"link":"([^"]*).*$|\1|p')
netextender_url="https://software.sonicwall.com/NetExtender/NetExtender.Linux-10.2.824.x86_64.tgz"

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
