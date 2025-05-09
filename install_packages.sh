#!/usr/bin/env bash

set -e

scrDir="$(dirname "$(realpath "$0")")"
source "${scrDir}/global_fun.sh"

declare -a pkg_list
PACKAGE_LIST="i3-packages.lst"
packman_pkgs=""
yay_pkgs=""

if [ ! -f $PACKAGE_LIST ]; then
    echo "Error: Package list file : $PACKAGE_LIST not found."
    exit 1
fi

# Read package names from the file and store them in the array
while IFS= read -r line; do
    # Ignore empty lines or lines that start with #
    if [[ ! "$line" =~ ^# && -n "$line" ]]; then
        # Extract the first column (package name) and add to the array
        pkg_name=$(echo "$line" | awk '{print $1}')
        if ! package_installed $pkg_name; then
            pkg_list+=("$pkg_name")  # Add the package name to the array
        fi
    fi
done < "$PACKAGE_LIST"

for i in "${pkg_list[@]}"; do
    if package_available $i; then
        packman_pkgs+="$i "
    else
        yay_pkgs+="$i "
    fi
done

# Install packages via pacman if available
if [ -n "$packman_pkgs" ]; then
    sudo pacman -S --needed --noconfirm $packman_pkgs
else
    echo "Pacman programs: No packages to install."
fi

# Install packages via yay if available
if [ -n "$yay_pkgs" ]; then
    yay -S --needed --noconfirm $yay_pkgs
else
    echo "Yay programs: No packages to install."
fi
