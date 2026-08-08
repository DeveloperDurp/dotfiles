#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  gh-mr-clone.sh [--sync-existing] <github-repo> <gitlab-repo>

Arguments:
  github-repo  GitHub repository URL or owner/repo
  gitlab-repo  GitLab repository URL (SSH or HTTPS)

Examples:
  gh-mr-clone.sh https://github.com/org/repo.git git@gitlab.com:my-org/repo.git
  gh-mr-clone.sh --sync-existing https://github.com/org/repo.git git@gitlab.com:my-org/repo.git

Options:
  --sync-existing   Force updating existing GitLab branches and merge requests instead of skipping.
EOF
}

SYNC_EXISTING=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --sync-existing)
      SYNC_EXISTING=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      break
      ;;
  esac
done

if [[ $# -ne 2 ]]; then
  usage
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "Error: gh CLI is required (https://cli.github.com)." >&2
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "Error: git is required." >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "Error: jq is required." >&2
  exit 1
fi

if ! command -v glab >/dev/null 2>&1; then
  echo "Error: glab CLI is required (https://gitlab.com/gitlab-org/cli)." >&2
  exit 1
fi

fetch_open_pull_requests_json() {
  local page=1
  local raw_prs_json
  local mapped_prs_json
  local all_prs_json='[]'

  local pr_list_output
  local pr_list_rc=0

  if ! pr_list_output=$(gh pr list --repo "$GITHUB_REPO" --state open --json number,title,body,headRefName --limit 1000 2>&1); then
    pr_list_rc=$?
  fi

  if [[ -z "${pr_list_output-}" ]]; then
    echo "Error: failed to capture output from gh pr list." >&2
    return 1
  fi

  if [[ "$pr_list_rc" -eq 0 ]]; then
    printf '%s\n' "$pr_list_output"
    return
  fi

  if ! grep -Eiq 'unknown .*--json' <<<"$pr_list_output"; then
    echo "$pr_list_output" >&2
    return "$pr_list_rc"
  fi

  if ! gh api --help >/dev/null 2>&1; then
    echo "Error: This version of gh CLI does not support --json on 'gh pr list' and 'gh api' is not available." >&2
    echo "Please upgrade GitHub CLI." >&2
    return 1
  fi

  while :; do
    if ! raw_prs_json=$(gh api "repos/${GITHUB_REPO}/pulls?state=open&per_page=100&page=${page}" 2>/dev/null); then
      echo "Error: failed to fetch pull requests from $GITHUB_REPO using gh api." >&2
      return 1
    fi

    if ! jq -e 'type == "array"' <<<"$raw_prs_json" >/dev/null 2>&1; then
      echo "Error: unexpected response fetching pull requests from $GITHUB_REPO. Ensure API access and repository permissions." >&2
      return 1
    fi

    if [[ "$(jq 'length' <<<"$raw_prs_json")" -eq 0 ]]; then
      break
    fi

    mapped_prs_json=$(jq 'map({number: .number, title: .title, body: .body, headRefName: .head.ref})' <<<"$raw_prs_json")
    all_prs_json=$(jq -s '.[0] + .[1]' <<<"$all_prs_json" <<<"$mapped_prs_json")

    page=$((page + 1))
  done

  printf '%s\n' "$all_prs_json"
}

glab_repo_default_branch() {
  local repo="$1"
  local repo_json
  local default_branch

  if repo_json=$(glab repo view "$repo" --output json 2>/dev/null); then
    default_branch=$(jq -r '.default_branch // .defaultBranch // empty' <<<"$repo_json")

    if [[ -n "$default_branch" && "$default_branch" != "null" ]]; then
      echo "$default_branch"
      return
    fi
  fi

  echo "main"
}

GITHUB_REPO_INPUT="$1"
GITLAB_REPO="$2"

if [[ ! -d .git ]]; then
  echo "Error: run this script from inside a git repository." >&2
  exit 1
fi

normalize_github_repo() {
  local input="$1"
  local repo

  case "$input" in
    https://github.com/*|http://github.com/*)
      repo="${input#*://github.com/}"
      ;;
    git@github.com:*) 
      repo="${input#git@github.com:}"
      ;;
    *)
      repo="$input"
      ;;
  esac

  repo="${repo%.git}"
  repo="${repo#/}"
  echo "$repo"
}

normalize_gitlab_repo_path() {
  local input="$1"
  local repo="$input"

  case "$input" in
    https://*|http://*)
      repo="${input#*://*/}"
      ;;
    git@*:*)
      repo="${input#*:}"
      ;;
  esac

  repo="${repo%.git}"
  repo="${repo#/}"
  echo "$repo"
}

gitlab_branch_exists() {
  local branch="$1"

  if git ls-remote --heads --exit-code "$GITLAB_REPO" "$branch" >/dev/null 2>&1; then
    return 0
  fi

  return 1
}

gitlab_mr_exists() {
  local branch="$1"
  local mr_json
  local open_mr_count

  if ! mr_json=$(glab mr list --repo "$GITLAB_REPO" --source-branch "$branch" --output json 2>/dev/null); then
    if glab mr list --repo "$GITLAB_REPO" --source-branch "$branch" 2>/dev/null | grep -F "(${branch})" >/dev/null; then
      return 0
    fi

    return 1
  fi

  open_mr_count=$(jq '[.[] | select(.state == "opened")] | length' <<<"$mr_json")

  if [[ "$open_mr_count" -gt 0 ]]; then
    return 0
  fi

  return 1
}

