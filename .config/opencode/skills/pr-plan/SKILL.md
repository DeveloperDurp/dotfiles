---
name: pr-plan
description: PR pull-and-plan review. Use when the user names a PR, PR number, review URL, or asks to work on/review a PR ("pr #123", "review the PR", "implement the PR feedback"). Pulls full PR context via GitHub CLI, maps it to the codebase, and produces a proposed work plan for approval BEFORE writing any code. After approval, implements, pushes, and drives a CI + codex-review loop until CI is green and codex has no findings. Use ONLY for PR-based work; not for local-only tasks.
---

# PR Plan

You are taking over a GitHub Pull Request. Your job has three hard phases:

1. **Gather** — pull all PR context with the GitHub CLI.
2. **Plan** — produce a proposed implementation plan and STOP for user approval.
3. **Push & converge** — implement, push, and loop CI monitoring + codex review until CI is green and codex reports no findings.

Do not write, edit, or commit any code until the user explicitly approves the plan.

## Step 1 — Resolve the PR

A PR is referenced by number, branch, or "current". Resolve in this order, silently moving to the next step once you have it:

```bash
# explicit number
gh pr view <number> --json number,title,body,state,baseRefName,headRefName,author,labels,reviewDecision,comments

# current branch
gh pr view --json number,title,body,state,reviewDecision,headRefName,baseRefName
```

If no PR exists for the current branch, say so and ask the user which PR they mean — do not guess.

## Step 2 — Pull the full context

Run these and read all of it (skip any that error and note the omission):

```bash
gh pr view <number> --json number,title,body,state,isDraft,author,labels,reviewDecision,additions,deletions,changedFiles
gh pr diff <number> --patch                        # full diff; large ones -> fetch each file with gh pr diff --name-only then gh api
gh pr view <number> --comments                     # review comments and discussion
gh pr checks <number>                              # CI status; note failing checks
gh pr list --state open --author @me 2>/dev/null   # optional: sibling PRs that could conflict
```

Add to the local picture without re-asking the user:

- The file list and size from the diff decide how deep to read: small PR → read every changed file in full; large PR → read the diff hunks plus their containing functions enough to hold the surrounding context.
- Fetch the merge-base and check whether `main` has moved past the PR if the diff looks stale (`git fetch origin && git merge-base HEAD origin/main`).

## Step 3 — Map to the codebase

For each substantive change in the PR, identify in the actual codebase:

- The touched files' callers and tests (grep, don't assume).
- Existing helpers, types, and patterns the PR should reuse instead of duplicating.
- Where the change conflicts with repository conventions (read a neighboring file or the project AGENTS.md if present).

Record anything the PR text claims but the code contradicts — that is a finding, not noise.

## Step 4 — Produce the plan (deliverable)

Respond with exactly this structure:

1. **PR summary** — title, number, author, state, CI/review status in one line each.
2. **What the PR asks for** — intent distilled from title, body, comments, and diff; quote the comments that assign you explicit work.
3. **Proposed approach** — ordered, concrete steps referencing real files and symbols from Step 3. Each step: what changes, in which files, why.
4. **Risks & open questions** — conflicts with main, failing CI, unclear requirements, anything needing a product decision.
5. **Out of scope** — tempting adjacent changes you are deliberately not touching.

Then stop and wait. The user must approve before implementation starts.
Use the todowrite tool only after approval, and only for work it covers.

## Step 5 — Implement, push, and converge (after approval)

After the user approves the plan, implement it, commit, and push to the PR branch. Then run this loop until both exit conditions are met:

1. **Monitor CI** — poll `gh pr checks <number>` until every check completes. Use `gh run watch` on the failing/pending run for progress. A timeout of ~30 minutes total is reasonable; on timeout, report the state and stop.
2. **Request codex review** — if the remote is GitHub (it is; this skill requires `gh`), post `@codex please review latest changes` as a PR comment:

   ```bash
   gh pr comment <number> --body "@codex please review latest changes"
   ```

   Then poll for the codex review feedback (`gh pr view <number> --comments`) and treat codex's findings as new work items.
3. **Act on findings** — fix every real finding, commit, push. Pushing resets both gates: repeat from step 1.
4. **Exit** — the loop is done only when CI is fully green AND codex posted no new findings on the latest push. Report the final state to the user.

Order the two checks sensibly (CI first is typical) but do not stall: if CI is green while you wait for codex, keep polling both.

## Constraints

- Read-only until approved: no edits, no commits, no pushes, no `gh pr` mutations (no merge, no comment posting). After approval, pushing to the PR branch and posting the `@codex` review-request comment are allowed; merges still require an explicit user request.
- Do not invent requirements the PR text doesn't support; list ambiguities instead.
- If `gh` is unavailable or unauthenticated, report exactly what failed and ask, rather than degrading to a partial analysis silently.
