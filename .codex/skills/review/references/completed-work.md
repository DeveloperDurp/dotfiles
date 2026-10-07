# Completed-work review

Use this reference when reviewing a completed implementation or preparing a significant handoff. Apply the review skill's light/full depth policy; completed-work scope alone does not require a full panel.

## Manual QA owned by the orchestrator

The main session runs or reuses hands-on QA on the real surface. Do not delegate this proof to a reviewer; full-panel QA independently executes repository checks.

Reuse evidence only if it covers the final build and requested behavior. Changes stale the rows they affect; rerun those rows before review. A visual-qa verdict may supply visual QA rows, but does not replace correctness review.

Choose the surface that exercises the user's scenario and retain artifacts:

| Surface | Evidence |
| --- | --- |
| HTTP/API | Real request, status, headers, and body. |
| CLI/TUI | Real PTY interaction and transcript; render terminal layout/color evidence in a browser-based terminal. Text dumps alone do not prove visual layout. |
| Web | Drive the rendered UI with the active client's browser tools; retain an action log and screenshots. Prefer product-native browser tools when available. Static fetches are not browser evidence. |
| Desktop/GUI | Running-app interaction log and screenshots. |
| Library/SDK | Exercise the public API and retain the transcript. |
| Configs, migrations, or generated artifacts | Inspect the resulting artifact and applicable parser/validator output. Do not add tests that merely pin prose. |

For browser work, use task-owned sessions/profiles or the supported attached signed-in session. Never clone, launch against, or clear the user's live profile. Close only task-owned sessions. Missing required browser/device/rendering capability is a blocker, not permission to substitute weaker evidence.

Cover every success criterion, the named happy path, the riskiest relevant edge, and adjacent behavior that the change could break. Scale scenarios to the change; do not invent unrelated requirements.

| Scenario | Exact command/action | Expected | Observed | Verdict | Artifact |
| --- | --- | --- | --- | --- | --- |

No artifact means no PASS. If the application cannot start, record FAIL. If required execution is unavailable, record BLOCKED. Any failed required row stops review before dispatch: report the failure and fix it first. A blocked required row makes review inconclusive; do not claim approval.

## Final correctness gate

Give the reviewer the original goal, constraints, background, target revision/diff, changed paths and neighboring code, relevant history/tracker findings, and the manual QA matrix/artifacts. Include design-system decisions and accepted design/accessibility debt when applicable. Use the adversarial instruction from the review skill.

The correctness reviewer must cover:

1. **Goal completeness:** mark each explicit requirement and supported implied requirement achieved, missed, or partial, with code/artifact evidence.
2. **Constraint compliance:** verify each applicable constraint, including authorization and established contracts.
3. **Behavioral correctness:** trace representative scenarios and relevant boundary, malformed-input, concurrency, and failure cases. For major changes, cover at least three representative scenarios and five applicable edge cases; keep light reviews focused on the changed behavior.
4. **Code quality:** neighboring conventions, typed errors, meaningful tests, resource/performance costs, and API compatibility. Distinguish demonstrated problems from preferences.
5. **Security:** applicable trust boundaries, authorization, injection, secrets, dependencies, and file/network handling. Escalate newly discovered high-risk behavior to the full panel.
6. **Missed context:** respect recorded reasons and update affected callers, tests, docs, and configuration.
7. **QA evidence:** check every matrix artifact and whether it proves its row; identify success criteria without covering evidence.
8. **Scope:** identify unrequested work. Treat preferences or hypothetical future improvements as notes unless they violate an actual constraint.

A blocker must cite a violated goal, constraint, demonstrated defect, or required QA evidence gap and its exact fix. Do not block merely because another design is possible. Return a clean verdict when no qualifying issues remain.

The result must include the correctness verdict and confidence, goal/constraint coverage, artifact audit, located blockers, checked-and-clean scope, and brief non-blocking notes. Combine this with the other required lane verdicts using the review skill's final pass/fail/inconclusive rules.
