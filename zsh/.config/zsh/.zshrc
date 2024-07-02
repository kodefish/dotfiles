export XDG_CONFIG_HOME="${HOME}/.config"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Bootstrap Zinit
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Powerlevel 10k prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
# zinit snippet OMZP::azure
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# load completions
autoload -Uz compinit && compinit

# Used by zinit to replay all cached completions
zinit cdreplay -q

# to customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Enable vim mode + keybindings
bindkey -v
# Search history via already entered command (the magic we like about zsh)
bindkey -M vicmd "k" history-search-backward
bindkey -M vicmd "j" history-search-forward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
# Append to history instead of overwrite
setopt appendhistory
# Share history accross zsh sessions
setopt sharehistory
# Prevent a command from being saved to history by prefixing a space
setopt hist_ignore_space    
# Prevent saving duplicates in the history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
# Prevent duplicates from being shown in history
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Add custom scripts to PATH
export PATH=$HOME/.local/bin:$PATH

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias lg=lazygit            # Lazyvim alias to be even lazier
alias ld=lazydocker         # Lazydocker alias to be even lazier
alias t=tmux-sessionizer    # Simple tmux session manager

# Obsidian
export OBSIDIAN_VAULT="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"
alias oo='cd "$OBSIDIAN_VAULT"'

# Load work related config, if it exists
[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/work.zsh ] && source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/work.zsh

# Shell integrations
eval "$(fzf --zsh)"
