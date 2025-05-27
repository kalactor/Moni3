#!/bin/bash

# Handle click events
case "$BLOCK_BUTTON" in
    1) pamixer --toggle-mute ;;
    3) pavucontrol & ;;
    4) pamixer --increase 5 ;;
    5) pamixer --decrease 5 ;;
esac

# Get volume info
volume=$(pamixer --get-volume)
muted=$(pamixer --get-mute)

if [ "$muted" = "true" ]; then
	echo -e "  ${volume}%"
	echo ""
	echo "#FF0000"
elif [ "$volume" -ge 70 ]; then
	echo -e "   ${volume}%"
	echo ""
	echo "#FFFF00"
elif [ "$volume" -ge 30 ]; then
	echo -e "  ${volume}%"
	echo ""
else
	echo -e " ${volume}%"
	echo ""
fi
