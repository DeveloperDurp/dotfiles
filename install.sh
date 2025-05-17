#!/bin/bash
sudo apt install stow -y
stow --adopt .
nix-env -iA nixpkgs.myPackages
make devpod
