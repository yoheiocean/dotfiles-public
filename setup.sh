#!/usr/bin/env bash
# Bootstrap a fresh machine: create symlinks from ~/.config to ~/dotfiles.
# Run: bash setup.sh

set -euo pipefail

DOTFILES="$HOME/dotfiles"

# Directories to symlink into ~/.config/
CONFIGS=(
    btop
    hypr
    kitty
    mako
    starship
)

# Files to symlink into ~/
HOME_FILES=(
    "bash/.bash_profile:.bash_profile"
    "bash/.bashrc:.bashrc"
)

echo "Creating symlinks..."

for entry in "${HOME_FILES[@]}"; do
    source="${DOTFILES}/${entry%%:*}"
    target="$HOME/${entry##*:}"

    if [ -L "$target" ]; then
        echo "  ${entry##*:}: symlink already exists, skipping"
    elif [ -e "$target" ]; then
        echo "  ${entry##*:}: WARNING — $target already exists and is not a symlink, skipping"
    else
        ln -s "$source" "$target"
        echo "  ${entry##*:}: linked"
    fi
done

for dir in "${CONFIGS[@]}"; do
    target="$HOME/.config/$dir"
    source="$DOTFILES/$dir"

    if [ -L "$target" ]; then
        echo "  $dir: symlink already exists, skipping"
    elif [ -e "$target" ]; then
        echo "  $dir: WARNING — $target already exists and is not a symlink, skipping"
    else
        mkdir -p "$(dirname "$target")"
        ln -s "$source" "$target"
        echo "  $dir: linked"
    fi
done

# System-level configs (require sudo)
echo ""
echo "Linking system-level configs..."

# iwd (copy, not symlink — iwd ignores symlinks to user-owned dirs)
sudo mkdir -p /etc/iwd
sudo cp "$DOTFILES/iwd/main.conf" /etc/iwd/main.conf
echo "  iwd: copied"

# Networking: iwd + systemd-resolved (no NetworkManager)
echo ""
echo "Configuring networking services..."
sudo systemctl disable --now NetworkManager 2>/dev/null || true
sudo systemctl disable --now wpa_supplicant 2>/dev/null || true
sudo systemctl enable iwd
sudo systemctl enable systemd-resolved

# Point resolv.conf to systemd-resolved (iwd delegates DNS to it)
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
echo "  networking: iwd + systemd-resolved enabled"

echo "Done."
