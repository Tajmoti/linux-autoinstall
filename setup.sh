#!/bin/bash

# Location for temporary install files
workdir="/tmp/tajmoinstall"

# Preparations
set -e
trap clean_up EXIT
clean_up () {
    ARG=$?
    # Cleanup
    echo "Exited with code $ARG, cleaning up..."
    popd && rm -rf "$workdir"
    exit $ARG
}
script_dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Working directory setup
echo "Entering workdir '$workdir'"
rm -rf "$workdir"
mkdir "$workdir"
pushd "$workdir"

source "$script_dir/module/apt.sh"
source "$script_dir/module/flatpak.sh"
source "$script_dir/module/env.sh"
source "$script_dir/module/custom-sw.sh"
source "$script_dir/module/adb-udev.sh"
