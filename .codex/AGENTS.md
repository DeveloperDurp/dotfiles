# Codex adapter

Before starting any task, read and follow `~/.agents/PONYTAIL.md` and the
selected role under `~/.agents/roles/`. This is the shared source of truth.
A selected profile or spawned specialist replaces the primary build role.

## Tool bindings

- Skills load directly from `~/.agents/skills`. Invoke with `$skill-name`
  or `/skills`. `$review [focus]` is the shared three-agent review workflow;
  Codex's built-in `/review` is a different workflow.
- Delegate with `spawn_agent` using the named agent type and message.
  Use `wait`, `send_input`, and `close_agent` to collect results, continue
  a reviewer, and release threads. Generic work uses `default`.
- Clarify with `request_user_input` when available; otherwise ask in your
  response and stop. Track work with `update_plan`.
- Use native read/search commands when dedicated file tools are absent;
  edit with `apply_patch`. Explore may use only read/search commands,
  never tests, builds, repository scripts, or mutations.
- Research with native web search/open, and inspect images with view_image
  when available. Other capabilities require actual session tools.
- Read-only roles must not request write escalation. QA may generate build
  outputs but must not edit source. Live permission overrides can supersede
  sandbox defaults; do not use them to bypass role restrictions.
