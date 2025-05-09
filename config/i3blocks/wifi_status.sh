#!/usr/bin/env bash

# Handle click events
if [ "$BLOCK_BUTTON" = "1" ]; then
    nm-connection-editor &
fi

# Get active wifi interface
interface=$(iw dev | awk '$1=="Interface"{print $2}' | head -n1)

# If no wifi interface
if [ -z "$interface" ]; then
    echo "🚫  No WiFi"    # full_text
    echo "🚫"               # short_text (blank)
    echo "#FF0000"       # colour (red)
    exit 0
fi

# Get SSID and Signal
ssid=$(iw dev "$interface" link | awk -F': ' '/SSID/ {print $2}')
signal=$(iw dev "$interface" link | awk '/signal:/ {print $2}')

# If not connected
if [ -z "$ssid" ]; then
    echo "❌  Disconnected"
    echo "❌" 
    echo "#FF0000"       # red
else
    echo "📶  $ssid (${signal}dBm)"
    echo "📶"              # you could also do something like "($signal dBm)" here
    echo "#AAFF00"       # green
fi
