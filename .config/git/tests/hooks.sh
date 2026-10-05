#!/usr/bin/env bash
set -euo pipefail

hook_dir=$(cd "$(dirname "$0")/../hooks" && pwd)
test_root=$(mktemp -d)
trap 'rm -rf -- "$test_root"' EXIT
export HOME="$test_root/home"
export GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null
unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
mkdir -p "$HOME/.local/share/watermarks-remover/service/scripts" "$test_root/bin"
touch "$HOME/.local/share/watermarks-remover/service/scripts/check_staged.py"

# Test only the hook adapter: the fixture rejects BAD in the supplied snapshot.
cat > "$test_root/bin/python3" <<'SH'
#!/usr/bin/env bash
set -euo pipefail
shift
for file in "$@"; do
    if LC_ALL=C grep -q BAD "$file"; then exit 1; fi
done
SH
chmod +x "$test_root/bin/python3"
export PATH="$test_root/bin:$PATH"
# Git runs reference-transaction before a newly initialized repo is readable.
git -c core.hooksPath="$hook_dir" init -q "$test_root/repo"
cd "$test_root/repo"
git config user.name Test
git config user.email test@example.invalid
git config core.hooksPath "$hook_dir"

expect_failure() {
    if "$@"; then
        echo 'Expected failure, but the command passed.' >&2
        exit 1
    fi
}

# An initial commit checks the index, not unstaged edits or filename options.
printf 'clean\n' > '-file with spaces.txt'
git add -- '-file with spaces.txt'
printf 'BAD\n' > '-file with spaces.txt'
"$hook_dir/pre-commit"
git commit -qm initial

printf 'BAD\n' > '-file with spaces.txt'
git add -- '-file with spaces.txt'
printf 'clean\n' > '-file with spaces.txt'
expect_failure "$hook_dir/pre-commit"
expect_failure "$hook_dir/pre-merge-commit"
test "$(cat './-file with spaces.txt')" = clean
git reset -q HEAD -- '-file with spaces.txt'

# Staged symlinks and deletions must not scan their targets or stale files.
printf 'BAD\n' > "$test_root/target"
ln -s "$test_root/target" link.txt
git add link.txt
"$hook_dir/pre-commit"
git rm -q -- '-file with spaces.txt'
"$hook_dir/pre-commit"
git commit -qm 'track symlink'
rm link.txt
printf 'BAD\n' > link.txt
git add link.txt
expect_failure "$hook_dir/pre-commit"
printf 'clean\n' > link.txt
git add link.txt

# Preserve project hooks, arguments, and failures for other hook types too.
cat > .git/hooks/pre-commit <<'SH'
#!/usr/bin/env bash
printf 'called\n' > "$(git rev-parse --git-common-dir)/project-hook-ran"
exit 7
SH
chmod +x .git/hooks/pre-commit
expect_failure "$hook_dir/pre-commit"
test -f .git/project-hook-ran

cat > .git/hooks/commit-msg <<'SH'
#!/usr/bin/env bash
printf '%s\n' "$1" > .git/message-argument
exit 9
SH
chmod +x .git/hooks/commit-msg
expect_failure "$hook_dir/commit-msg" 'message path'
test "$(cat .git/message-argument)" = 'message path'

# Linked worktrees share the main repository's project hooks.
git worktree add -q -b test-worktree "$test_root/worktree" HEAD
cd "$test_root/worktree"
expect_failure "$hook_dir/pre-commit"

echo 'Git hook checks passed.'
