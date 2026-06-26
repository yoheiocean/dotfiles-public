#!/usr/bin/env bash
# Install all tracked packages for the Arch Linux / Hyprland setup.
# Run: bash packages.sh

set -euo pipefail

# --- Pacman packages ---
PACKAGES=(
    # Wayland / Hyprland
    hyprland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    uwsm

    # Terminal
    kitty
    starship
    ttf-jetbrains-mono-nerd

    # GPU (Intel UHD 620)
    mesa
    intel-media-driver

    # Authentication agent
    polkit-gnome

    # File manager
    yazi
    thunar
    gvfs

    # Notification daemon
    mako

    # Brightness
    brightnessctl

    # Clipboard
    wl-clipboard

    # Editor
    code
    neovim

    # Networking
    iwd
    openssh

    # Bluetooth
    bluez
    bluez-utils
    bluetui

    # VPN
    wireguard-tools
    systemd-resolvconf

    # Idle daemon
    hypridle

    # Audio mixer
    wiremix

    # Status bar
    waybar

    # Screenshot
    grim
    slurp
    libnotify

    # Wallpaper
    swww

    # Media
    ffmpeg
    cava

    # Audio routing (ALSA → PipeWire)
    pipewire-alsa

    # Utilities
    duf
    jq
    htop
    btop
    fzf
    ripgrep
    bat
    eza
    zoxide
    fastfetch
    less

    # Japanese fonts
    noto-fonts-cjk

    # Input method (Japanese)
    fcitx5
    fcitx5-mozc
    fcitx5-gtk
    fcitx5-qt
    fcitx5-configtool

    # Build tools
    rust
    go

    # XDG
    xdg-utils
    xdg-user-dirs

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

    # Terminal clock
    clock-tui

    # Terminal text effects (screensaver)
    python-terminaltexteffects

    # Browser
    brave-bin

    # Screenshot
    hyprshot

    # Calendar TUI
    calcure

    # Scientific calculator TUI
    kalker

    # Wallpaper picker TUI
    awtwall

    # Package search TUI
    pacsea-bin

    # GTK theme
    colloid-gruvbox-gtk-theme-git
    colloid-icon-theme-git

    # File sharing
    localsend-bin

    # Video conferencing
    zoom

    # App launcher
    walker
    elephant
    elephant-desktopapplications
    elephant-clipboard
    elephant-calc
    elephant-websearch
    elephant-runner
    elephant-files
)

echo "Installing AUR packages..."
yay -S --needed "${AUR_PACKAGES[@]}"
