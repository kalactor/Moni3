#!/bin/bash

INTERFACE="wlp2s0"  # Change this to your network interface (e.g., enp3s0, wlan0, etc.)

RX_OLD_FILE="/tmp/i3blocks_net_rx_old"
TX_OLD_FILE="/tmp/i3blocks_net_tx_old"

# Get current RX and TX bytes
RX_NOW=$(cat /proc/net/dev | awk "/${INTERFACE}/ {print \$2}")
TX_NOW=$(cat /proc/net/dev | awk "/${INTERFACE}/ {print \$10}")

# Read previous values
RX_OLD=$(cat "$RX_OLD_FILE" 2>/dev/null || echo "$RX_NOW")
TX_OLD=$(cat "$TX_OLD_FILE" 2>/dev/null || echo "$TX_NOW")

# Save current values for next run
echo "$RX_NOW" > "$RX_OLD_FILE"
echo "$TX_NOW" > "$TX_OLD_FILE"

# Calculate speed in bytes/sec
RX_DIFF=$((RX_NOW - RX_OLD))
TX_DIFF=$((TX_NOW - TX_OLD))

# Convert to human-readable format (KB/s or MB/s)
human() {
    local BYTES=$1
    if [ "$BYTES" -ge 1048576 ]; then
        printf "%.1f MB/s" "$(echo "$BYTES / 1048576" | bc -l)"
    else
        printf "%.0f KB/s" "$(echo "$BYTES / 1024" | bc -l)"
    fi
}

echo "↓ $(human $RX_DIFF) ↑ $(human $TX_DIFF)"

