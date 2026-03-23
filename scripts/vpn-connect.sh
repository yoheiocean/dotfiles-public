#!/usr/bin/env bash
# Connect to a VPN — shows available WireGuard configs in Walker dmenu.

set -euo pipefail

LAST_FILE="/tmp/vpn-last"

# List available configs
configs=()
for f in /etc/wireguard/*.conf; do
    [[ -f "$f" ]] || continue
    configs+=("$(basename "$f" .conf)")
done

if [[ ${#configs[@]} -eq 0 ]]; then
    notify-send "VPN" "No WireGuard configs found in /etc/wireguard/"
    exit 0
fi

choice=$(printf '%s\n' "${configs[@]}" | walker --dmenu --hideqa)
[[ -z "$choice" ]] && exit 0

# Disconnect any active VPN first
active=$(ip -o link show type wireguard 2>/dev/null | awk -F': ' '{print $2}' | head -1)
[[ -n "$active" ]] && sudo wg-quick down "$active" 2>/dev/null

# Connect
echo "connecting" > /tmp/vpn-connecting
pkill -SIGRTMIN+1 waybar 2>/dev/null || true

sudo wg-quick up "$choice" 2>/dev/null
echo "$choice" > "$LAST_FILE"
rm -f /tmp/vpn-connecting

pkill -SIGRTMIN+1 waybar 2>/dev/null || true
