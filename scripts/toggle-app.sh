#!/usr/bin/env bash
# Toggle app visibility in the app launcher.
# Creates/removes NoDisplay=true overrides in ~/.local/share/applications.
# Launched from the command center (Walker).

set -euo pipefail

USER_APPS="$HOME/.local/share/applications"
SYSTEM_APPS="/usr/share/applications"
mkdir -p "$USER_APPS"

# Build list of apps with visibility status
declare -A app_files
entries=()

# Collect all desktop files (user overrides take priority)
for file in "$SYSTEM_APPS"/*.desktop "$USER_APPS"/*.desktop; do
    [[ -f "$file" ]] || continue
    basename=$(basename "$file")
    app_files["$basename"]="$file"
done

# Build display list
for basename in $(printf '%s\n' "${!app_files[@]}" | sort); do
    file="${app_files[$basename]}"
    name=$(grep -oP '^Name=\K.*' "$file" | head -1)
    [[ -z "$name" ]] && continue

    # Check if hidden
    if grep -qP '^NoDisplay=true' "$file" 2>/dev/null; then
        entries+=("[hidden]  $name")
    else
        entries+=("[visible] $name")
    fi
done

if [[ ${#entries[@]} -eq 0 ]]; then
    echo "No apps found."
    exit 0
fi

choice=$(printf '%s\n' "${entries[@]}" | walker --dmenu --hideqa)
[[ -z "$choice" ]] && exit 0

# Extract name and current state
is_hidden=false
if [[ "$choice" == \[hidden\]* ]]; then
    is_hidden=true
    app_name="${choice#\[hidden\] }"
else
    app_name="${choice#\[visible\] }"
fi
# Trim leading whitespace
app_name="${app_name#"${app_name%%[![:space:]]*}"}"

# Find the matching basename
target_basename=""
for basename in "${!app_files[@]}"; do
    file="${app_files[$basename]}"
    name=$(grep -oP '^Name=\K.*' "$file" | head -1)
    if [[ "$name" == "$app_name" ]]; then
        target_basename="$basename"
        break
    fi
done

[[ -z "$target_basename" ]] && exit 1

user_file="$USER_APPS/$target_basename"
system_file="$SYSTEM_APPS/$target_basename"

if $is_hidden; then
    # Unhide — if user override exists just for hiding, remove it; otherwise remove NoDisplay
    if [[ -f "$user_file" && -f "$system_file" ]]; then
        # Check if the override only adds NoDisplay (i.e., it's a hide-only override we created)
        if grep -q '^# hide-override$' "$user_file" 2>/dev/null; then
            rm -f "$user_file"
        else
            sed -i '/^NoDisplay=true$/d' "$user_file"
        fi
    elif [[ -f "$user_file" ]]; then
        sed -i '/^NoDisplay=true$/d' "$user_file"
    fi
else
    # Hide — create or modify user override
    if [[ -f "$user_file" ]]; then
        # User file exists, add NoDisplay if not present
        if ! grep -q '^NoDisplay=' "$user_file"; then
            echo "NoDisplay=true" >> "$user_file"
        else
            sed -i 's/^NoDisplay=.*/NoDisplay=true/' "$user_file"
        fi
    else
        # Create a minimal override
        cat > "$user_file" <<EOF
# hide-override
[Desktop Entry]
Name=$app_name
NoDisplay=true
Type=Application
EOF
    fi
fi

update-desktop-database "$USER_APPS" 2>/dev/null || true
systemctl --user restart elephant 2>/dev/null || true

if $is_hidden; then
    notify-send "App Visibility" "'$app_name' is now visible"
else
    notify-send "App Visibility" "'$app_name' is now hidden"
fi
