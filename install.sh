#!/bin/bash
rm .bashrc .zshrc .ideavirmrc .gitmodules
sudo apt update && sudo apt install stow
stow --adopt .
git reset --hard
nix-env -iA nixpkgs.myPackages
