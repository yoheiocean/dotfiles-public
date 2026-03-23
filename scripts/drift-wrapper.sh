#!/usr/bin/env bash
# Wrapper around drift that picks a random theme each launch.
THEMES=(cosmic nord dracula catppuccin gruvbox forest wildberries mono rosepine)
THEME=${THEMES[$((RANDOM % ${#THEMES[@]}))]}
CONFIG="$HOME/.config/drift/config.toml"
sed -i "s/^theme.*=.*/theme         = \"$THEME\"/" "$CONFIG"
exec "$(go env GOPATH)/bin/drift" "$@"
