#!/usr/bin/env bash
# Wrapper around drift that picks a random theme each launch.
THEMES=(cosmic nord dracula catppuccin gruvbox forest wildberries mono rosepine)
THEME=${THEMES[$((RANDOM % ${#THEMES[@]}))]}
exec "$(go env GOPATH)/bin/drift" --theme "$THEME" "$@"
