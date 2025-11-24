# Prompt
PS1='%F{blue}%B%~%b%f %F{green}❯%f '

# VIM Keybinds
bindkey -v
export KEYTIMEOUT=1
# Search history via already entered command (the magic we like about zsh)
bindkey -M vicmd "k" history-search-backward
bindkey -M vicmd "j" history-search-forward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# History
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
HISTSIZE=100000
SAVEHIST=100000
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

# Aliases (stdlib stuff, just with better opts)
alias ls='ls --color=auto -hv'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c=auto'
alias mv='mv -i'
alias ld='lazydocker'
alias lg='lazygit'
alias ly='yadm enter lazygit'
alias vim='nvim'

# Completions
autoload -U compinit && compinit

# Add custom scripts to PATH
export PATH="$HOME/.local/bin:$PATH"

# Add global pixi executables to the PATH
export PATH="$HOME/.pixi/bin:$PATH"

# Set nvim as EDITOR
export EDITOR=nvim

# Load work related config, if it exists
[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/work.zsh ] && source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/work.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Setup direnv
eval "$(direnv hook zsh)"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/divanov/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi
