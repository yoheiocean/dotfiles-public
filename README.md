# Dotfiles — Arch Linux / Hyprland

Minimal Hyprland desktop on Arch Linux. Configs are symlinked from this repo to their expected locations.

## What's included

- **Hyprland** — tiling Wayland compositor, launched via uwsm
- **Kitty** — terminal (Popping and Locking theme, JetBrains Mono Nerd Font)
- **Starship** — shell prompt (custom warm dark palette)
- **Walker** — app launcher (Super+Space)
- **Waybar** — status bar (workspaces, clock, battery, volume, VPN, IME, etc.)
- **Mako** — notification daemon
- **Neovim** — editor (lazy.nvim + gruvbox-material)
- **iwd** — wireless networking (replaces NetworkManager)
- **WireGuard** — VPN management via command center
- **fcitx5 + Mozc** — Japanese input
- **Brave** — default browser, with web app support

## Prerequisites

A working Arch Linux install with:

- A user in the `wheel` group with `sudo` access
- `git` installed (`sudo pacman -S git`)
- Internet connection (NetworkManager is fine — the setup script handles the switch)

## Install

### 1. Clone

```bash
cd ~
git clone <repo-url> dotfiles
cd dotfiles
```

### 2. Install packages

```bash
bash packages.sh
```

Installs all pacman packages, builds `yay` (AUR helper) if needed, then installs AUR packages. This will take a while on a fresh system.

### 3. Run setup

```bash
bash setup.sh
```

This script:

1. Symlinks all config directories into `~/.config/` and shell files into `~/`
2. Copies the iwd config to `/etc/iwd/`
3. **Disables NetworkManager** and enables iwd + systemd-resolved (required for impala, the network TUI)
4. **Prompts for WiFi SSID and password** — the script pauses here and won't continue until a connection is verified via ping
5. Enables bluetooth
6. Enables elephant (Walker's data provider)
7. Configures passwordless sudo for WireGuard commands
8. Sets up XDG user directories
9. Sets Brave as the default browser

### 4. Reboot and log in

```bash
sudo reboot
```

Log in on TTY1. Hyprland starts automatically via `.bash_profile`.

## Post-setup

- Add wallpapers to `~/wallpapers/` (cycle with the wallpaper keybind)
- Add WireGuard VPN configs via the command center (Super+Alt+Space)
- Add web apps or terminal apps via the command center

## Key bindings

Once in Hyprland, open the keybinds cheat sheet from the command center (Super+Alt+Space → Keybinds).

## Structure

```
bash/           shell config (.bashrc, .bash_profile)
btop/           system monitor config + theme
hypr/           hyprland + hypridle config
iwd/            wireless daemon config
kitty/          terminal config + theme
mako/           notification daemon config
nvim/           neovim config (lazy.nvim)
scripts/        helper scripts (wallpaper, VPN, apps, screensaver, etc.)
starship/       prompt config
walker/         app launcher config + theme
waybar/         status bar config + styling
packages.sh     install all packages
setup.sh        symlink configs + bootstrap services
```
