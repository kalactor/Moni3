#!/usr/bin/env bash

set -euo pipefail

# ── fetch updates once, quietly ────────────────────────────────────────────────
mapfile -t updates < <(checkupdates 2>/dev/null)
n=${#updates[@]}

# ── handle mouse clicks ─────────────────────────────────────────────────────────
if [[ -n "${BLOCK_BUTTON:-}" ]]; then
    case "$BLOCK_BUTTON" in
        1)
            alacritty -e bash -c "sudo pacman -Syu; echo; read -p 'Press ENTER to close...'" 
            ;;
        3)
            notify-send "Available updates ($n)" "$(printf '%s\n' "${updates[@]}")"
            ;;
    esac
    exit 0
fi

# ── output for i3blocks ────────────────────────────────────────────────────────
if (( n > 0 )); then
    echo "  $n"
    echo ""
    echo "#00FF00"
fi
