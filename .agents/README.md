# Shared agent configuration

One source of truth for Codex CLI, Claude Code, and OpenCode:

- `PONYTAIL.md`: global rules and portable workflow contract.
- `roles/*.md`: nine agent responsibilities. Edit these, not adapter prompts.
- `skills/*/`: 16 skills with their scripts, references, assets, and licenses.

GNU Stow exposes this tree as `~/.agents`. Codex and OpenCode discover its
skills directly. `.claude/skills` is a relative directory symlink to the same
source, so adding a shared skill makes it available to all three clients.
There are no Codex skill wrappers or duplicate OpenCode skill sources.

## Adapters

| Client | Global instructions | Agent metadata | Invocation |
| --- | --- | --- | --- |
| Codex | `~/.codex/AGENTS.md` tells the agent to read Ponytail | `~/.codex/agents/*.toml` | `codex`, `codex -p plan`, `$review` |
| Claude Code | `~/.claude/CLAUDE.md` imports Ponytail | `~/.claude/agents/*.md` | `claude`, `claude --agent plan`, `/review` |
| OpenCode | `opencode.jsonc` loads Ponytail | `opencode.jsonc` agent entries import role files | `opencode`, select plan, `/review` |

Codex and Claude agent adapters instruct the model to read the matching
shared role. OpenCode expands `{file:~/.agents/roles/<name>.md}` when it loads
configuration. Restart all clients after changes to adapters/global rules.

Models and permissions deliberately remain client-specific. Codex and
OpenCode retain their previous OpenAI role models. Claude agents inherit
the current Claude session model; no paid model selection is forced.
Claude's read-only specialists have no shell or source-write tools, so the
primary supplies diff/command evidence. Codex uses read-only sandboxes for
those roles. QA can execute tests but must not edit source; shell access
does not enforce that distinction by itself.

Legacy tool-name examples inside skill references are operation descriptions,
translated by each adapter. Existing `.opencode/` evidence/plan paths are
retained because the scripts validate them. Required missing capabilities
must be reported as blockers. This setup installs no clients, MCP servers,
browser/device/LSP tools, or packages. It targets local CLI sessions, not
Claude Cowork or cloud skill distribution.

## Deployment and checks

Use the repository's normal Ansible/Stow provisioning path on another
machine. For the current machine, the new `.agents` and `.claude` links were
applied with a filtered Stow run after a dry run; existing Claude transcripts
and Codex runtime data were left untouched. No adopt or reset is needed.

Run `bash ~/.agents/tests/config.sh` for structure, adapter, skill, link,
and runtime-ignore checks. `bash ~/.codex/tests/config.sh` forwards here.
Client loader checks, without model calls:

```sh
codex -p plan debug prompt-input
opencode --pure debug agent build
opencode --pure debug skill
```

When Claude Code is installed, use `/context` to confirm the Ponytail import
and `/skills` to confirm discovery. Claude Code was not installed on the
machine used to create this configuration; its loader was not exercised.
