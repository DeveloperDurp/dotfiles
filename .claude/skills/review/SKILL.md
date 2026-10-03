---
name: review
description: Merge-gate review procedure. Use when the user asks to review changes, run a pre-merge review, or double-check work before merge. Directs the agent to fan out the correctness, security, and qa subagents on the current diff and stitch a merge summary. Not for implementing or planning work.
---

# Merge-gate review

You are reviewing the current changes with independent subagents before the user merges. The user is the merge gate — you never merge.

## Procedure

1. **Scope the diff.** `git status` + `git diff` (include staged). If the user named focus areas, carry them into the reviewer prompts.
2. **Fan out in ONE message, in parallel**, via the active client's native delegation tool. Use its returned results directly:
   - `correctness` — logic, edge cases, swallowed errors, test adequacy
   - `security` — untrusted boundaries, secrets, auth/file/network paths, infra diffs
   - `qa` — independently runs the repo's own test/build/typecheck commands

   Reviewer prompts carry the changed file list and the task statement ONLY — no rationale, no success claims (blind first pass). Each reviewer ends with a verdict (`MERGE` / `FIX (n blockers)` / `STOP`; qa: `PASS` / `FAIL` / `BLOCKED`), findings as `file:line` + why + fix, and a checked-and-clean list.
3. **Merge findings.** Collapse duplicates. Accept real issues; rebut wrong ones with cited code (`file:line`). Fix what stands, then re-review the delta only. Max 2 fix → re-review rounds; still contested after that → decision item for the user.
4. **Stitch the merge summary:**
   - Verdicts: correctness / security / qa
   - Open blockers: `file:line` + concrete fix
   - Verification evidence: command + exit code
   - Decision items for the user
5. **Stop.** Report the summary. The user decides the merge.

## Rules
- No merge, no force-push, no publish — the user is the merge gate. (The builder's normal commit-and-push cadence on its working branch is unaffected.)
- A pass claim without raw command output is not evidence.
- Trivial single-line changes may skip review — say so explicitly when skipping.
