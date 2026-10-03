@~/.agents/PONYTAIL.md

# Claude Code adapter

The primary role is build unless the user selects another agent or plan mode.
Before primary work, read `~/.agents/roles/build.md`; in plan mode read
`~/.agents/roles/plan.md` instead. Custom agents load their own shared role.

## Tool bindings

- Skills load from `~/.claude/skills`, linked to `~/.agents/skills`.
  Invoke with `/skill-name`. `/review [focus]` is the shared panel workflow.
- Delegate with `Agent` using subagent_type, description, and prompt.
  Older Claude Code versions call this tool Task. Generic work uses
  `general-purpose`. Independent calls go in one turn before waiting.
  Use returned results; use the actual background result/resume tools only
  when available. Do not assume Codex or OpenCode session identifiers work.
- Clarify with AskUserQuestion in the primary session; a specialist returns
  decisions to its parent. Track work with TodoWrite or native task tools.
- Read/search with Read, Glob, Grep; edit with Edit/Write. Bash is for actual
  command execution. Read-only specialists do not have Bash or write tools;
  give them diff/output evidence from the primary or QA when necessary.
- Research with WebSearch/WebFetch and inspect images with Read when those
  capabilities are available. Other tools require actual session support.
- Claude models inherit from the session. Model routing and tool allowlists
  live in agent frontmatter, not in shared role prompts.
- Never use bypassPermissions, acceptEdits, or other overrides to bypass
  role restrictions. QA has Bash to run checks but no source-edit tools;
  this does not prevent a shell command from writing files.
