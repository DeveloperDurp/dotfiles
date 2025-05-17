{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "tools";
      paths = [
        neovim
        go
        lazygit
        glab
        oh-my-posh
        zsh
        fzf
        ripgrep
        rclone
        k9s
        eza
        zoxide
        bat
        opentofu
        helm
        ansible
      ];
    };
  };
}
