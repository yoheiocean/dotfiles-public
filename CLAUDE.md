# Dotfiles — Arch Linux / Hyprland

## Overview

System configuration for Arch Linux on a ThinkPad T480 (Intel UHD 620).
Minimal Hyprland desktop, built incrementally.

## Principles

- **Incremental** — add one thing at a time, verify it works, then move on
- **Reproducible** — `packages.sh` lists every explicitly installed package; `setup.sh` symlinks configs and bootstraps a fresh machine. When a new package requires a `systemctl enable` or other system-level setup, add it to `setup.sh` so a fresh machine is fully configured in one run.
- **Symlinked** — all config files live here in `~/dotfiles` and are symlinked to their proper locations (e.g. `~/.config/hypr/hyprland.conf` → `~/dotfiles/hypr/hyprland.conf`)
- **Minimal** — no bloat, no unused configs, no "just in case" packages

## Repo Structure

```
~/dotfiles/
├── CLAUDE.md           # this file
├── packages.sh         # installs all tracked packages (pacman + AUR)
├── setup.sh            # creates symlinks, runs bootstrap tasks
├── bash/
│   ├── .bash_profile   # shell profile (auto-starts Hyprland on TTY1)
│   └── .bashrc         # interactive shell config (aliases, PATH)
├── btop/
│   ├── btop.conf                      # btop config
│   └── themes/
│       └── popping-and-locking.theme  # custom theme matching kitty colors
├── hypr/
│   └── hyprland.conf   # Hyprland compositor config
├── iwd/
│   └── main.conf       # iwd wireless daemon config
├── kitty/
│   ├── kitty.conf           # kitty terminal config
│   └── current-theme.conf   # kitty color theme (Popping and Locking)
├── mako/
│   └── config          # notification daemon config
├── hypridle/
│   └── hypridle.conf     # idle daemon config (triggers TTE screensaver)
├── scripts/
│   ├── add-webapp.sh       # add a web app (.desktop file with Brave --app)
│   ├── commands.sh         # command center (Walker dmenu, Super+Alt+Space)
│   ├── cycle-wallpaper.sh  # cycle through wallpapers in ~/wallpapers
│   ├── drift-wrapper.sh    # drift launcher with random theme selection
│   ├── keybinds.sh         # keybinds cheat sheet (parsed from hyprland.conf)
│   ├── remove-webapp.sh    # remove a web app via Walker dmenu
│   ├── screensaver.txt     # ASCII art for TTE screensaver
│   ├── tte-screensaver.sh  # TTE screensaver loop script
│   └── volume-status.sh    # volume JSON output for waybar custom module
├── starship/
│   └── starship.toml   # starship prompt config (custom warm dark palette)
├── walker/
│   ├── config.toml     # walker app launcher config
│   └── themes/
│       └── popping-and-locking/
│           └── style.css  # custom theme matching kitty/starship colors
└── waybar/
    ├── config.jsonc    # waybar modules (workspaces, clock, battery, volume, etc.)
    └── style.css       # waybar styling

## Symlink Mapping

| Source (~/dotfiles/...)      | Target                              |
|------------------------------|-------------------------------------|
| `bash/.bash_profile`        | `~/.bash_profile`                   |
| `bash/.bashrc`              | `~/.bashrc`                         |
| `btop/`                     | `~/.config/btop/`                   |
| `hypridle/`                 | `~/.config/hypridle/`               |
| `hypr/`                     | `~/.config/hypr/`                   |
| `iwd/main.conf`             | `/etc/iwd/main.conf` (copied, not symlinked — iwd ignores symlinks) |
| `kitty/`                    | `~/.config/kitty/`                  |
| `mako/`                     | `~/.config/mako/`                   |
| `starship/`                 | `~/.config/starship/`               |
| `scripts/`                  | `~/dotfiles/scripts/` (referenced in place, not symlinked) |
| `walker/`                   | `~/.config/walker/`                 |
| `waybar/`                   | `~/.config/waybar/`                 |

## Current Goal

Hyprland desktop is functional — launched via uwsm, kitty as terminal, Brave as default browser, basic keybinds, volume/brightness/media keys working.
Terminal styled with Starship prompt (custom palette) and kitty theme (Popping and Locking).
Walker app launcher configured with custom Popping and Locking theme (Super+Space).
Bluetooth enabled with bluetui TUI manager.
Waybar status bar configured with workspaces, clock, battery, volume, backlight, bluetooth, network, and system tray.
Window rules set up for floating TUI popups (fastfetch, tclock, btop, bluetui, impala).
Drift terminal screensaver with random theme cycling on shell idle (2 min).
TTE screensaver with centered ASCII art triggered by hypridle on system idle (5 min).
Command center (Super+Alt+Space) for system actions, web app management, keybinds cheat sheet.
Web apps support — add/remove web apps that open in Brave app mode and appear in Walker.

## Future TODO

- **OSD notifications for hardware keys** — visual/audio feedback when pressing volume, brightness, and media keys (e.g. an on-screen display showing current level)
- **GUI control center** — a visual settings panel for volume, brightness, network, etc.
- **Global copy/paste/select-all keybinds** — consider Super+C/V/A mapping for GUI apps once they're in use

## Hardware

- ThinkPad T480
- GPU: Intel UHD 620 (uses `intel_backlight`, no proprietary drivers needed)

## Commands

- `bash packages.sh` — install all packages
- `bash setup.sh` — symlink configs and bootstrap
