#!/usr/bin/env bash
# Command center — launched via Walker dmenu mode (Super+Alt+Space)
# Order of entries matches display order.

entries=(
    "Add Web App"
    "Remove Web App"
    "Add VPN"
    "Connect VPN"
    "Remove VPN"
    "Keybinds"
    "Bluetooth"
    "Network"
    "Screensaver"
    "Sleep"
    "Restart"
    "Shutdown"
)

declare -A commands=(
    ["Add Web App"]="kitty --title add-webapp $HOME/dotfiles/scripts/add-webapp.sh"
    ["Remove Web App"]="$HOME/dotfiles/scripts/remove-webapp.sh"
    ["Add VPN"]="kitty --title add-vpn $HOME/dotfiles/scripts/add-vpn.sh"
    ["Connect VPN"]="$HOME/dotfiles/scripts/vpn-connect.sh"
    ["Remove VPN"]="$HOME/dotfiles/scripts/remove-vpn.sh"
    ["Keybinds"]="$HOME/dotfiles/scripts/keybinds.sh"
    ["Bluetooth"]="kitty --title bluetui bluetui"
    ["Network"]="kitty --title impala impala"
    ["Screensaver"]="kitty --title tte-screensaver $HOME/dotfiles/scripts/tte-screensaver.sh"
    ["Sleep"]="systemctl suspend"
    ["Restart"]="systemctl reboot"
    ["Shutdown"]="systemctl poweroff"
)

choice=$(printf '%s\n' "${entries[@]}" | walker --dmenu --hideqa)

[[ -n "$choice" && -n "${commands[$choice]}" ]] && exec ${commands[$choice]}
