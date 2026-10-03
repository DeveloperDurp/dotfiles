# Claude Code configuration

Independent Ponytail rules in `CLAUDE.md`, native agent/tool/model metadata
in `agents/*.md`, role responsibilities in `roles/*.md`, and 16 full skill
directories under `skills/`. These are real copies, not cross-client links.

Agents inherit the session model. Read-only specialists have no shell or
write tools; QA has Bash for checks but must not edit source. The primary
uses build unless the user selects another agent or plan mode.

Use /skill-name to invoke a workflow, including /review for the panel.
Changes here do not update Codex or OpenCode. Restart after configuration
changes. Run `bash ~/.claude/tests/config.sh` for static checks, then use
/context and /skills in Claude Code to verify loading. Claude Code is not
installed on the machine used for this restoration; its loader could not
be exercised. Authentication, transcripts, and runtime files are untouched.
