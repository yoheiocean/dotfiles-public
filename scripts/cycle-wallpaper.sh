#!/usr/bin/env bash
# Cycle through wallpapers in ~/wallpapers/ alphabetically.
# Tracks current wallpaper via swww query.

WALLPAPER_DIR="$HOME/wallpapers"
IMAGES=($(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' -o -iname '*.webp' \) | sort))

[[ ${#IMAGES[@]} -eq 0 ]] && exit 1

# Get current wallpaper from swww
CURRENT=$(swww query | grep -oP 'image: \K.*' | head -1)

# Find next image
NEXT="${IMAGES[0]}"
for i in "${!IMAGES[@]}"; do
    if [[ "${IMAGES[$i]}" == "$CURRENT" ]]; then
        NEXT="${IMAGES[$(( (i + 1) % ${#IMAGES[@]} ))]}"
        break
    fi
done

swww img "$NEXT" --transition-type fade --transition-duration 1
