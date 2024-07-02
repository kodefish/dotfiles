#!/bin/bash
# Install script used when bootstrapping dotfiles into devcontainer

export XDG_CONFIG_HOME="${HOME}/.config"
mkdir -p $XDG_CONFIG_HOME

# Set zsh as main shell
sudo chsh -s $(which zsh) $(whoami)

# install Nix packages from config.nixstow is not yet installed
ln -sf "${PWD}/nixpkgs/.config/nixpkgs" "${XDG_CONFIG_HOME}/nixpkgs"
nix-env -iA nixpkgs.myPackages

# symlink dotfiles (only editor, git and zsh configs)
ln -sf "${PWD}/git/.config/git" "${XDG_CONFIG_HOME}/git"
ln -sf "${PWD}/nvim/.config/nvim" "${XDG_CONFIG_HOME}/nvim"
ln -sf "${PWD}/zsh/.config/zsh/.zshrc" "${HOME}/.zshrc"
ln -sf "${PWD}/zsh/.config/zsh" "${XDG_CONFIG_HOME}/zsh"

