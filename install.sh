#!/bin/bash
rm .bashrc .zshrc
make devpod
echo "hello world" >/tmp/test
