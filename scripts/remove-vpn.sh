#!/usr/bin/env bash
# Remove a WireGuard VPN config via Walker dmenu.

set -euo pipefail

# List available configs
configs=()
for f in /etc/wireguard/*.conf; do
    [[ -f "$f" ]] || continue
    configs+=("$(basename "$f" .conf)")
done

if [[ ${#configs[@]} -eq 0 ]]; then
    notify-send "VPN" "No WireGuard configs found."
    exit 0
fi

choice=$(printf '%s\n' "${configs[@]}" | walker --dmenu --hideqa)
[[ -z "$choice" ]] && exit 0

# Disconnect if active
active=$(ip -o link show type wireguard 2>/dev/null | awk -F': ' '{print $2}' | head -1)
[[ "$active" == "$choice" ]] && sudo wg-quick down "$choice" 2>/dev/null

sudo ~/dotfiles/scripts/wireguard-helper.sh remove "$choice"

notify-send "VPN" "Removed '$choice'"
pkill -SIGRTMIN+1 waybar 2>/dev/null || true
