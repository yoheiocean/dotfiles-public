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
PS1='[\u@\h \W]\$ '
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Zoxide (smart cd)
eval "$(zoxide init bash)"
