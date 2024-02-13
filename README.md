# Stow
Stow is used to manage the dotfiles

To install:
```stow --target=$HOME --restow */```

To remove:
```stow --target=$HOME --delete */```

# System Dependencies
1. `ripgrep`: `brew install ripgrep`. Used by `telescope.nvim` to recursively search for (grep) text in files accross directories
2. `node` / `npm`: `brew install node`. Required by `mason.nvim` when installing `pyright` (python language server)

# Fonts
- Install patched version of Menlo font: MesloLGMDZ Mono Nerd Font (found [here](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip))
- Menslo NF is a patched font of Menlo (includes glyphs and icons), which is the standard font used by Apple for the developer tools.
- To better understand the font, read the [doc](https://github.com/andreberg/Meslo-Font?tab=readme-ov-file). The gist of it is that LG stands for line gap (vertical), and the font has 3 sizes: S, M, and L. The font also comes with dotted zero (DZ) or not. Finally, you can choose between Regular, Mono (monospaced, for terminals and code editors) and Propo (proportional)
- My preference is for a medium line gap, dotted zero and monospaced, hence I only install the MesloLGMDZ Nerd Font Mono font family.

# TODO
1. 0 timeout on pressing escape
4. Setup debugging (using docker)
3. Replicate LazyVim keybindings (and groups for which-key)
3. Setup proper dotfiles repo
    1. iTerm2, enable mouse reporting [see here](https://jasonmurray.org/posts/2020/tmuxdebian/), make sure it sticks
