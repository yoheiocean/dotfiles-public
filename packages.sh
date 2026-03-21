#!/usr/bin/env bash
# Install all tracked packages for the Arch Linux / Hyprland setup.
# Run: bash packages.sh

set -euo pipefail

# --- Pacman packages ---
PACKAGES=(
    # Wayland / Hyprland
    hyprland
    xdg-desktop-portal-hyprland

    # Terminal
    kitty

    # GPU (Intel UHD 620)
    mesa
    intel-media-driver

    # Authentication agent
    polkit-gnome

    # File manager
    thunar

    # Notification daemon
    mako

    # Clipboard
    wl-clipboard

    # Editor
    neovim

    # Git / GitHub
    github-cli
)

echo "Installing pacman packages..."
sudo pacman -S --needed "${PACKAGES[@]}"
