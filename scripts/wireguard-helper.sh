#!/usr/bin/env bash
# Helper for wireguard config management — runs via sudo.
# Usage:
#   sudo wireguard-helper.sh add <name> <source-path>
#   sudo wireguard-helper.sh remove <name>

set -euo pipefail

WG_DIR="/etc/wireguard"

case "${1:-}" in
    add)
        [[ -z "${2:-}" || -z "${3:-}" ]] && { echo "Usage: $0 add <name> <source>"; exit 1; }
        cp "$3" "$WG_DIR/$2.conf"
        chmod 600 "$WG_DIR/$2.conf"
        ;;
    remove)
        [[ -z "${2:-}" ]] && { echo "Usage: $0 remove <name>"; exit 1; }
        rm -f "$WG_DIR/$2.conf"
        ;;
    *)
        echo "Usage: $0 {add|remove} ..."
        exit 1
        ;;
esac
