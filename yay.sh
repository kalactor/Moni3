#!/usr/bin/env bash

set -e

scrDir="$(dirname "$(realpath "$0")")"
source "${scrDir}/global_fun.sh"

if package_installed "yay" &> /dev/null; then
    echo -e "${GREEN}yay is already installed!${NC}"
    exit 0
fi

# Install yay

echo -e "${YELLOW}yay is not installed, Installing...${NC}"
echo -e "${YELLOW}Updating system...${NC}"
sudo pacman -Sy --noconfirm

echo -e "${YELLOW}Installing dependencies...${NC}"
sudo pacman -S --needed --noconfirm git base-devel

echo -e "${YELLOW}Cloning yay repository...${NC}"
git clone https://aur.archlinux.org/yay.git || { echo -e "${RED}Error: Failed to clone yay repository${NC}"; exit 1; }
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay  # Cleanup

echo -e "${GREEN}yay has been installed successfully!${NC}"