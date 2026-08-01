#!/bin/bash

# Atualização para ecossistema moderno (2026-ready)

cd ~

# Disable screen blanking
echo "xset -dpms" >> ~/.bashrc
echo "xset s off" >> ~/.bashrc

# Set ABNT2 keyboard
echo "setxkbmap -model abnt2 -layout br" >> ~/.bashrc

export DEBIAN_FRONTEND=noninteractive

echo "========================================================="
echo "Updating the system"
echo "========================================================="

sudo apt update
sudo apt full-upgrade -y
sudo apt install dkms -y

echo "========================================================="
echo "Installing Docker + Plaso"
echo "========================================================="

sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo docker pull log2timeline/plaso

echo "========================================================="
echo "Installing Volatility 3 (Recommended)"
echo "========================================================="

sudo apt install -y git python3 python3-pip build-essential \
    libdistorm3-dev yara libcapstone-dev capstone-tool

pip3 install --upgrade pip setuptools wheel
pip3 install volatility3

echo "========================================================="
echo "Cleaning unused packages"
echo "========================================================="

sudo apt autoremove -y

echo "========================================================="
echo "Installation finished successfully"
echo "========================================================="