# Codex adapter

The shared source now lives in `~/.agents`: global rules in `PONYTAIL.md`,
agent responsibilities in `roles/`, and workflows/resources in `skills/`.
See `~/.agents/README.md` for the three-client layout and compatibility limits.

- `codex`: primary build role.
- `codex -p plan`: read-only primary plan role.
- Ask for explore, correctness, security, qa, metis, oracle, or prometheus
  subagents by name. Build and plan are also available as delegated roles.
- `/skills` lists workflows. `$review [focus]` runs the shared panel, unlike
  Codex's built-in `/review`.

`AGENTS.md` contains only Codex tool bindings and the shared-source loading
instruction. `agents/*.toml` retains model/sandbox/approval configuration,
not copies of role responsibilities. Existing auth, sessions, databases,
and bundled system skills remain separate and ignored. Restart Codex after
changing its adapters.

Run `bash ~/.codex/tests/config.sh` for shared configuration checks, or
`codex -p plan debug prompt-input` to inspect the effective plan instructions,
read-only permissions, and shared skill discovery without a model call.
