#!/bin/bash

echo "Setting up docker"
sudo groupadd docker
sudo usermod -aG docker ${USER}