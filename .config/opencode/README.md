# OpenCode configuration

Restored native layout: global Ponytail rules in `AGENTS.md`, complete role
prompts with model/permission frontmatter in `agent/*.md`, and independent
workflows/resources in `skills/`. `opencode.jsonc` contains only the schema
and existing default/small model settings. No shared-file interpolation.

All nine roles, 16 workflows, issue-to-PR support, and the incoming Alpine
component docs are retained. Other clients own separate copies; changes
here do not update them. The existing /review command is unchanged.

OpenCode also discovers Claude skills automatically. Its native local skill
definitions take precedence. For strict native-only discovery, launch with
`OPENCODE_DISABLE_EXTERNAL_SKILLS=1 opencode`. This flag does not change
models or permissions.

Quit and restart OpenCode after configuration changes. Check with
`bash ~/.config/opencode/tests/config.sh`, `opencode --pure debug agent build`,
and `opencode --pure debug skill`. No clients, packages, MCP servers, or
browser/device/LSP tools are installed by this restoration.
