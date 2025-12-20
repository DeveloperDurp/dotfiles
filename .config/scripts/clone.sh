#!/usr/bin/zsh

clone() {

  # Ensure $1 is a valid git SSH URL
  if [[ ! "$1" =~ ^git@[^:]+:[^/]+/.+\.git$ ]]; then
    echo "Error: Invalid git SSH URL"
    return 1
  fi

  # Check if $2 is provided
  if [ -n "$2" ]; then
    REPO="$2"
  else
    REPO=$(echo $1 | awk -F'/' '{print $NF}' | sed 's/\.git$//')
  fi

  dir=$(find $HOME/Documents/gitlab -mindepth 1 -maxdepth 1 -type d | awk -F/ '{print $(NF-0) " " $0}' | fzf --reverse --header "Clone Location" --with-nth=1 | awk '{print $2}')
  [ -z "$dir" ] && return 1

  # Check if the directory already exists
  if [ -d "$dir/$REPO" ]; then
    echo "Error: $dir/$REPO already exists"
    return 1
  fi

  git clone "$1" "$dir/$REPO"
}

case "$1" in
clone) clone $2 $3 ;;
*) echo "Please enter an action" ;;
esac
