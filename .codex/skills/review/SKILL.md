---
name: review
description: Merge-gate review using parallel correctness, security, and QA agents. Use for reviewing changes or pre-merge checks, not planning or implementation.
---

Read `~/.config/opencode/skills/review/SKILL.md` and follow that workflow with the Codex bindings in `~/.codex/AGENTS.md`. Resolve all resources and nested instructions relative to that source directory.

This also ports the OpenCode review command: use `$review` followed by optional reviewer focus areas. Carry those areas into the blind reviewer prompts. Do not use Codex's built-in `/review` as a substitute for this three-agent workflow.
