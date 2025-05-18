#!/usr/bin/env bash
# e.g. cpu.sh

usage=$(grep '^cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print int(usage)}')
full="CPU: ${usage}%"
short="${usage}%"
color="#${usage}<50?00FF00:FF0000"  # pseudo-bash for logic

echo "$full"
echo "$short"
if [ "$usage" -lt 50 ]; then
  echo "#00FF00"
else
  echo "#FF0000"
fi

