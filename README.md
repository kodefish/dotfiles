# TODO: Automate installation with ansible
# Stow
Stow is used to manage the dotfiles

To install:
```stow --target=$HOME --restow */```

To remove:
```stow --target=$HOME --delete */```

To adopt a new file `<new file>` into an existing stow `<package>`
```
touch <package>/<path-to-new-file>/<new-file>
stow --adopt --target=$HOME -nv <package>
```

First we need to notify `stow` of the new file by creating an empty plain-text file in the package, that maps to the file we're adopting. Othwerwise, stow will not identify it as a package to adopt. The second command will identify files to adopt and move / link them to the dotfiles repository. This is very useful when moving files into the version control system. 

# System Dependencies
1. `ripgrep`: `brew install ripgrep`. Used by `telescope.nvim` to recursively search for (grep) text in files accross directories
2. `node` / `npm`: `brew install node`. Required by `mason.nvim` when installing `pyright` (python language server)

# Fonts
- Install patched version of Menlo font: MesloLGMDZ Mono Nerd Font (found [here](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip))
- Menslo NF is a patched font of Menlo (includes glyphs and icons), which is the standard font used by Apple for the developer tools.
- To better understand the font, read the [doc](https://github.com/andreberg/Meslo-Font?tab=readme-ov-file). The gist of it is that LG stands for line gap (vertical), and the font has 3 sizes: S, M, and L. The font also comes with dotted zero (DZ) or not. Finally, you can choose between Regular, Mono (monospaced, for terminals and code editors) and Propo (proportional)
- My preference is for a medium line gap, dotted zero and monospaced, hence I only install the MesloLGMDZ Nerd Font Mono font family.

# Python LSP server
Manually install 3rd party plugins:
```
$ cd $XDG_DATA_HOME/nvim/mason/packages/python-lsp-server
$ source venv/bin/activate
$ pip install pylsp-mypy pylsp-rope python-lsp-ruff
$ deactivate
```
A fun TODO would be to enable Mason to auto-install these packages automatically

# Color schemes
- k9s: https://github.com/catppuccin/k9s

# TODO
1. Devcontainer Setup
    1. Figure out how to inject nix and zsh features via cli
    2. Create custom "dc" command
        1. `dc build`: Alias devcontainer creation to inject dotfiles
        2. `dc up`: Alias devcontainer up
        3. `dc attach`: Alias devcontainer exec $SHELL etc etc
1. 0 timeout on pressing escape
4. Setup debugging (using docker)
3. Replicate LazyVim keybindings (and groups for which-key)
3. Setup proper dotfiles repo
    1. iTerm2, enable mouse reporting [see here](https://jasonmurray.org/posts/2020/tmuxdebian/), make sure it sticks

# Vim Plugins to install
1. noice.nvim
2. smart-splits.nvim
3. SmoothCursor.nvim
4. neoscroll.nvim
5. nvim-notify
6. replace illuminate with vim highlighter?
