---
name: review-work
description: "Post-implementation gate review: run manual QA on the real surface yourself, then launch ONE gate reviewer (never a panel) to audit goal, constraints, code quality, security, missed context, and QA evidence. Use before a PR handoff or when the user explicitly asks to review completed work."
---
## Spawning the reviewer (OpenCode)

Spawn the gate reviewer with the `task` tool (`subagent_type="correctness"`)
and use its returned result directly. The spawned message is a
self-contained executable assignment: `TASK: <imperative assignment>`, then
`DELIVERABLE`, `SCOPE`, and `VERIFY`, with the role inside the prompt. Review
lanes are leaf agents: a lane does its own reading, running, and judging inline
and never spawns sub-reviewers of its own. Reviewers are one-shot: a lane ends at
its verdict; a re-review after fixes is a fresh spawn scoped to the delta plus
current evidence. A task that ends without the deliverable is
`INCONCLUSIVE` — never a PASS; respawn smaller or keep the lane `INCONCLUSIVE`
and still emit a final aggregate result.

# Review Work - Gate Review Orchestrator

Review completed implementation work through exactly two lanes: your own hands-on manual QA on the real surface, and ONE gate reviewer sub-agent that audits the whole change set against the goal, the constraints, and your QA evidence. The review passes only when the QA matrix has no failing row AND the gate reviewer returns APPROVE.

One reviewer, not a panel. A single gate reviewer holding the full context (goal, diff, history, QA evidence) catches what a fan-out of narrow reviewers misses between their seams, and it costs one agent instead of five. Never add review lanes; widen the gate reviewer's checklist instead.

| Lane | Who runs it | Question it answers |
|------|-------------|---------------------|
| Manual QA | You, the orchestrator, on the real surface | Does it actually work? |
| Gate review | One gate reviewer sub-agent (`correctness`) | Did we build what was asked - correctly, safely, well, and without missing context? |

---

## Phase 0: Gather Review Context

Before running anything, collect these inputs. Extract from conversation history first - the user's original request, constraints discussed, and decisions made are usually already in the thread. Only ask if truly missing.

<required_inputs>

- **GOAL**: The original objective. What was the user trying to achieve? Pull from the initial request in this conversation.
- **CONSTRAINTS**: Rules, requirements, or limitations. Tech stack restrictions, performance targets, API contracts, design patterns to follow, backward compatibility needs.
- **BACKGROUND**: Why this work was needed. Business context, user stories, related systems, prior decisions that informed the approach.
- **CHANGED_FILES**: Auto-collect via `git diff --name-only HEAD~1` or against the appropriate base (branch point, specific commit).
- **DIFF**: Auto-collect via `git diff HEAD~1` or against the appropriate base.
- **FILE_CONTENTS**: The full content of each changed file plus the neighboring files that show the established patterns. Pass the paths and the diff instead of pasting everything; paste full contents only when the reviewer cannot read files.
- **RUN_COMMAND**: How to start/run the application. Check `package.json` scripts, `Makefile`, `docker-compose.yml`, or ask the user.
- **CONTEXT_MINING**: What the history and the trackers say about this area (collected below).

</required_inputs>

Review PRs and branches from a dedicated review worktree only: create or attach one with `git worktree add <path> <branch>` before collecting changed files, diff, file contents, or running checks, then immediately lock it with `git worktree lock <path> --reason "review:<pr-or-branch>"`. The main worktree is read-only context; never checkout, test, or edit the review branch there.

**Auto-collection sequence:**

```bash
# 1. Get changed files
git diff --name-only HEAD~1  # or: git diff --name-only main...HEAD

# 2. Get diff
git diff HEAD~1  # or: git diff main...HEAD

# 3. Detect run command
# Check package.json -> "scripts.dev" or "scripts.start"
# Check Makefile -> default target
# Check docker-compose.yml -> services

# 4. Mine the context the implementation may have missed (keep the output short)
git log --oneline -20 -- <each changed file>            # recent changes and their reasons
git log --all --oneline --grep="<keywords from goal>"    # related commits, reverts
gh issue list --search "<keywords>" --state all           # related issues (when gh is available)
gh pr list --search "<keywords>" --state all              # related PRs and their review comments
rg -n "TODO|FIXME|HACK" <changed files>                   # warnings left by previous authors
# plus: files that import the changed modules, tests touching the same paths,
# docs and config that reference the changed behavior
```

Record CONTEXT_MINING as a short list: source -> finding -> why it matters for this change. Slack, Notion, and Discord searches belong here too when those tools exist.

