#!/usr/bin/env bash
# wifi_block.sh

iface=$(iw dev | awk '$1=="Interface"{print $2}')
if [ -z "$iface" ]; then
  echo "🚫 No WiFi"; echo ""; echo "#FF0000"; exit 0
fi

link=$(iw dev $iface link)
ssid=$(awk -F': ' '/SSID/ {print $2}' <<<"$link")
sig=$(awk '/signal/ {print int($2+0)}' <<<"$link")
bars=$(( (sig + 100) * 5 / 70 ))  # map -100…-30 to 0…5 bars

icons=(__ ▂ ▃ ▄ ▅ ▆)
icon=${icons[$bars]}
full="📶 $icon $ssid"
short="$icon"
color=$(( sig > -40 )) && echo "#00FF00" || echo "#FFA500"

echo "$full"
echo "$short"
echo "$color"

