#!/usr/bin/env bash
# Remove a web app — deletes its .desktop file and icon.
# Launched from the command center (Walker).

set -euo pipefail

ICONS_DIR="$HOME/.local/share/icons/webapps"
APPS_DIR="$HOME/.local/share/applications"

# Find all webapp desktop files and extract names
webapps=()
while IFS= read -r file; do
    name=$(grep -oP '^Name=\K.*' "$file")
    [[ -n "$name" ]] && webapps+=("$name")
done < <(find "$APPS_DIR" -name 'webapp-*.desktop' 2>/dev/null | sort)

if [[ ${#webapps[@]} -eq 0 ]]; then
    echo "No web apps found."
    read -rp "Press Enter to close..."
    exit 0
fi

# Show list in Walker dmenu
choice=$(printf '%s\n' "${webapps[@]}" | walker --dmenu --hideqa)
[[ -z "$choice" ]] && exit 0

# Find and delete matching desktop file and icon
for file in "$APPS_DIR"/webapp-*.desktop; do
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
