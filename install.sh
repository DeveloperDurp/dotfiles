#!/bin/bash
sudo apt install stow -y
stow --adopt .
nix-env -iA nixpkgs.myPackages
#sudo apt update
#sudo apt install ansible -y
#make devpod