GITHUB_REPO="$(normalize_github_repo "$GITHUB_REPO_INPUT")"
GITHUB_FETCH_REPO="$GITHUB_REPO_INPUT"
GITLAB_REPO_PATH="$(normalize_gitlab_repo_path "$GITLAB_REPO")"

if [[ -z "$GITHUB_REPO" ]]; then
  echo "Error: could not parse GitHub repository from '$GITHUB_REPO_INPUT'." >&2
  exit 1
fi

case "$GITHUB_FETCH_REPO" in
  https://*|http://*|git@*) ;;
  *)
    GITHUB_FETCH_REPO="https://github.com/$GITHUB_REPO.git"
    ;;
esac

echo "Retrieving open pull requests from $GITHUB_REPO..."
open_prs_json=$(fetch_open_pull_requests_json)

if [[ "$open_prs_json" == "[]" ]]; then
  echo "No open pull requests found."
  exit 0
fi

gitlab_default_branch=$(glab_repo_default_branch "$GITLAB_REPO")

echo "Pushing PR branches to GitLab repo: $GITLAB_REPO"

printf '%s\n' "$open_prs_json" | jq -c '.[]' | while IFS= read -r pr_json; do
  pr_number="$(jq -r '.number' <<<"$pr_json")"
  head_branch="$(jq -r '.headRefName // empty' <<<"$pr_json")"
  pr_title="$(jq -r '.title // ""' <<<"$pr_json")"
  pr_body="$(jq -r '.body // ""' <<<"$pr_json")"

  if [[ -z "$pr_number" || -z "$head_branch" || "$pr_number" == "$head_branch" ]]; then
    echo "Skipping invalid PR entry: '$pr_json'" >&2
    continue
  fi

  local_branch="gh-pr-${pr_number}"
  safe_head_branch="$(printf '%s' "$head_branch" | tr '/:' '__')"
  gitlab_branch="gh-sync/${pr_number}-${safe_head_branch}"

  echo "------------------------------------------"
  echo "Processing PR #${pr_number} (branch: ${head_branch})"

  if gitlab_branch_exists "$gitlab_branch"; then
    if [[ "$SYNC_EXISTING" -eq 1 ]]; then
      echo "Remote branch ${gitlab_branch} already exists on GitLab; syncing due to --sync-existing."
    else
      echo "Remote branch ${gitlab_branch} already exists on GitLab; skipping push."
    fi
    branch_exists=1
  else
    branch_exists=0
  fi

  if [[ "$SYNC_EXISTING" -eq 1 ]] || [[ "$branch_exists" -eq 0 ]]; then
    echo "Fetching PR #${pr_number} from ${GITHUB_REPO}..."
    if ! git fetch "$GITHUB_FETCH_REPO" "pull/${pr_number}/head:${local_branch}" --force; then
      echo "Warning: failed to fetch PR #${pr_number}; skipping." >&2
      continue
    fi

    echo "Pushing to ${gitlab_branch} on GitLab..."
    if ! git push "$GITLAB_REPO" "${local_branch}:${gitlab_branch}" --force; then
      echo "Warning: failed to push PR #${pr_number}; skipping MR creation." >&2
      git branch -D "$local_branch" || true
      continue
    fi

    echo "Created/updated remote branch ${gitlab_branch}."
  fi

  echo "Creating merge request in GitLab..."
  if gitlab_mr_exists "$gitlab_branch"; then
    mr_exists=1
  else
    mr_exists=0
  fi

  if [[ "$mr_exists" -eq 1 ]]; then
    if [[ "$SYNC_EXISTING" -eq 1 ]]; then
      echo "Merge request for ${gitlab_branch} already exists; updating due to --sync-existing."
      if glab mr update "$gitlab_branch" --repo "$GITLAB_REPO" --title "$pr_title" --description "$pr_body" --yes; then
        echo "Updated MR for PR #${pr_number}."
      else
        echo "Warning: failed to update MR for PR #${pr_number}." >&2
      fi
    else
      echo "Merge request for ${gitlab_branch} already exists; skipping creation."
      if git show-ref --verify --quiet "refs/heads/$local_branch"; then
        git branch -D "$local_branch"
      fi
      continue
    fi
  else
    if glab mr create \
      --repo "$GITLAB_REPO" \
      --head "$GITLAB_REPO_PATH" \
      --source-branch "$gitlab_branch" \
      --target-branch "$gitlab_default_branch" \
      --title "$pr_title" \
      --description "$pr_body" \
      --yes; then
      echo "Created MR for PR #${pr_number}."
    else
      echo "Warning: failed to create MR for PR #${pr_number}; local branch synced to ${gitlab_branch}." >&2
    fi
  fi

  if git show-ref --verify --quiet "refs/heads/$local_branch"; then
    git branch -D "$local_branch"
  fi
done

echo "------------------------------------------"
echo "Done. You can now create Merge Requests in GitLab from branches under 'gh-sync/'."
