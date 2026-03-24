#!/usr/bin/env bash
# Remove a terminal app — deletes its .desktop file and icon.
# Launched from the command center (Walker).

set -euo pipefail

ICONS_DIR="$HOME/.local/share/icons/termapps"
APPS_DIR="$HOME/.local/share/applications"

# Find all termapp desktop files and extract names
termapps=()
while IFS= read -r file; do
    name=$(grep -oP '^Name=\K.*' "$file")
    [[ -n "$name" ]] && termapps+=("$name")
done < <(find "$APPS_DIR" -name 'termapp-*.desktop' 2>/dev/null | sort)

if [[ ${#termapps[@]} -eq 0 ]]; then
    echo "No terminal apps found."
    read -rp "Press Enter to close..."
    exit 0
fi

# Show list in Walker dmenu
choice=$(printf '%s\n' "${termapps[@]}" | walker --dmenu --hideqa)
[[ -z "$choice" ]] && exit 0

# Find and delete matching desktop file and icon
for file in "$APPS_DIR"/termapp-*.desktop; do
    name=$(grep -oP '^Name=\K.*' "$file")
    if [[ "$name" == "$choice" ]]; then
        icon=$(grep -oP '^Icon=\K.*' "$file")
        rm -f "$file"
        [[ -n "$icon" ]] && rm -f "$icon"
        update-desktop-database "$APPS_DIR" 2>/dev/null || true
        systemctl --user restart elephant 2>/dev/null || true
        echo "Removed '$choice'."
        break
    fi
done
