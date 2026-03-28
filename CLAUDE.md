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
├── calcure/
│   ├── config.ini    # calcure calendar config (birthdays_from_abook=No)
│   ├── events.csv    # calcure events data
│   └── tasks.csv     # calcure tasks data
├── drift/
│   └── config.toml   # drift screensaver config (scenes, themes)
├── awtwall/
│   └── state.conf     # awtwall wallpaper picker config (dir, backend, transitions)
├── pacsea/
│   ├── settings.conf  # pacsea settings (passwordless sudo enabled)
│   ├── theme.conf     # custom Popping and Locking theme
│   └── keybinds.conf  # pacsea keybinds
├── fcitx5/
│   ├── README.md     # detailed docs on dbus race condition and tray icon fix
│   ├── config        # fcitx5 hotkey config
│   ├── profile       # fcitx5 input method profile (keyboard-us + mozc)
│   └── conf/
│       └── notificationitem.conf  # disable tray icon addon (belt-and-suspenders, unreliable alone)
├── hypr/
│   ├── hyprland.conf     # Hyprland compositor config
│   └── hypridle.conf     # idle daemon config (triggers TTE screensaver)
├── iwd/
│   └── main.conf       # iwd wireless daemon config
├── kitty/
│   ├── kitty.conf           # kitty terminal config
│   └── current-theme.conf   # kitty color theme (Popping and Locking)
├── mako/
│   └── config          # notification daemon config
├── nvim/
│   └── init.lua        # neovim config (lazy.nvim + gruvbox-material)
├── scripts/
│   ├── add-termapp.sh      # add a terminal app (.desktop file with kitty -e)
│   ├── add-webapp.sh       # add a web app (.desktop file with Brave --app)
│   ├── commands.sh         # command center (Walker dmenu, Super+Alt+Space)
│   ├── cycle-wallpaper.sh  # cycle through wallpapers in ~/wallpapers
│   ├── drift-wrapper.sh    # drift launcher with random theme selection
│   ├── keybinds.sh           # keybinds cheat sheet (parsed from hyprland.conf)
│   ├── remove-termapp.sh    # remove a terminal app via Walker dmenu
│   ├── remove-vpn.sh        # remove a WireGuard VPN config via Walker dmenu
│   ├── remove-webapp.sh     # remove a web app via Walker dmenu
│   ├── screensaver.txt      # ASCII art for TTE screensaver
│   ├── tte-screensaver.sh   # TTE screensaver loop script
│   ├── volume-status.sh     # volume JSON output for waybar custom module
│   ├── vpn-connect.sh       # connect to a VPN via Walker dmenu
│   ├── vpn-status.sh        # VPN status JSON output for waybar
│   ├── vpn-toggle.sh        # toggle active VPN on/off (waybar on-click)
│   ├── wireguard-helper.sh  # sudo helper for wireguard config file operations
│   ├── add-vpn.sh           # add a WireGuard VPN config
│   ├── ime-status.sh        # IME status JSON output for waybar (EN/あ)
│   ├── toggle-app.sh        # toggle app visibility in Walker (NoDisplay override)
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
| `awtwall/`                  | `~/.config/awtwall/` (copied, not symlinked — awtwall writes runtime state) |
| `btop/`                     | `~/.config/btop/`                   |
| `calcure/`                  | `~/.config/calcure/`                |
| `drift/`                    | `~/.config/drift/`                  |
| `fcitx5/`                   | `~/.config/fcitx5/` (copied, not symlinked — fcitx5 overwrites its config at runtime) |
| `hypr/`                     | `~/.config/hypr/`                   |
| `iwd/main.conf`             | `/etc/iwd/main.conf` (copied, not symlinked — iwd ignores symlinks) |
| `kitty/`                    | `~/.config/kitty/`                  |
| `mako/`                     | `~/.config/mako/`                   |
| `nvim/`                     | `~/.config/nvim/`                   |
| `pacsea/`                   | `~/.config/pacsea/` (copied, not symlinked — pacsea writes runtime data) |
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
Terminal apps support — add/remove terminal apps that open in kitty and appear in Walker.
App visibility toggle — hide/show any app in Walker via NoDisplay desktop overrides.
WireGuard VPN — add/connect/remove configs via command center, waybar toggle, scoped sudoers.
Japanese input — fcitx5 + Mozc, Super+grave toggle, waybar EN/あ indicator, CJK fonts installed.
Neovim configured with lazy.nvim + gruvbox-material theme, transparent background, sane defaults.
Wiremix TUI audio mixer — opens in floating window from waybar volume icon click.
Pacsea package search TUI — install/remove pacman+AUR packages from command center in floating window.
Awtwall wallpaper picker TUI — browse and set wallpapers (Super+P), cycle next (Super+Shift+P).

## Future TODO

- **OSD notifications for hardware keys** — visual/audio feedback when pressing volume, brightness, and media keys (e.g. an on-screen display showing current level)
- **Global copy/paste/select-all keybinds** — consider Super+C/V/A mapping for GUI apps once they're in use
- **Japanese input — locale config** — LANG/LC_* variables not yet set in bash config
- **Neovim — LSP setup** — language servers for bash, python, lua, etc.

## Hardware

- ThinkPad T480
- GPU: Intel UHD 620 (uses `intel_backlight`, no proprietary drivers needed)

## Adding a New Feature — Checklist

When adding any new tool or feature, walk through every item before committing:

1. **packages.sh** — Is the package listed (pacman or AUR section)?
2. **Config files** — Are all config files tracked in `~/dotfiles/<app>/`? (Not just sitting in `~/.config/` untracked)
3. **setup.sh — symlinks** — Is the config dir added to the `CONFIGS` array (or `HOME_FILES` if it goes in `~/`)?
4. **setup.sh — bootstrap** — Does the tool need `systemctl enable`, `go install`, sudoers rules, or other post-install steps? Add them.
5. **bash/.bashrc** — Does it need PATH entries, aliases, shell init, or env vars? Guard against missing binaries.
6. **hyprland.conf** — Does it need keybinds, env vars, `exec-once` autostart, or window rules?
7. **waybar** — Does it need a status module or on-click handler?
8. **scripts/** — Are helper scripts referenced correctly and executable?
9. **CLAUDE.md** — Update repo structure tree, symlink mapping table, and current goal.

The test: *"If I ran `packages.sh` + `setup.sh` on a blank Arch install, would this feature work with zero manual steps?"*

## Commands

- `bash packages.sh` — install all packages
- `bash setup.sh` — symlink configs and bootstrap
