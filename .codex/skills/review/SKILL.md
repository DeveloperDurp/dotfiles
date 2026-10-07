---
name: review
description: Review code changes or completed implementations before handoff or merge. Use for review requests, pre-merge checks, and final implementation review. Runs adversarial reviewers with light review for small changes and a full correctness/security/QA panel for major or high-risk changes, or an explicit full-panel request.
---

# Review

Review the requested changes against the user's goal, constraints, and verification evidence. The user decides the merge.

## Choose scope and depth

- **Diff review:** review uncommitted changes, a commit, branch, or PR. Collect the complete applicable diff, including staged and unstaged changes, and read the affected callers and tests.
- **Completed-work review:** use before a significant implementation handoff or when the user asks to review completed work. Read [references/completed-work.md](references/completed-work.md) for manual QA and the final gate checklist.

Choose review depth independently of scope:

| Change | Review depth |
| --- | --- |
| Small, routine, low-risk change | Light: focused checks and one independent `correctness` reviewer. No extra reviewers or duplicate checks. |
| Major change with broad effects on behavior, contracts, or subsystem boundaries | Full: `correctness`, `security`, and `qa` in parallel. |
| Auth, secrets, migrations, deployment execution, or other high-risk behavior, even in a small diff | Full. |
| Explicit full-panel request | Full, regardless of size or risk. |

Trivial single-line changes may skip independent review; state the skip. If a light reviewer discovers high-risk behavior, escalate to the full panel before approval.

## Collect context and evidence

1. Read applicable instructions and recover the goal, constraints, and decisions from the conversation. Ask only for critical missing context.
2. Resolve the requested target and comparison base. Use the merge-base for branch/PR diffs; do not assume `HEAD~1` represents all requested changes. Preserve unrelated dirty work.
3. For standalone PR/branch reviews, use a dedicated review worktree and lock it before collecting the diff or running checks. The user's main checkout stays read-only. Local uncommitted changes can be reviewed in place without switching branches.
4. Read changed code, neighboring patterns, callers, tests, and relevant history or tracker context. Record findings as source → observation → relevance. Read-only context gathering does not authorize posting comments or changing tracker state.
5. Run or reuse current required checks. For completed work, capture manual QA under the main session using the completed-work reference. For full review, the `qa` executor independently runs the repository's checks; this complements the orchestrator's manual QA.

## Dispatch adversarial reviewers

Use the active client's delegation tool and named roles. Dispatch a full panel in parallel. Each reviewer is a read-only leaf: it does its assigned reading and verification, never implements fixes or spawns reviewers. QA may generate test/build outputs under its role's permissions.

Assignments must be self-contained: `TASK`, `DELIVERABLE`, `SCOPE`, and `VERIFY`, with the role, original goal, constraints, changed paths, diff/base, relevant context, and raw verification evidence. Include completed-work QA artifacts and its checklist when that scope applies. Pass paths rather than pasting whole files when the reviewer can read them. Do not supply the author's rationale or success claims as evidence.

Include this instruction in every assignment:

> Review adversarially: try to disprove that the change satisfies the task. Challenge assumptions, seek counterexamples and failure paths, and verify the evidence within your assigned scope. Report only demonstrated defects or missing required evidence; do not invent findings, demand unrelated work, or treat style preferences as blockers. Return a clean verdict when no qualifying issues remain.

Require `correctness` and `security` to return `MERGE`, `FIX (n blockers)`, or `STOP`, plus located findings (`file:line` or artifact → violated requirement/defect → concrete fix) and checked-and-clean scope. Require `qa` to return `PASS`, `FAIL`, or `BLOCKED`, with exact commands, exit codes, and relevant raw output. A completed-work correctness reviewer must audit every item in its gate checklist.

### Reuse a qualifying review

Reuse a final correctness verdict only when it covers the same final revision and uncommitted diff, goal, constraints, relevant context, required checklist, current QA artifacts, and adversarial review requirement, and returned `MERGE` with no blockers (or an equivalent `APPROVE`). Record the review identifier, inspected tree, evidence, scope, and verdict. Narrower reviews, changed requirements/source, or stale evidence require a fresh reviewer. A visual-only verdict cannot satisfy correctness. Correctness reuse never replaces required security or independent QA lanes.

## Resolve findings and report

1. Keep lane verdicts separate. A missing result or verdict is `INCONCLUSIVE`, never a pass. Retry that lane once with a smaller assignment; if still incomplete, report it.
2. Deduplicate findings. Accept demonstrated issues; rebut incorrect ones with cited code or artifacts. Preserve the requested scope and existing authorization when making fixes.
3. After fixes, rerun affected checks/QA rows and launch fresh reviewers for the affected lanes, scoped to the delta and current evidence. Do not send fixes as a follow-up to an old reviewer. At most two fix/re-review rounds; unresolved disputes become user decision items.
4. Keep a review worktree until its reviewers finish. Then unlock and remove only a clean worktree created for this review. Preserve a pre-existing tree or one containing unrecovered work; report its path rather than forcing removal.
5. Report verdict per required lane, verification commands and exit codes, artifact paths, blockers with concrete fixes, and any user decisions. Keep passing reports short.

Pass only when every required reviewer approves, required checks/QA rows pass, and the full panel's QA lane is `PASS` when applicable. A demonstrated defect or failed required check means failed review. Missing required evidence or an incomplete lane means inconclusive review. Completed-work manual QA failure stops review before dispatch; fix first.

Never merge, force-push, publish, discard unrelated edits, or claim verification without raw evidence. This skill does not authorize commits, pushes, or external writes; use only authorization already provided for the task.
