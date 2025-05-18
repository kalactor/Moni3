#!/bin/bash

total_updates=$(checkupdates | wc -l)

updater(){
if (( total_updates > 0 )); then
	echo "🗘 ${total_updates}"
fi
}

updater

if [[ $BLOCK_BUTTON == 1 ]]; then
	alacritty -e bash -c "sudo pacman -Syu --noconfirm; echo; read -p 'Press ENTER to close...'"
	updater
	exit
fi
