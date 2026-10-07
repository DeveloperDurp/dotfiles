# Codex

## Codex workflow contract

- Agent responsibilities live in `~/.codex/roles/<name>.md`. Read the
  selected role before work; it replaces the primary role, not these rules.
- Skills live in `~/.codex/skills/<name>/`. Resolve scripts, references,
  assets, and nested AGENTS.md from that directory. Read a skill before
  following its workflow.
- Tool names and delegation examples in skills describe operations,
  not a requirement to use a particular client. Apply the active client's
  tool bindings. Never invent tools or silently skip required capabilities.
- Spawn independent work before waiting. Preserve each task's role, scope,
  output contract, and approval gates. Use only available agent types.
- A specialist without a question tool returns the decision to its parent.
  The primary asks the user and waits; missing tools do not authorize guesses.
- Missing browser, device, LSP, capture, or rendering tools are blockers when
  the workflow requires them. Static fetches are not browser evidence;
  text search is not symbol diagnostics. Do not install tools without approval.
- Keep existing `.opencode/` project artifact paths used by workflow scripts.
  These are ordinary evidence/plan directories, not shared configuration.
- `$ulw-execute` is not installed. Report a blocker if a workflow requires
  that execution handoff; do not restore or invent it.
- Commit and push cadence applies only when the user explicitly authorized
  those actions for the task, and never on the default branch.
- Tool and sandbox restrictions are client-specific enforcement, not part
  of shared Markdown. Never bypass them with permission overrides or escapes.

## Tool bindings

- Skills are independent local copies. Invoke with `$skill-name` or /skills.
  `$review [focus]` uses one reviewer for routine changes and the full panel
  for high-risk changes or an explicit full-panel request. Codex's built-in
  /review differs.
- Delegate with spawn_agent using the named agent type and message. Use
  wait, send_input, and close_agent to collect results, continue a reviewer,
  and release threads. Generic work uses default.
- Clarify with request_user_input when available; otherwise ask in your
  response and stop. Track work with update_plan.
- Use read/search commands when dedicated file tools are absent; edit with
  apply_patch. Explore may use only read/search commands, never tests,
  builds, repository scripts, or mutations.
- Research with native web search/open and inspect images with view_image
  when available. Other capabilities require actual session tools.
- Read-only roles must not request write escalation. QA may generate build
  outputs but must not edit source. Live overrides can supersede sandbox
  defaults; do not use them to bypass role restrictions.
