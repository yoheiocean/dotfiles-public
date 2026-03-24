# Progress

## Done

- **Base Hyprland session** — hyprland, uwsm, kitty, mesa, intel-media-driver, xdg-desktop-portal-hyprland
- **Hyprland config** — monitor, input, gaps, borders, edge resize, keybinds (SUPER+Return terminal, SUPER+W close, SUPER+Q close all in workspace, SUPER+Space launcher, F11 fullscreen, SUPER+H/J/K/L and arrow keys focus, SUPER+/-/= resize, workspaces 1-5, floating, split toggle)
- **Authentication agent** — polkit-gnome (exec-once in hyprland.conf)
- **File manager** — yazi (terminal-based, opens in kitty via SUPER+E)
- **Notification daemon** — mako with blur layer rule
- **Clipboard** — wl-clipboard
- **Editor** — neovim (lazy.nvim + gruvbox-material theme, transparent background)
- **Auto-start Hyprland** — bash/.bash_profile launches Hyprland via uwsm on TTY1
- **Terminal styling** — Starship prompt (custom warm dark palette), kitty theme (Popping and Locking)
- **App launcher** — Walker with custom Popping and Locking theme (SUPER+Space), blur layer rule
- **Wallpaper** — swww with cycle script (SUPER+P)
- **Status bar** — waybar with workspaces, clock, battery, volume, backlight, bluetooth, network, VPN, IME, system tray
- **Bluetooth** — bluez + bluetui TUI manager (systemctl enable bluetooth)
- **Networking** — iwd + systemd-resolved (no NetworkManager), impala TUI
- **Window rules** — floating TUI popups (fastfetch, tclock, btop, bluetui, impala, calcure, add-webapp, add-termapp, add-vpn), TTE screensaver fullscreen
- **Drift screensaver** — terminal screensaver with random theme cycling on shell idle (2 min), guarded in bashrc
- **TTE screensaver** — ASCII art screensaver triggered by hypridle on system idle (5 min)
- **Command center** — Walker dmenu (SUPER+ALT+Space) for system actions, app/VPN management, keybinds
- **Web apps** — add/remove web apps that open in Brave app mode and appear in Walker
- **Terminal apps** — add/remove terminal apps that open in kitty and appear in Walker
- **App visibility toggle** — hide/show any app in Walker via NoDisplay desktop overrides
- **WireGuard VPN** — add/connect/remove configs via command center, waybar toggle, scoped sudoers
- **Japanese input** — fcitx5 + Mozc, SUPER+grave toggle, waybar EN/あ indicator, CJK fonts, config tracked in repo
- **Calcure calendar** — TUI calendar via waybar clock click, config tracked in repo
- **Screenshots** — hyprshot (output/window/region via Print key combos)
- **Media keys** — volume, brightness, media player controls
- **Browser** — Brave (SUPER+B, set as default via xdg-settings)
- **XDG directories** — xdg-user-dirs-update in setup.sh
- **Helper scripts** — `untracked.sh` shows packages installed but not tracked in packages.sh

## Fresh Install Tested (2026-03-24)

Ran packages.sh + setup.sh on a fresh Arch install. Found and fixed three bugs:
- Drift binary not installed (added `go install` to setup.sh, guarded bashrc init)
- Calcure config not tracked (added calcure/ to repo and symlinks)
- fcitx5 profile not tracked (added fcitx5/ to repo and symlinks — Mozc wasn't configured)
