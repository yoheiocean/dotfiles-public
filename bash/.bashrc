#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias l='eza -l'
alias la='eza -la'
alias a='z'
alias ai='zi'
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$(go env GOPATH 2>/dev/null)/bin:$PATH"

# Zoxide (smart cd)
eval "$(zoxide init bash)"

# Drift screensaver (activates after idle, random theme each launch)
export DRIFT_TIMEOUT=120
eval "$(~/go/bin/drift shell-init bash)"
drift() {
    _DRIFT_THEMES=(cosmic nord dracula catppuccin gruvbox forest wildberries mono rosepine)
    _THEME=${_DRIFT_THEMES[$((RANDOM % ${#_DRIFT_THEMES[@]}))]}
    sed -i "s/^theme.*=.*/theme         = \"$_THEME\"/" "$HOME/.config/drift/config.toml"
    ~/go/bin/drift "$@"
}

# Starship prompt
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init bash)"
