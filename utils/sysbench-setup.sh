#!/bin/bash
sudo apt update -y
sudo apt upgrade -y

PACKAGES_TO_INSTALL="sysbench make automake libtool pkg-config libaio-dev"
for package in $PACKAGES_TO_INSTALL; do
  sudo apt install -y $package
done