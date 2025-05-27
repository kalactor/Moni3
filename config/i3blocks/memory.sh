#!/bin/bash

full=$(free -h | awk '/^Mem/ { print $3 " " $2 }')
short=$(free -h | awk '/^Mem/ { print $3 }')
mem_kib=$(free -k | awk '/^Mem/ { print $3 }')
used_mib=$((mem_kib / 1024))

echo $full
echo $short

if (( used_mib >= 3000 )); then
    echo "#FF0000"    # red for critical
elif (( used_mib >= 2500 )); then
    echo "#FFFF00"    # yellow for warning
fi

