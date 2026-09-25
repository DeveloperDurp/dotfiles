---
name: pr-review-loop
description: |
  Defend-the-merge loop for DevelopingDurp/DurpDeploy PRs: branch → PR linking the issue →
  drive CI to all-green → "@codex please review latest changes" → address every finding →
  fix, push, repeat until zero CI failures AND zero open Codex findings. Use whenever the
  user asks to "review PR with codex", "fix findings", "make CI green", "loop until
  no findings", or after any implementation that ends in a PR.
---

# PR Review Loop

You are running the merge gate for this pull request. The loop has two gates that
must BOTH be green before you report completion: every CI check, and every Codex finding.

Do not stop to narrate between iterations. Do not declare done while a check is missing,
pending, skip-only, failing, or a Codex suggestion stands unresolved.

## Step 0 — Branch and PR

```bash
git checkout -b fix/issue-NN-<slug>           # base: current origin/main
# ... minimal, scoped change ...
git commit -m "<summary above references the issue>"
git push -u origin <branch>
gh pr create --title "<imperative headline>" --body "<summary + 'Fixes #NN'>"
```

Rules learned the hard way:

- **Branch off `origin/main`, freshly fetched.** A branch built on a stacked feature branch
  carries that branch's pre-merge content, and CI (which merges `main` into the PR head)
  then compiles code the local tree no longer matches. Symptom: tests fail in CI with
  wire shapes that pass locally. If you ever suspect divergence, verify with
  `git diff origin/main...HEAD --stat` before pushing.
- Only copy files intentionally changed for this PR when rebuilding a branch; `git status`
  must show nothing but intended changes.
- Prefer one small commit over rewriting; `gh pr checks` polls the *merge* ref, so CI sees
  `main + HEAD`, not whatever is lying around in the worktree.

## Step 1 — make it green locally first

Before pushing run:

```bash
golines --max-len=80 --ignore-generated -l .        # empty output
gofmt -l .                                           # empty output
go vet ./...
make e2e-test-isolated                               # or ./scripts/e2e_test.sh (~4 min)
```

For the container-engine tests locally (they need Docker-compatible providers):

```bash
podman system service --time=0 unix:///tmp/opencode/podman.sock &
mkdir -p /tmp/podman-sock && ln -sf /tmp/opencode/podman.sock /tmp/podman-sock/docker.sock
export XDG_RUNTIME_DIR=/tmp/podman-sock
export TESTCONTAINERS_RYUK_DISABLED=true   # testcontainers' reaper doesn't work on podman
```

Then `go test -count=1 ./...`.

Podman cannot create a network named `bridge` — that is why the ryuk disable is required
and, once disabled, testcontainers/quarkus engine tests pass against real
PostgreSQL / Microsoft SQL Server containers.

Then run the E2E suite against the running server before pushing:

```bash
./scripts/e2e_test.sh                # prints PASS lines + teardown
```

## Step 2 — watch CI

Poll until every job reaches either `pass` or `skipping`:

```bash
while :; do
  pending=$(gh pr checks <PR#> 2>&1 | grep -cE 'pending|fail|skipping' || true)
  [ "$pending" -eq 0 ] && break
  sleep 60
done
gh pr checks <PR#>
```

For a faster triage fail the merge-check runs inspect just the flagged job:

```bash
gh run view --job <job-id> --log 2>/dev/null | tail -30
gh run view --log-failed --job <job-id>
```

SonarCloud status and per-PR issues (no re-run needed):

```bash
curl -s "https://sonarcloud.io/api/qualitygates/project_status?projectKey=developerdurp_durpdeploy&pullRequest=<PR#>"
curl -s "https://sonarcloud.io/api/issues/search?pullRequest=<PR>&componentKeys=developerdurp_durpdeploy&resolved=false"
```

If Sonar is red and its issues list is empty, hit the quality-gate API and see which
