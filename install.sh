#!/usr/bin/env bash

set -e

scrDir="$(dirname "$(realpath "$0")")"
source "${scrDir}/global_fun.sh"

# Installing yay
${scrDir}/yay.sh

# Installing packages
${scrDir}/install_packages.sh

# Installing dotfiles
mkdir -p "${HOME}/.config"
mkdir -p "${HOME}/Pictures"

cp -r "${scrDir}/Pictures/"* "${HOME}/Pictures/"
cp -r "${scrDir}/config/"* "${HOME}/.config/"