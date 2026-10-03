# OpenCode adapter

Follow `~/.agents/PONYTAIL.md`, loaded through `opencode.jsonc` instructions.
Role prompts are loaded from `~/.agents/roles/<agent-name>.md` through the
agent configuration's file references.

## Tool bindings

- Delegate with `task` using `subagent_type` and `prompt`; generic work uses
  `general`. Dispatch independent calls together and use their returned
  results. Resume a delegated session with its task_id when supported.
- Clarify with `question`; track work with `todowrite`.
- Read/search with read/glob/grep; edit with apply_patch/edit/write.
- Research with websearch/webfetch when available. LSP/browser/device/image
  operations require the actual tools exposed by this session.
- `/review [focus]` runs the shared review skill through the existing command.
- Model routing and permission rules stay in OpenCode's agent configuration.
  Shared role text never expands the allowed tool surface.
