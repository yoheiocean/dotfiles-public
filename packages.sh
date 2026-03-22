#!/usr/bin/env bash
# Install all tracked packages for the Arch Linux / Hyprland setup.
# Run: bash packages.sh

set -euo pipefail

# --- Pacman packages ---
PACKAGES=(
    # Wayland / Hyprland
    hyprland
    xdg-desktop-portal-hyprland
    uwsm

    # Terminal
    kitty

    # GPU (Intel UHD 620)
    mesa
    intel-media-driver

    # Authentication agent
    polkit-gnome

    # File manager
    yazi

    # Notification daemon
    mako

    # Clipboard
    wl-clipboard

    # Editor
    neovim

    # Networking
    iwd

    # Wallpaper
    swww

    # Utilities
    jq
    htop
    btop
    fzf
    ripgrep
    bat
    eza
    zoxide

    # Git / GitHub
    github-cli
)

echo "Installing pacman packages..."
sudo pacman -S --needed "${PACKAGES[@]}"

# --- yay (AUR helper) ---
if ! command -v yay &>/dev/null; then
    echo "Installing yay..."
    sudo pacman -S --needed git base-devel
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    (cd "$tmpdir/yay" && makepkg -si --noconfirm)
    rm -rf "$tmpdir"
fi

# --- AUR packages ---
AUR_PACKAGES=(
    # Network TUI
    impala
)

echo "Installing AUR packages..."
yay -S --needed "${AUR_PACKAGES[@]}"
