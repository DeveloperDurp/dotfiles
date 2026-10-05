---
name: review
description: Merge-gate review procedure. Use when the user asks to review changes, run a pre-merge review, or double-check work before merge. Uses one reviewer for routine changes and a correctness/security/qa panel for high-risk changes or an explicit full-panel request. Not for implementing or planning work.
---

# Merge-gate review

You are reviewing the current changes with independent subagents before the user merges. The user is the merge gate — you never merge.

## Procedure

1. **Scope the diff.** `git status` + `git diff` (include staged). If the user named focus areas, carry them into the reviewer prompts.
2. **Match review to risk**, via the active client's native delegation tool. Use its returned results directly:
   - Routine changes: run or reuse current required checks, then reuse a qualifying final `correctness` verdict under review-work's reuse conditions, or dispatch one `correctness` reviewer to check logic, trust boundaries, and raw verification evidence. When review-work is also required, use its gate review as this correctness lane instead of launching another reviewer.
   - Changes to auth, secrets, migrations, deployment execution, or other high-risk behavior: dispatch `correctness`, `security`, and `qa` in ONE message, in parallel. The `qa` executor independently runs the repo's own checks.
   - An explicit request for the full panel uses all three reviewers regardless of risk.

   Reviewer prompts carry the changed file list, task statement, and available raw verification evidence — no rationale or success claims (blind first pass). If the routine reviewer finds high-risk behavior, run the full panel before approval. Each reviewer ends with a verdict (`MERGE` / `FIX (n blockers)` / `STOP`; qa: `PASS` / `FAIL` / `BLOCKED`), findings as `file:line` + why + fix, and a checked-and-clean list.
3. **Merge findings.** Collapse duplicates. Accept real issues; rebut wrong ones with cited code (`file:line`). Fix what stands, then re-review the delta only. Max 2 fix → re-review rounds; still contested after that → decision item for the user.
4. **Stitch the merge summary:**
   - Verdict for the routine reviewer, or correctness / security / qa for the full panel
   - Open blockers: `file:line` + concrete fix
   - Verification evidence: command + exit code
   - Decision items for the user
5. **Stop.** Report the summary. The user decides the merge.

## Rules
- No merge, no force-push, no publish — the user is the merge gate. (The builder's normal commit-and-push cadence on its working branch is unaffected.)
- A pass claim without raw command output is not evidence.
- Trivial single-line changes may skip review — say so explicitly when skipping.
