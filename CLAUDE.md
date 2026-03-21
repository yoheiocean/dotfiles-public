# Dotfiles — Arch Linux / Hyprland

## Overview

System configuration for Arch Linux on a ThinkPad T480 (Intel UHD 620).
Minimal Hyprland desktop, built incrementally.

## Principles

- **Incremental** — add one thing at a time, verify it works, then move on
- **Reproducible** — `packages.sh` lists every explicitly installed package; `setup.sh` symlinks configs and bootstraps a fresh machine
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
├── hypr/
│   └── hyprland.conf   # Hyprland compositor config
└── kitty/
    └── kitty.conf      # kitty terminal config
```

New directories are added as new tools are configured (waybar/, wofi/, etc.).

## Symlink Mapping

| Source (~/dotfiles/...)      | Target                              |
|------------------------------|-------------------------------------|
| `bash/.bash_profile`        | `~/.bash_profile`                   |
| `bash/.bashrc`              | `~/.bashrc`                         |
| `hypr/`                     | `~/.config/hypr/`                   |
| `kitty/`                    | `~/.config/kitty/`                  |

## Current Goal

Hyprland desktop is functional — launched via uwsm, kitty as terminal, basic keybinds, volume/brightness/media keys working.
Next up: app launcher (wofi), then bar and wallpaper.

## Hardware

- ThinkPad T480
- GPU: Intel UHD 620 (uses `intel_backlight`, no proprietary drivers needed)

## Commands

- `bash packages.sh` — install all packages
- `bash setup.sh` — symlink configs and bootstrap
