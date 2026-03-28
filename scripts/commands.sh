#!/usr/bin/env bash
# Command center — launched via Walker dmenu mode (Super+Alt+Space)
# Order of entries matches display order.

entries=(
    "Add Web App"
    "Remove Web App"
    "Add Terminal App"
    "Remove Terminal App"
    "Toggle App Visibility"
    "Add VPN"
    "Connect VPN"
    "Remove VPN"
    "Install or Remove Package"
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
    ["Add Terminal App"]="kitty --title add-termapp $HOME/dotfiles/scripts/add-termapp.sh"
    ["Remove Terminal App"]="$HOME/dotfiles/scripts/remove-termapp.sh"
    ["Toggle App Visibility"]="$HOME/dotfiles/scripts/toggle-app.sh"
    ["Add VPN"]="kitty --title add-vpn $HOME/dotfiles/scripts/add-vpn.sh"
    ["Connect VPN"]="$HOME/dotfiles/scripts/vpn-connect.sh"
    ["Remove VPN"]="$HOME/dotfiles/scripts/remove-vpn.sh"
    ["Install or Remove Package"]="kitty --title pacsea pacsea"
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