For GOAL, CONSTRAINTS, BACKGROUND - review the full conversation history. The user's original message almost always contains the goal. Constraints often emerge during discussion. If anything critical is ambiguous, ask ONE focused question - not a checklist.

---

## Phase 1: Manual QA (you run it)

You are the QA lane. Do not delegate hands-on QA to a sub-agent: the orchestrator owns the real-surface proof, and the merge summary records `manualQa` under the main session.

1. **Reuse first.** If this session already captured real-surface evidence for the FINAL tree (a prior evidence directory, a `visual-qa` verdict on this same build), consume it as QA rows instead of re-running. A fix committed after a capture stales that capture: re-run the rows it covered.
2. **Pick the channel that faithfully exercises the surface** and capture the artifact:
   - HTTP: `curl -i` (or an API request context) - status line, headers, body.
   - CLI / TUI: a real pty - drive the command and keep the transcript; for color or layout evidence render through a browser-based terminal, never a `tmux capture-pane` dump.
   - Web: omowright from js eval (staged in the `browser` skill) — the owned engine (`connectPipe` on a task-owned profile, or `connectCloakProfile` for bot-scored targets) for unauthenticated pages, the attached engine (`connectBrowserSkill()` in the user's signed-in browser) when the page needs their login; never a clone of or a launch against the live profile. Capture action log plus screenshot.
   - Desktop / GUI: OS-level automation against the running app - action log plus screenshot.
   - Library / SDK: a script that imports and exercises the public API - transcript.
   - Data-shaped work (migrations, configs, generated files): the resulting artifact itself, diffed or dumped.
3. **Cover at least**: the happy path the goal names, the riskiest edge (empty, boundary, malformed, or concurrent input), and one regression on adjacent behavior the change could have broken. Add a row for every stated success criterion.
4. **Build the QA matrix** - one row per scenario:

| # | Scenario | Exact command / action | Expected | Observed | Verdict | Artifact |
|---|----------|------------------------|----------|----------|---------|----------|

A row without an artifact path is not PASS. If the application cannot even start, that is an immediate FAIL.

Any FAIL ends the review here: report **REVIEW FAILED** with the failing rows and skip the gate reviewer - reviewing code that does not work wastes the reviewer. Fix first, then re-enter at Phase 0 with the delta.

---

## Phase 2: Launch the Gate Reviewer (one agent)

Launch exactly one reviewer and use its returned verdict before continuing.

`correctness` reads files and runs read-only commands: hand it the repo paths, the diff, CONTEXT_MINING, and the QA matrix. Paste full contents only for files outside the repo.

```
task(
  subagent_type="correctness",
  description="Gate-review the completed work against goal, constraints, and QA evidence",
  prompt="""
<review_type>GATE REVIEW</review_type>

<original_goal>
{GOAL - paste the user's original request and any clarifications}
</original_goal>

<constraints>
{CONSTRAINTS - every rule, requirement, or limitation discussed}
</constraints>

<background>
{BACKGROUND - why this work was needed, broader context}
</background>

<changed_files>
{CHANGED_FILES - list of modified file paths}
</changed_files>

<file_contents>
{FILE_CONTENTS - full content of every changed file plus neighboring files that show existing patterns; or the paths, when the reviewer can read files}
</file_contents>

<diff>
{DIFF - the actual git diff}
</diff>

<context_mining>
{CONTEXT_MINING - git history, related issues and PRs, docs and config that reference the changed behavior, warnings from previous authors}
</context_mining>

<manual_qa_matrix>
{QA MATRIX - every row with its artifact path}
</manual_qa_matrix>

Role: final gate reviewer. You do not implement fixes. Assume every success claim is unverified until you reproduce it from the artifacts: executors can be wrong, tests can be too narrow, success prose can be misleading.

Review from the user's perspective first: what did they originally want, what result did they expect to receive, and does the shipped change actually satisfy that outcome? Then work the checklist. Be obsessively thorough - the point of this review is to catch what the implementer missed.

REVIEW CHECKLIST:

1. **Goal completeness**: break the goal into every sub-requirement (explicit AND implied). Mark each ACHIEVED / MISSED / PARTIAL with code evidence. An implied requirement a reasonable engineer would have addressed counts.
2. **Constraint compliance**: list every constraint and verify each with specific evidence. A violated constraint is a blocker.
3. **Behavioral correctness**: trace 3+ representative scenarios and 5+ edge cases (empty, boundary, malformed, concurrent, failure paths) through the code. Logic errors, off-by-one, null handling, races, leaks, unhandled rejections.
4. **Code quality**: pattern consistency with the neighboring files, naming, error handling (no swallowed errors), type safety (no `as any` or suppressions), performance on hot paths, abstraction level, tests that are meaningful rather than tautological or implementation-mirroring, API and breaking-change hygiene.
5. **Security**: input validation and injection vectors (SQL, XSS, command, path traversal, SSRF), authentication and authorization, secrets in code or logs, data exposure, new dependencies and lockfile consistency, unsafe file and network handling.
6. **Missed context**: does the change respect the reasons recorded in history, issues, PR reviews, and docs? Does anything that imports or documents the changed behavior need to move with it?
7. **QA evidence audit**: for every matrix row, does the artifact exist and prove what the row claims? Name any success criterion that has no covering row.
8. **Scope**: anything added that was not asked for - unnecessary abstraction, speculative generality, unrequested hardening - is a NOTE unless it breaks a constraint.

APPROVE unless you can cite a specific goal item, constraint, or QA row that the artifact fails, with the evidence that proves it (including an artifact a criterion requires but that is missing). A gap you cannot tie to the stated goal - style preference, alternative design, a scenario the goal never named - is a NOTE, not a blocker. You do not judge approach optimality or hypothetical future requirements.

OUTPUT FORMAT:
<verdict>APPROVE or REJECT</verdict>
<confidence>HIGH / MEDIUM / LOW</confidence>
<summary>1-3 sentence overall assessment from the user's perspective</summary>
<goal_breakdown>
  - [ACHIEVED/MISSED/PARTIAL] Requirement - evidence (file:line or artifact)
</goal_breakdown>
<constraint_compliance>
  - [ACHIEVED/MISSED] Constraint - evidence
</constraint_compliance>
<qa_audit>
  - [VERIFIED/UNPROVEN] Row # - what the artifact shows, or what is missing
</qa_audit>
<blocking_issues>
  - Violated goal item / constraint / QA row -> observation -> file:line or artifact pointer -> exact fix. Empty if APPROVE.
</blocking_issues>
<notes>Non-blocking findings, grouped by theme (quality, security, context). Keep them short.</notes>
""")
```

---

## Phase 3: Integrate the Returned Review

Use the result returned by the reviewer task. Do not treat an empty result as APPROVE.

Store the lane verdicts independently:

| Lane | Verdict | Notes |
|------|---------|-------|
| Manual QA (Phase 1) | PASS/FAIL | rows, artifact paths |
| Gate review | pending/APPROVE/REJECT/INCONCLUSIVE | - |

If the task returns without a verdict, record the lane INCONCLUSIVE and spawn one smaller reviewer scoped to the same inputs. If that retry also lacks a verdict, keep the lane INCONCLUSIVE and emit the final result naming the incomplete lane.

After the lane reaches a terminal state and before delivering the verdict, tear down the review worktree: run `git worktree unlock <path>` followed by `git worktree remove <path>`. The reviewer runs inside that worktree, so removing it earlier destroys its working directory; a crashed review leaves the locked tree as a recoverable marker for manual cleanup.

A re-review after fixes is a fresh Phase 0 -> 3 pass scoped to the delta plus the current evidence: re-run the affected QA rows and spawn a NEW reviewer with the delta diff and the blockers it must re-check. Never send fixes as a followup to the previous reviewer.

---

## Phase 4: Deliver Verdict

<verdict_logic>

QA matrix has no FAIL row AND the reviewer returned APPROVE → **REVIEW PASSED**
Any QA row FAIL OR the reviewer returned REJECT → **REVIEW FAILED - criteria not met**
Reviewer INCONCLUSIVE and nothing failed → **REVIEW INCONCLUSIVE - not approved**

</verdict_logic>

Compile the final report in this format:

```markdown
# Review Work - Final Report

## Overall Verdict: PASSED / FAILED / INCONCLUSIVE

| Lane | Verdict | Confidence |
|------|---------|------------|
| Manual QA (N rows, M artifacts) | PASS/FAIL | - |
| Gate review | APPROVE/REJECT/INCONCLUSIVE | HIGH/MED/LOW |

## Blocking Issues
[Failing QA rows first, then the reviewer's blockers - deduplicated, in fix order, each with its pointer]

## Key Findings
[Top findings across QA and review, grouped by theme]

## Recommendations
[If FAILED: exactly what to fix, in priority order]
[If PASSED: non-blocking notes worth considering]
```

If FAILED - be specific. The user should know exactly what to fix and in what order: the problem, the file or artifact, and the fix. No vague "consider improving X".

If PASSED - keep it short. Highlight the non-blocking notes worth considering, but don't turn a passing review into a lecture.
