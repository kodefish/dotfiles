#!/bin/sh
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# History
HISTFILE=~/.zsh_history

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-history-substring-search"
plug "zap-zsh/vim"

# Prompt config
export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship/starship.toml"
plug "wintermi/zsh-starship"

# Keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Aliases
alias lg=lazygit            # Lazyvim alias to be even lazier
alias ld=lazydocker         # Lazydocker alias to be even lazier
alias t=tmux-sessionizer    # Simple tmux session manager

# Load work related config, if it exists
[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/work.zsh ] && source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/work.zsh
