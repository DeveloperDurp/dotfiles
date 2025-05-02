#!/usr/bin/zsh
source ~/.config/shell/functions.zsh

new() {

  set-env
  nvim
}

chat() {

  set-env
  nvim +CodeCompanionChat -c only
}

case "$1" in
new) new $2 ;;
chat) chat ;;
*) echo "Please enter an action" ;;

esac
