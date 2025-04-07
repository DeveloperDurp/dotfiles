#!/bin/bash
sudo apt update
sudo apt install ansible stow -y
stow --adopt .
