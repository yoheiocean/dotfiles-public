#!/usr/bin/env bash
# Add a WireGuard VPN config — copies a .conf file to /etc/wireguard/.

set -euo pipefail

read -rp "Name (e.g. work, home): " name
[[ -z "$name" ]] && exit 1

read -rp "Config file path: " config_path
[[ -z "$config_path" ]] && exit 1

# Expand tilde
config_path="${config_path/#\~/$HOME}"

if [[ ! -f "$config_path" ]]; then
    echo "File not found: $config_path"
    read -rp "Press Enter to close..."
    exit 1
fi

sudo ~/dotfiles/scripts/wireguard-helper.sh add "$name" "$config_path"

echo "VPN '$name' added."
read -rp "Press Enter to close..."
