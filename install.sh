#!/bin/bash
rm .bashrc .zshrc .ideavirmrc .gitmodules
sudo apt update && sudo apt install stow
stow --adopt .
git reset --hard

sh <(curl -L https://nixos.org/nix/install) --no-daemon
nix-env -iA nixpkgs.myPackages
