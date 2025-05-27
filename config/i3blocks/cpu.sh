#!/usr/bin/env bash
# e.g. cpu.sh

usage=$(grep '^cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print int(usage)}')
full="CPU: ${usage}%"
short="${usage}%"
color="#${usage}<50?00FF00:FF0000"

echo "$full"
echo "$short"
if (( $usage >= 50 )); then
	echo "#FFFF00"
elif (( $usage >= 70 )); then
	echo "#FF0000"
fi

