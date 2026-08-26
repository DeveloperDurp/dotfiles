#!/usr/bin/zsh
source "$HOME/.config/shell/functions.zsh"

workspace_id_by_name() {
  herdr workspace list |
    jq -r --arg name "$1" \
      '.result.workspaces | map(select(.label == $name)) | first.workspace_id // empty'
}

focused_workspace_id() {
  herdr workspace list |
    jq -r '.result.workspaces[] | select(.focused).workspace_id'
}

focus_workspace() {
  local workspace
  workspace=$(workspace_id_by_name "$1")

  if [[ -n "$workspace" ]]; then
    herdr workspace focus "$workspace" >/dev/null
    return 0
  fi

  return 1
}

create_workspace() {
  local name=$1
  local dir=$2
  local command=${3:-}
  local created workspace pane

  if focus_workspace "$name"; then
    return
  fi

  created=$(herdr workspace create --cwd "$dir" --label "$name" --no-focus) || return
  workspace=$(jq -r '.result.workspace.workspace_id' <<<"$created")
  pane=$(jq -r '.result.root_pane.pane_id' <<<"$created")

  if [[ -n "$command" ]]; then
    herdr pane run "$pane" "$command" >/dev/null || return
  fi

  herdr workspace focus "$workspace" >/dev/null
}

new() {
  local dir=${1:-}
  local name created workspace editor agent

  if [[ -z "$dir" ]]; then
    name=$(find "$HOME/Documents/gitlab" -mindepth 2 -maxdepth 2 -type d |
      awk -F/ '{print $(NF-1)"/"$NF}' |
      sort |
      wofi --dmenu -i -p "New Workspace" --columns 1)

    [[ -z "$name" ]] && return
    dir="$HOME/Documents/gitlab/$name"
  fi

  if [[ ! -d "$dir" ]]; then
    print -u2 "Error: Directory not found: $dir"
    return 1
  fi

  name=${${dir:t}#.}

  if focus_workspace "$name"; then
    return
  fi

  created=$(herdr workspace create --cwd "$dir" --label "$name" --no-focus) || return
  workspace=$(jq -r '.result.workspace.workspace_id' <<<"$created")
  editor=$(jq -r '.result.root_pane.pane_id' <<<"$created")

  agent=$(
    herdr pane split "$editor" \
      --direction right \
      --ratio 0.67 \
      --cwd "$dir" \
      --no-focus |
      jq -r '.result.pane.pane_id'
  ) || return

  herdr tab create \
    --workspace "$workspace" \
    --cwd "$dir" \
    --label terminal \
    --no-focus >/dev/null || return

  herdr pane run "$agent" "opencode ." >/dev/null || return
  herdr pane run "$editor" "clear; set-env; exec nvim" >/dev/null || return
  herdr workspace focus "$workspace" >/dev/null
}

switch() {
  local workspace

  workspace=$(
    herdr workspace list |
      jq -r '.result.workspaces[] | [.workspace_id, .label] | @tsv' |
      fzf --reverse --header "Switch Workspace" --no-preview |
      cut -f1
  )

  [[ -n "$workspace" ]] && herdr workspace focus "$workspace" >/dev/null
}

delete() {
  local workspace

  workspace=$(
    herdr workspace list |
      jq -r '.result.workspaces[] | select(.focused | not) | [.workspace_id, .label] | @tsv' |
      fzf --reverse --header "Delete Workspace" --no-preview |
      cut -f1
  )

  [[ -n "$workspace" ]] && herdr workspace close "$workspace" >/dev/null
}

window() {
  local workspace tab

  workspace=$(focused_workspace_id)
  [[ -z "$workspace" ]] && return 1

  tab=$(
    herdr tab list --workspace "$workspace" |
      jq -r '.result.tabs[] | select(.focused | not) | [.tab_id, .label] | @tsv' |
      fzf --reverse --header "Switch Tab" --no-preview |
      cut -f1
  )

  [[ -n "$tab" ]] && herdr tab focus "$tab" >/dev/null
}

notes() {
  create_workspace notes "$HOME/Documents/notes" "clear; exec nvim Welcome.md"
}

popup() {
  create_workspace popup "$HOME" "clear"
}

scratch() {
  create_workspace scratch "$HOME" "clear; exec nvim scratch"
}

goland-new() {
  local dir=${1:-}
  local name

  if [[ -z "$dir" ]]; then
    name=$(find "$HOME/Documents/gitlab" -mindepth 2 -maxdepth 2 -type d |
      awk -F/ '{print $(NF-1)"/"$NF}' |
      sort |
      wofi --dmenu -i -p "New JetBrains Workspace" --columns 1)

    [[ -z "$name" ]] && return
    dir="$HOME/Documents/gitlab/$name"
  fi

  if [[ ! -d "$dir" ]]; then
    print -u2 "Error: Directory not found: $dir"
    return 1
  fi

  if [[ "$dir" == *dotnet* ]]; then
    /home/user/.local/share/JetBrains/Toolbox/apps/rider/bin/rider "$dir" &
    return
  fi

  /home/user/.local/share/JetBrains/Toolbox/scripts/goland "$dir" &

  name=${${dir:t}#.}
  create_workspace "$name" "$dir"
}

case "$1" in
new) new "${2:-}" ;;
switch) switch ;;
delete) delete ;;
window) window ;;
notes) notes ;;
popup) popup ;;
scratch) scratch ;;
goland-new) goland-new "${2:-}" ;;
*) echo "Please enter an action" ;;
esac
