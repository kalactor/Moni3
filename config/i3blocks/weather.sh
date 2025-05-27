#!/bin/bash

weather=$(curl -Ss 'https://wttr.in/Rabarka?0&T&Q' | cut -c 16- | head -2)

if [[ $weather =~ \+([0-9]+) ]]; then
    degree="${BASH_REMATCH[1]}"
fi

echo $weather
echo "$degree C"

if [ $degree -gt 49 ]; then
	echo "#FF0000"
elif [ $degree -gt 40 ]; then
	echo "#FFFF00"
fi
