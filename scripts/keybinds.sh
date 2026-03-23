#!/usr/bin/env bash
# Keybinds cheat sheet — parses hyprland.conf and displays in Walker dmenu.

set -euo pipefail

CONF="$HOME/dotfiles/hypr/hyprland.conf"

# Parse bind lines: extract comment (section header) + keybind + action
awk '
    /^# / { section = substr($0, 3) }
    /^bind/ {
        # Extract everything after the = sign
        match($0, /= *(.*)/, m)
        line = m[1]

        # Split by comma
        n = split(line, parts, ", *")

        # First part is modifiers, second is key
        mods = parts[1]
        key = parts[2]

        # Build action from remaining parts
        action = ""
        for (i = 3; i <= n; i++) {
            if (i > 3) action = action ", "
            action = action parts[i]
        }

        # Format modifier names
        gsub(/SUPER/, "Super", mods)
        gsub(/SHIFT/, "Shift", mods)
        gsub(/ALT/, "Alt", mods)
        gsub(/ /, "+", mods)

        # Build display string
        if (action == "")
            printf "[%s] %s+%s\n", section, mods, key
        else
            printf "[%s] %s+%s → %s\n", section, mods, key, action
    }
' "$CONF" | walker --dmenu --hideqa > /dev/null 2>&1 || true
