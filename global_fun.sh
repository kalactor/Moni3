#!/usr/bin/env bash

set -e

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No color

scrDir="$(dirname "$(realpath "$0")")"
cloneDir="$(dirname "${scrDir}")"

package_installed() {
    local package=$1
    if pacman -Qi $package &> /dev/null; then
        return 0
    else
        return 1
    fi
}

package_available() {
    local package=$1
    if pacman -Si $package &> /dev/null; then
        return 0
    else
        return 1
    fi
}

yay_available() {
    local package=$1
    if yay -Si $package &> /dev/null; then
        return 0
    else
        return 1
    fi
}

user_input_timer() {
    set +e
    unset userInput
    local timsec=$1
    local msg=$2
    while [[ ${timsec} -ge 0 ]]; do
        echo -ne "\r :: ${msg} (${timsec}s) : "
        read -t 1 -n 1 userInput
        [ $? -eq 0 ] && break
        ((timsec--))
    done
    export userInput
    echo ""
    set -e
}
