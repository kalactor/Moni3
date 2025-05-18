#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# ─── CONFIG ───────────────────────────────────────────────────
PRINTER="HP_LaserJet_1020"
STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}"
JOB_FILE="$STATE_DIR/printer_${PRINTER}_job"
# Icons (use a Nerd Font or Font Awesome in your bar)
ICON_IDLE=""         # printer icon
ICON_PRINTING=""    # hourglass over printer, for example
# ──────────────────────────────────────────────────────────────

# 1) If lpstat not installed, or printer unknown → exit non-zero to hide block
if ! command -v lpstat &>/dev/null; then
    exit 1
fi
if ! lpstat -p "$PRINTER" &>/dev/null; then
    exit 1
fi

# 2) Figure out current job ID
jobid=$(lpstat -o "$PRINTER" 2>/dev/null \
        | head -n1 \
        | awk '{print $1}' \
        || echo "")

# Read and update last-seen job ID
last_job=$(<"$JOB_FILE" 2>/dev/null || echo "")
echo -n "$jobid" > "$JOB_FILE"

# (Optional) Notifications
if [[ "${1:-}" == "--notify" ]]; then
    if [[ -n "$last_job" && "$jobid" != "$last_job" ]]; then
        notify-send "Print job $last_job completed"
    fi
    if [[ -n "$jobid" && "$jobid" != "$last_job" ]]; then
        notify-send "Print job $jobid started"
    fi
fi

# 3) Output for i3blocks
if [[ -z "$jobid" ]]; then
    echo "$ICON_IDLE  idle"
else
    count=$(lpstat -o "$PRINTER" 2>/dev/null | wc -l)
    echo "$ICON_PRINTING  printing ($count)"
fi

exit 0
