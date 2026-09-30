---
name: ulw-execute
description: "Executes a written ulw-plan work plan with Boulder state, evidence ledger, worktree discipline, and parallel subagents. Use when the user says ulw-execute or asks to run a .opencode/plans plan."
---

## ABSOLUTE RULE: YOU ARE AN ORCHESTRATOR — NEVER THE IMPLEMENTER

**YOU DO NOT WRITE CODE. YOU DO NOT EDIT PRODUCT FILES. YOU DO NOT RUN QA YOURSELF. EVERY unit of implementation, test, QA, and review work MUST be delegated to a spawned subagent. NO EXCEPTIONS.** Your hands touch only plan selection, `.opencode/` state (Boulder, ledger, plan checkboxes), decomposition, dispatch, verdicts, and evidence records. About to edit a product file or run an implementation command yourself? **STOP. SPAWN A WORKER INSTEAD.** Orchestrate at **MAXIMUM PARALLELISM**: every independent unit runs concurrently; only named dependencies serialize.

## Spawning workers (OpenCode)

Dispatch independent subagents with native `task` calls (`subagent_type`) in
one turn and use the returned results directly. Every spawned message is a self-contained executable assignment:
`TASK: <imperative assignment>`, then `DELIVERABLE`, `SCOPE`, and `VERIFY`, with
role instructions inside the prompt. Paste only the context the worker needs.
Workers are leaf agents: they never spawn their own subagents.

# ulw-execute

Execute a work plan until every top-level checkbox is complete. When a session ends with unchecked plan work, re-invoke this skill: Phase 1 reads `.opencode/boulder.json` and resumes the recorded work.

## Usage

```text
$ulw-execute [plan-name] [--worktree <absolute-path>] [--make-pr] [--ship]
```

- `plan-name` (optional): a full or partial file stem under `.opencode/plans/`.
- `--worktree` (optional): reuse an existing task-owned worktree for the first phase instead of creating one; every phase runs in a task-owned worktree regardless.
- `--make-pr` (optional): deliver each phase's worktree as a pull request — push the branch, open a reviewer-readable PR, hand off with the URL, and merge only if the user asks.
- `--ship` (optional): full delivery preparation; implies `--make-pr`. After the PR opens, stay on the job until it is merge-ready: watch CI and review gates, fix failures and address feedback from the worktree (fresh QA evidence for behavior changes), then stop — the user merges. Sync `.opencode/` state back and remove the worktree after explicit handoff.

## Goal and todo discipline (MANDATORY)

Do ALL of this immediately after the plan is selected, BEFORE the first implementation dispatch. Skipping any step is a defect.

1. **Set the goal, in detail.** Record a DETAILED objective: the plan name and path, the concrete end state, the phase and task counts, the delivery mode (direct, `--make-pr`, or `--ship`), and how completion will be verified. One work session = one goal; each phase then carries its own concrete goal — the ledger entry Phase 2 records before the wave's first dispatch, defined from the previous phase's landed and verified evidence. No goal tool -> record the same objective as the first ledger entry.
2. **Register every phase and task as todos.** Mirror the plan into the todo/plan tool of your harness: one phase per plan wave, one todo per column-zero checkbox (including the final verification wave). Register ALL of them up front - never keep tasks in memory only.
3. **Keep them current at every moment.** Mark a todo in_progress when its work dispatches and done immediately after its verification passes. Never batch-complete at the end, never execute work that is not a registered todo; discovered work — a pre-existing bug, failing test, stale doc, or wrong guidance — is appended to the plan as a checkbox, mirrored as a todo before it runs, and fixed to the ideal state, never deferred as a follow-up. A worker that meets a defect outside its assigned files reports it instead of fixing it; only the orchestrator appends the checkbox and dispatches it to a correctly scoped unit. The todo list, Boulder state, and plan checkboxes must always tell the same story.

## Phase 1: Select the plan

1. Read `.opencode/boulder.json` if it exists.
2. List work plan files under `.opencode/plans/`.
3. If `plan-name` was provided, select the matching plan.
4. If exactly one active or paused Boulder work exists for this session, resume it.
5. If no active work exists and exactly one plan exists, select it.
6. If no active work exists and there is no selectable plan, enter **No-plan bootstrap**.
7. If multiple plans remain possible, ask one focused selection question.

### No-plan bootstrap

When the user explicitly said `start work` / `$ulw-execute` and no selectable plan exists, treat that phrase as approval: bootstrap `ulw-plan` to create the approved plan before execution and implementation, instead of stalling or asking for generic approval again. A brief or notes file without waves, checkboxes, and acceptance criteria is NOT decision-complete — enter this bootstrap too.

