---
name: pr-plan
description: PR pull-and-plan review. Use when the user names a PR, PR number, review URL, or asks to work on/review a PR ("pr #123", "review the PR", "implement the PR feedback"). Pulls full PR context via GitHub CLI, maps it to the codebase, and produces a proposed work plan for approval BEFORE writing any code. Use ONLY for PR-based work; not for local-only tasks.
---

# PR Plan

You are taking over a GitHub Pull Request. Your job has two hard phases:

1. **Gather** — pull all PR context with the GitHub CLI.
2. **Plan** — produce a proposed implementation plan and STOP for user approval.

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

## Constraints

- Read-only until approved: no edits, no commits, no pushes, no `gh pr` mutations (no merge, no comment posting).
- Do not invent requirements the PR text doesn't support; list ambiguities instead.
- If `gh` is unavailable or unauthenticated, report exactly what failed and ask, rather than degrading to a partial analysis silently.
