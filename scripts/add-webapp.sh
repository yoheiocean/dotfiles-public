#!/usr/bin/env bash
# Add a web app — creates a .desktop file that opens Brave in app mode.
# Launched from the command center (Walker).

set -euo pipefail

ICONS_DIR="$HOME/.local/share/icons/webapps"
APPS_DIR="$HOME/.local/share/applications"
mkdir -p "$ICONS_DIR" "$APPS_DIR"

read -rp "Name: " name
[[ -z "$name" ]] && exit 1

read -rp "URL: " url
[[ -z "$url" ]] && exit 1

read -rp "Icon URL (png): " icon_url
[[ -z "$icon_url" ]] && exit 1

slug=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-' | sed 's/-$//')

# Download icon
icon_path="$ICONS_DIR/$slug.png"
echo "Downloading icon..."
if ! curl -sL "$icon_url" -o "$icon_path"; then
    echo "Failed to download icon."
    read -rp "Press Enter to close..."
    exit 1
fi

# Create .desktop file
desktop_file="$APPS_DIR/webapp-$slug.desktop"
cat > "$desktop_file" <<EOF
[Desktop Entry]
Name=$name
Exec=brave --app=$url
Icon=$icon_path
Type=Application
Categories=WebApp;
EOF

# Update desktop database and restart Elephant so Walker picks it up
update-desktop-database "$APPS_DIR" 2>/dev/null || true
systemctl --user restart elephant 2>/dev/null || true

echo "Web app '$name' added."
read -rp "Press Enter to close..."
