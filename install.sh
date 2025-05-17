#!/bin/bash
sudo apt update
sudo apt install ansible -y
make devpod
#stow --adopt .
