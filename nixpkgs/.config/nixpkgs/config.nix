{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "dev-tools";
      paths = [
        neovim
        ripgrep
        fzf
        lazygit
        lazydocker
        bat
        poetry
      ];
    };
  };
}
