#!/usr/bin/env bash
# Toggle VPN on/off. If on, disconnect. If off, connect last used config.

set -euo pipefail

LAST_FILE="/tmp/vpn-last"

active=$(ip -o link show type wireguard 2>/dev/null | awk -F': ' '{print $2}' | head -1)

if [[ -n "$active" ]]; then
    # VPN is on — turn off
    echo "$active" > "$LAST_FILE"
    sudo wg-quick down "$active" 2>/dev/null
    rm -f /tmp/vpn-connecting
else
    # VPN is off — reconnect last used config
    if [[ -f "$LAST_FILE" ]]; then
        config=$(cat "$LAST_FILE")
        echo "connecting" > /tmp/vpn-connecting
        pkill -SIGRTMIN+1 waybar 2>/dev/null || true
        sudo wg-quick up "$config" 2>/dev/null
        rm -f /tmp/vpn-connecting
    fi
fi

pkill -SIGRTMIN+1 waybar 2>/dev/null || true
