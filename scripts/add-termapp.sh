#!/usr/bin/env bash
# Add a terminal app — creates a .desktop file that opens kitty with a command.
# Launched from the command center (Walker).

set -euo pipefail

ICONS_DIR="$HOME/.local/share/icons/termapps"
APPS_DIR="$HOME/.local/share/applications"
mkdir -p "$ICONS_DIR" "$APPS_DIR"

read -rp "Name: " name
[[ -z "$name" ]] && exit 1

read -rp "Command: " cmd
[[ -z "$cmd" ]] && exit 1

read -rp "Icon (URL or local path): " icon_src
[[ -z "$icon_src" ]] && exit 1

slug=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-' | sed 's/-$//')

# Get icon — copy local file or download URL
icon_path="$ICONS_DIR/$slug.png"
if [[ -f "$icon_src" ]]; then
    cp "$icon_src" "$icon_path"
else
    echo "Downloading icon..."
    if ! curl -sL "$icon_src" -o "$icon_path"; then
        echo "Failed to download icon."
        read -rp "Press Enter to close..."
        exit 1
    fi
fi

# Create .desktop file
desktop_file="$APPS_DIR/termapp-$slug.desktop"
cat > "$desktop_file" <<EOF
[Desktop Entry]
Name=$name
Exec=kitty --title $slug -e $cmd
Icon=$icon_path
Type=Application
Categories=TermApp;
EOF

# Update desktop database and restart Elephant so Walker picks it up
update-desktop-database "$APPS_DIR" 2>/dev/null || true
systemctl --user restart elephant 2>/dev/null || true

echo "Terminal app '$name' added."
read -rp "Press Enter to close..."