1. Invoke the `ulw-plan` skill from the current request and require its dynamic adversarial workflow: collect, verify, design, adversarial plan-review, synthesize.
2. The generated work plan must be saved under `.opencode/plans/<slug>.md` before implementation or Boulder state writes that point at plan work.
3. Use maximum safe parallelism in the generated plan: independent files/tasks fan out; same-file writes, shared state, and named dependencies serialize.
4. Preserve safety boundaries. Ask one focused question only when the objective is missing, destructive, or has a safety/product ambiguity that repository exploration cannot resolve.
5. After the plan exists, continue directly to Phase 2.

## Phase 2: Create or update Boulder state

Write `.opencode/boulder.json` before implementation starts. Record the real session id in `session_ids`.

```json
{
  "schema_version": 2,
  "active_work_id": "<work-id>",
  "works": {
    "<work-id>": {
      "work_id": "<work-id>",
      "active_plan": ".opencode/plans/<plan-name>.md",
      "plan_name": "<plan-name>",
      "session_ids": ["<session_id>"],
      "status": "active",
      "worktree_path": null
    }
  }
}
```

Every phase (plan wave) runs in its own task-owned worktree with its own goal: before the wave's first dispatch, record the wave's goal — its checkboxes and their acceptance criteria — as a ledger entry, then `git worktree add <repo>-wt/<plan>-<wave> <branch off the integration base>` (or verify a `--worktree` path with `git worktree list --porcelain`), store the absolute path as `worktree_path`, run every edit, command, test, and evidence capture inside it; the wave lands on the integration base once its checkboxes are verified (direct merge, or the PR under `--make-pr`/`--ship`), and the next wave branches from that landed base.

## Parallel delivery lanes (teams and worktrees)

Solo orchestration with parallel task calls is the default topology. Decide once, when the wave's lanes are known, and record the verdict in the ledger:

- **Independent lanes -> parallel workers.** Separate files, no shared contract: one parallel spawn burst; no team.
- **Dependency-ordered lanes -> serialize.** Sub-tasks with real ordering between them (C needs A and B finished first): dispatch in dependency order, one lane at a time; a lane starts only when its blockers' gates pass.
- **Overlapping lanes -> serialize or split.** The lanes touch the same module or contract: reorder them sequentially, or split the shared surface so the lanes stop overlapping.
- **PR-mode independent lanes -> a worktree per lane.** Under `--make-pr`/`--ship`, when a wave holds independent checkboxes, give each lane its own branch and task-owned worktree, delivered as its own PR.

Landing rules, regardless of topology:

- **Merge per verified unit.** A lane lands the moment its own gates pass — it never waits for the slowest sibling. Integrate landed work back into the base the remaining lanes branch from.
- **Only the user merges.** Workers never merge and never push the base branch; the orchestrator lands work on the working branch and stops at the merge gate.
- **Conflicts are the orchestrator's job.** Decide the landing order and tell the later lane what changed; a worker never resolves a sibling's conflict blind.

## Phase 3: Execute the next checkbox

1. Read the full selected plan.
2. Find the first unchecked column-0 checkbox in `## TODOs` or `## Final Verification Wave`.
3. Ignore nested checkboxes under acceptance criteria, evidence, and definition-of-done sections.
4. Classify the checkbox tier and record it in its ledger entry. Default is LIGHT — a narrow change inside existing layers. Take HEAVY only on a fact you can point to: a new module / abstraction / domain model; auth, security, or session; an external integration; a DB schema or migration; concurrency or transaction boundaries; a cross-domain refactor; or the plan or user signals care. When unsure, take HEAVY; upgrade and redo skipped gates the moment a HEAVY fact surfaces; never downgrade.
5. Decompose that checkbox into atomic sub-tasks sized for ONE worker in ONE run — a sub-task that would need mid-flight steering is two sub-tasks. Collect every other unchecked checkbox in the same plan wave whose dependencies are met — their lanes execute concurrently. A wave that could split further but holds fewer than 3 independent sub-tasks is under-split.
6. **DELEGATE EVERYTHING. YOU NEVER IMPLEMENT.** Route every sub-task through the delegation router below, then dispatch ALL independent sub-tasks across those checkboxes in one parallel worker-spawn burst (a single batched spawn call where the harness supports it); route named dependencies per the lane-topology decision above. Verification and checkbox marking stay per-checkbox.
7. Give every dispatched sub-task its completion condition and watch for it per the section below. A dispatch whose completion nobody watches is an unfinished dispatch.

