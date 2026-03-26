# Prompt
function fish_prompt
    set_color blue --bold
    echo -n (pwd)
    set_color normal
    set_color green
    echo -n ' ❯ '
    set_color normal
end

# Green command highlight + gray suggestions
set -g fish_color_command        'green'
# set -g fish_color_autosuggestion 'brgrey --dim'
# set -g fish_color_comment        'brgrey --dim'

# Disable greeting
function fish_greeting
end

# VI Keybinds
fish_vi_key_bindings
set KEYTIMEOUT 100

# History search with k/j in vi command mode
bind -M default \ck up-or-search
bind -M default \cj down-or-search

# History configuration
set fish_history max
set HISTSIZE 100000
set HISTFILESIZE 100000
set fish_history_max_lines 100000

# History options (fish does this by default but being explicit)
# - ignore duplicates
# - ignore commands starting with space
set -U fish_hisory_max_lines 100000

# Aliases
alias ls='ls --color=auto -hv'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c=auto'
alias mv='mv -i'
alias ld='lazydocker'
alias lg='lazygit'
alias ly='yadm enter lazygit'
alias vim='nvim'

# Add custom scripts to PATH
set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$HOME/.pixi/bin" $PATH

# Set nvim as EDITOR
set -gx EDITOR nvim

# Set config stuff (used by k9s to load config)
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"

# Brew shellenv for Apple Silicon
if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

# Load work related config, if it exists
if test -f $HOME/.config/fish/work.fish
    source $HOME/.config/fish/work.fish
end

# Set up fzf key bindings and fuzzy completion
fzf --fish | source

# Setup direnv
direnv hook fish | source

# Google Cloud SDK paths
if test -f /opt/homebrew/share/google-cloud-sdk/path.fish.inc
    source /opt/homebrew/share/google-cloud-sdk/path.fish.inc
end

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/divanov/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
