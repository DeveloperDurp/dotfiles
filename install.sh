#!/bin/bash
rm .bashrc .zshrc .ideavirmrc .gitmodules
sudo apt update

sudo mkdir -m 0755 /nix && sudo chown vscode /nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon
/home/vscode/.nix-profile/bin/nix-env -iA nixpkgs.myPackages

cd "/home/vscode/dotfiles"

stow --adopt .
git reset --hard