### Monitor every dispatched subagent to its completion condition

A spawned worker is not fire-and-forget. For EACH subagent in the burst, name the observable state that ends its lane — the file written, the PR opened, the checkbox's gates green — and verify THAT state when collecting results.

- **Use task returns, not polling.** Dispatch independent calls in one turn, then inspect each returned result before advancing the wave. Never treat a missing deliverable as a pass.
- **External completion conditions** (CI green, a log line, a build artifact appearing): record the condition in the ledger at dispatch time and verify it explicitly when collecting the lane's results.
- **Tear stale state down.** If a lane's completion condition can never fire (wrong path, impossible pattern), record the mis-set condition in the ledger and re-dispatch that lane correctly. Never treat silence as a pass.
- **Then advance.** Verified evidence means that lane's gates run and its checkbox closes. Never let a dead lane hold the run open.

### Delegation router — recommended task executor

When the plan annotates a todo with `Recommended task executor category:`, route implementation categories (`quick`, `unspecified-low`, `unspecified-high`, `visual-engineering`, `writing`, `git`, `deep-low`, `deep-high`, `deep`, `ultrabrain`) to `general`. Use `explore` for read-only codebase mapping and the reviewer roles below for independent gates. Record any deviation in the ledger entry. Otherwise route by shape:

| Role | Route here |
| --- | --- |
| `explore` | read-only mapping: internal patterns, conventions, tests, file finding |
| `general` | implementation and hard-reasoning workers — the default executor for every implementation or QA sub-task |
| `correctness` | independent logic/test-adequacy review of a landed sub-task |
| `security` | independent security review when the sub-task touches boundaries, secrets, auth, or infra |
| `qa` | independent execution of the repo's test/build commands for raw evidence |

Sizing is a two-branch decision made per checkbox, before dispatch:

- **Splittable work splits.** When the checkbox decomposes into independent pieces, dispatch them as one parallel burst of `general` workers — many small workers in parallel beat one large delegation.
- **Cohesive hard work stays whole.** When splitting would sever shared reasoning (one algorithm, one migration, one subtle bug), send the WHOLE problem to `general` as ONE delegation. Never force-split work whose parts share one insight.

Each sub-task message must include:

