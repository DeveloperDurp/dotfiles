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
        fzf
        ripgrep
        rclone
        k9s
        eza
        zoxide
        bat
        opentofu
        helm
        vivid
        stow
        bitwarden-cli
        wofi
        nmap
        kubectl
        podman
        podman-compose
        podman-desktop
        helm
        htop
        yubikey-manager
        gimp
        yazi
        powershell
        devpod
        devpod-desktop
        nerd-fonts.go-mono
        libsecret
      ];
    };
  };
}
