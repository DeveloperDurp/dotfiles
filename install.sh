#!/bin/bash
rm .bashrc .zshrc .ideavirmrc .gitmodules
sudo apt update && sudo apt install stow
stow --adopt .
git reset --hard

curl -L https://nixos.org/nix/install | sh -s -- --daemon
nix-env -iA nixpkgs.myPackages