1. Goal and exact files or directories in scope.
2. The tests already covering the touched behavior, READ before any edit as the behavior of record (intent, coverage, pass); a bug's reproduction captured before the fix. A new test ONLY where the repository keeps tests for this behavior AND a regression would otherwise pass unnoticed by the sub-task's Manual-QA scenario — never one that mirrors its implementation (mock-call assertions, pinned constants) or restates the change.
3. Implementation constraints from the plan and project rules.
4. Automated verification commands to run.
5. One Manual-QA channel, named with the exact tool and exact invocation (the literal `curl`, `send-keys`, `page.click` / `session.click`, payload, selectors, and the binary observable that decides PASS/FAIL), not "verify it works". A LIGHT checkbox needs one real-surface proof of its deliverable, and auxiliary surfaces (CLI stdout, DB state diff, parsed config dump) are first-class when the surface is CLI- or data-shaped:
   - HTTP call: `curl -i` against the live endpoint.
   - Terminal / TUI: drive a real pty; `tmux send-keys` is fine for a boot/behavior smoke, but color/layout/CJK evidence goes through the xterm.js web terminal below, NEVER `tmux capture-pane`.
   - Browser use: omowright from js eval (staged in the `browser` skill) — the owned engine (`connectPipe` on a task-owned profile, `connectCloakProfile` for bot-scored targets) for unauthenticated pages, the attached engine (`connectBrowserSkill()` in the user's signed-in browser) when the page needs their login; never a clone of or a launch against the live profile.
   - Computer use: OS-level GUI automation against the running desktop app when the surface is not a page.
   - TUI visual evidence: when a TUI claim needs visual QA or PR proof, run the `visual-qa` skill's script (`scripts/visual-qa.mjs`) and attach the terminal artifact it emits.
6. The adversarial classes that apply to this sub-task (from the 9 ultraqa classes) and how each is probed.
7. Required artifact path and cleanup receipt.
8. Tool-use expectations: batch independent tool calls in parallel; when the harness exposes a code-execution surface (eval), use it for multi-call steps instead of one-by-one calls.

The 9 ultraqa classes are trigger-mapped: new input parsing → malformed input; untrusted external text → prompt injection; resumable or long-running flows → cancel/resume; generated or cached artifacts → stale state; uncommitted user files in scope → dirty worktree; long external commands → hung or long commands; new or timing-sensitive tests → flaky tests; log-based success claims → misleading success output; mid-operation interrupts → repeated interruptions. A class applies when its trigger fact holds. Probe each applicable class; record the rest as not-applicable with a one-line reason.

## Phase 4: Verify and record evidence

For each checkbox, complete all five gates before marking it done:

1. Plan reread: confirm the checkbox and acceptance criteria.
2. Automated verification: run tests, typecheck, lint, build, or the plan-specific equivalent.
3. Manual-QA channel: capture a real artifact, not a dry-run claim.
4. Adversarial QA: exercise every class the Phase 3 trigger map marks applicable and capture the observable result for each.
5. Cleanup: register every QA resource teardown as its own todo when spawned (QA scripts, tmux assets, browser sessions, PIDs, ports, containers, temp dirs), execute each, and capture the receipt. No QA asset is left running.

Append evidence to `.opencode/ulw-execute/ledger.jsonl`, one JSON object per line. Include at least `event`, `plan`, `task`, `session_id`, `commands`, `artifact`, `adversarial_classes`, and `cleanup` fields. `adversarial_classes` lists each probed class with its observable result and each ruled-out class with a one-line reason.

### Completion contract

A worker done claim is never final: each implementation sub-task returns a `DoneClaim`, a different context runs `AdversarialVerify` probing or reproducing the claim, failures loop back to the executor, and only a confirmed verifier verdict becomes `FullyDone`.

```json
{
  "DoneClaim": {
    "task": "<task id/title>",
    "changed_files": ["path"],
    "tests": ["exact command + result"],
    "manual_qa": ["artifact path"],
    "cleanup": ["receipt"],
    "risks": ["known risk or none"]
  },
  "AdversarialVerify": {
    "verdict": "confirmed | false-positive | needs-fix | needs-human-review",
    "evidence": ["file path, command, log, artifact, or explicit not inspected"],
    "repro": "exact command or manual steps when available",
    "confidence": 0.0
  }
}
```

Rules:
- `confirmed` is the only pass verdict. `false-positive`, `needs-fix`, and `needs-human-review` all block checkbox completion.
- The verifier must be independent from the executor: dispatch the `correctness` subagent (or a fresh `general` reviewer) — never the worker that did the task, and not root when root implemented or materially rewrote it.
- A worker done claim must be independently verified before it becomes checkbox completion.
- On any non-confirmed verdict, append the feedback to the ledger, reset the checkbox work to in-progress, and re-dispatch the executor with the exact failure.
- The verifier must probe the applicable adversarial keys, including `stale_state`, `dirty_worktree`, and `misleading_success_output`, before allowing `FullyDone`.

## Phase 5: Mark progress

Only after verification passes:

1. Edit the plan checkbox from `- [ ]` to `- [x]`.
2. Re-read the plan and confirm the remaining count decreased.
3. Append a `task-completed` ledger entry.
4. Continue with the next checkbox. Do not ask whether to continue.

## Completion

When all top-level checkboxes in `## TODOs` and `## Final Verification Wave` are complete:

1. Run the plan's final verification commands.
2. For PR/branch work, finish the lifecycle from the last phase's worktree: sync `.opencode/` state back to the main repo, create or update the PR, wait for CI and review gates, then STOP — the user merges. Remove the worktree only after successful merge or explicit handoff.
3. Remove or mark the Boulder work as completed.
4. Print an `ORCHESTRATION COMPLETE` block with the plan path, verification commands, artifacts, and cleanup receipts.

## Hard rules

- No production change before the tests covering that behavior were read and a bug's reproduction captured; existing tests are green on the unchanged code first, and one that contradicts the intent is a FINDING, never edited green.
- No `--dry-run` as completion evidence.
- No tests-only completion claim. A Manual-QA artifact is required.
- **NO DIRECT IMPLEMENTATION BY THE ORCHESTRATOR.** Root NEVER edits product files, writes tests, or runs QA itself — a spawned worker does.
- No completion claim while an applicable ultraqa adversarial class was never probed. Each applicable class needs a captured observable result; each skipped class needs a one-line not-applicable reason in the ledger.
- No implementation, review, or merge in the main checkout; every phase works in its task-owned worktree.
- Boulder state records the real session id.
- No stale-memory execution. The plan and ledger are the durable source of truth.
