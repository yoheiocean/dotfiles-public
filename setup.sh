#!/usr/bin/env bash
# Bootstrap a fresh machine: create symlinks from ~/.config to ~/dotfiles.
# Run: bash setup.sh

set -euo pipefail

DOTFILES="$HOME/dotfiles"

# Directories to symlink into ~/.config/
CONFIGS=(
    hypr
    kitty
    mako
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

echo "Done."
