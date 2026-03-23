#!/usr/bin/env bash
# VPN status for waybar — outputs JSON with text, tooltip, and class.

STATE_FILE="/tmp/vpn-active"

# Check if any wg interface is up
active=$(ip -o link show type wireguard 2>/dev/null | awk -F': ' '{print $2}' | head -1)

if [[ -n "$active" ]]; then
    # Save active interface name for toggle
    echo "$active" > "$STATE_FILE"
    pub_ip=$(curl -s4 --max-time 2 ifconfig.me || echo "N/A")
    echo "{\"text\": \"󰒄 VPN\", \"tooltip\": \"Connected: $active\\nIP: $pub_ip\", \"class\": \"connected\"}"
elif [[ -f /tmp/vpn-connecting ]]; then
    echo "{\"text\": \"󰒄 VPN\", \"tooltip\": \"Connecting...\", \"class\": \"connecting\"}"
else
    rm -f "$STATE_FILE"
    echo "{\"text\": \"󱦚\", \"tooltip\": \"VPN disconnected\", \"class\": \"disconnected\"}"
fi
