# Codex configuration

This client owns independent copies of its Ponytail rules, ten roles,
and 16 skill directories. There are no references or links to other clients.

- Global rules and tool bindings: `AGENTS.md`.
- Role responsibilities: `roles/*.md`.
- Native model/sandbox/approval metadata: `agents/*.toml`.
- Workflows, scripts, references, assets, and licenses: `skills/`.

Use `codex` for build, `codex -p plan` for read-only planning, and `$review`
for the three-agent panel. Codex's built-in /review is a different workflow.
Model choices and safe sandbox defaults are unchanged. Runtime auth,
sessions, databases, and bundled system skills are not part of the copies.

Edit this client's copy to change its behavior; updates do not propagate to
OpenCode or Claude. Restart after configuration changes. Run
`bash ~/.codex/tests/config.sh` for checks and `codex -p plan debug prompt-input`
for discovery/profile inspection without a model call.
