# Codex agent structure

Parallel port of `.config/opencode`; OpenCode is unchanged. Codex 0.156.1
loads this tree through the existing `~/.codex` GNU Stow symlink.
Authentication, sessions, databases, bundled system skills, and runtime
metadata stay ignored and are not part of the configuration port.

## Use

- `codex`: primary **build** role.
- `codex -p plan`: read-only primary **plan** role.
- Ask for `explore`, `correctness`, `security`, `qa`, `metis`, `oracle`, or
  `prometheus` subagents by name. Build and plan are also available as
  delegated roles. Codex discovers the standalone `agents/*.toml` files.
- `/skills` lists workflows. Use `$review [focus areas]` for the migrated
  OpenCode review command. Codex's built-in `/review` does not run that panel.

Restart Codex after configuration changes. Existing threads keep their
loaded settings. On another machine, apply these dotfiles through the normal
Ansible/Stow provisioning path. Do not adopt runtime files or reset the
working tree to deploy this configuration.

## Compatibility

The 16 workflow entry points read their shared sources under
`~/.config/opencode/skills/`; this keeps scripts, references, and assets in
one place. Keep that source tree installed. The Codex tool mappings live in
`AGENTS.md`, including parallel delegation, clarification, and artifact
paths. `.codex/skills` is a supported legacy discovery root in 0.156.1;
current Codex documentation recommends `~/.agents/skills` for new setups.

Per-agent OpenAI models are retained without the `openai/` prefix. The main
model follows the OpenCode build role, not the incompatible `opencode-go`
provider default. Model access still depends on the signed-in account.

Build and QA use workspace-write with on-request approvals. Other custom
roles default to read-only. QA may generate test/build outputs but cannot
edit source by its role instructions. Read-only roles must not request a
write escalation. Codex sandbox defaults do not reproduce OpenCode's tool
allowlists, per-command denies, secret-file prompts, or external-directory
rules exactly. Live permission overrides can supersede the defaults.

This port does not install browser/device/LSP tools, MCP servers, plugins,
or packages. Required unavailable tools must be reported as blockers, not
silently skipped. OpenCode's built-in customize-opencode skill has no source
file here and is not included. The removed ulw-execute skill is not restored.

## Check

Run `bash ~/.codex/tests/config.sh` for local TOML, role, profile, and skill
source checks. Run `codex features list` for the installed CLI's configuration
parser. Use `codex -p plan debug prompt-input` to inspect the read-only profile
and discovered skills without starting a model conversation.
