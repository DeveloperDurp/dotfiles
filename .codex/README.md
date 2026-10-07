# Codex configuration

This client owns independent copies of its Ponytail rules, ten roles,
and 11 skill directories. There are no references or links to other clients.

- Global rules and tool bindings: `AGENTS.md`.
- Role responsibilities: `roles/*.md`.
- Native model/sandbox/approval metadata: `agents/*.toml`.
- Workflows, scripts, references, assets, and licenses: `skills/`.

Use `codex` for build, `codex -p plan` for read-only planning, and `$review`
for one routine reviewer or the full panel on major or high-risk changes. An explicit
full-panel request uses all three reviewers. Codex's built-in /review is a
different workflow. QA uses GPT-6 Luna with low reasoning; planning and
visual QA use GPT-6.1 Sol with medium reasoning. Safe sandbox defaults are
unchanged. Runtime auth,
sessions, databases, and bundled system skills are not part of the copies.

Edit this client's copy to change its behavior; updates do not propagate to
OpenCode or Claude. Restart after configuration changes. Run
`bash ~/.codex/tests/config.sh` for checks and `codex -p plan debug prompt-input`
for discovery/profile inspection without a model call.
