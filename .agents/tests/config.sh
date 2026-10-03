#!/usr/bin/env bash
set -euo pipefail

# No model calls, provisioning, installs, or secret reads.
python3 - "$(dirname -- "${BASH_SOURCE[0]}")/.." <<'PY'
from pathlib import Path
import json
import re
import sys
import tomllib

shared = Path(sys.argv[1]).resolve()
repo = shared.parent
expected = {'build', 'plan', 'correctness', 'security', 'qa', 'explore', 'metis', 'oracle', 'prometheus'}
roles = {p.stem: p for p in (shared / 'roles').glob('*.md')}
assert set(roles) == expected, set(roles)
assert (shared / 'PONYTAIL.md').is_file()
for name, path in roles.items():
    assert f'`{name}`' in path.read_text(), name

opencode = json.loads((repo / '.config/opencode/opencode.jsonc').read_text())
assert '~/.agents/PONYTAIL.md' in opencode['instructions']
assert set(opencode['agent']) == expected
assert not list((repo / '.config/opencode/agent').glob('*.md'))
for name, agent in opencode['agent'].items():
    assert agent['prompt'] == f'{{file:~/.agents/roles/{name}.md}}'
    assert agent['mode'] == ('primary' if name in {'build', 'plan'} else 'subagent')
    if name != 'build':
        assert agent['permission'].get('edit', agent['permission'].get('*')) == 'deny'

codex = repo / '.codex'
config = tomllib.loads((codex / 'config.toml').read_text())
assert config['sandbox_mode'] == 'workspace-write'
assert config['approval_policy'] == 'on-request' and config['agents']['enabled'] is True
assert '~/.agents/roles/build.md' in config['developer_instructions']
agents = {p.stem: tomllib.loads(p.read_text()) for p in (codex / 'agents').glob('*.toml')}
assert set(agents) == expected
for name, agent in agents.items():
    assert agent['name'] == name and agent['description']
    assert agent['approval_policy'] == 'on-request'
    assert agent['sandbox_mode'] == ('workspace-write' if name in {'build', 'qa'} else 'read-only')
    assert agent['model'] == opencode['agent'][name]['model'].removeprefix('openai/')
    assert f'~/.agents/roles/{name}.md' in agent['developer_instructions']
    assert '~/.agents/PONYTAIL.md' in agent['developer_instructions']
plan = tomllib.loads((codex / 'plan.config.toml').read_text())
assert plan['sandbox_mode'] == 'read-only' and plan['approval_policy'] == 'on-request'
assert '~/.agents/roles/plan.md' in plan['developer_instructions']

claude = repo / '.claude'
agents = {p.stem: p for p in (claude / 'agents').glob('*.md')}
assert set(agents) == expected
for name, path in agents.items():
    text = path.read_text()
    assert text.startswith('---\n')
    header, body = text[4:].split('\n---\n', 1)
    # These adapters intentionally use only flat, unquoted YAML scalars.
    fields = dict(re.findall(r'^([A-Za-z]+): (.+)$', header, re.MULTILINE))
    assert fields['name'] == name and fields['model'] == 'inherit'
    assert ': ' not in fields['description'] and ' #' not in fields['description']
    assert f'~/.agents/roles/{name}.md' in body and '~/.agents/PONYTAIL.md' in body
    if name not in {'build', 'qa'}:
        tools = {tool.strip() for tool in fields['tools'].split(',')}
        assert not tools.intersection({'Bash', 'PowerShell', 'Edit', 'Write', 'NotebookEdit'})
        assert fields['permissionMode'] == 'plan'
    if name == 'qa':
        assert fields['tools'] == 'Read, Glob, Grep, Bash'
assert json.loads((claude / 'settings.json').read_text())['permissions']['defaultMode'] == 'default'
assert '@~/.agents/PONYTAIL.md' in (claude / 'CLAUDE.md').read_text()
assert (claude / 'skills').is_symlink()
assert (claude / 'skills').resolve() == shared / 'skills'

skills = {p.parent.name: p for p in (shared / 'skills').glob('*/SKILL.md')}
assert len(skills) == 16, len(skills)
for name, path in skills.items():
    text = path.read_text()
    assert text.startswith('---\n') and '\n---\n' in text
    assert f'\nname: {name}\n' in text and '\ndescription: ' in text
assert not list((repo / '.config/opencode/skills').glob('*/SKILL.md'))
assert not [p for p in (codex / 'skills').glob('*/SKILL.md') if p.parent.name != '.system']
print(f'PASS: {len(roles)} shared roles, 3 adapters, {len(skills)} single-source skills')

# Check this deployed installation only when the source checkout is installed.
home_shared = Path.home() / '.agents'
if home_shared.exists() and home_shared.resolve() == shared:
    assert (Path.home() / '.claude/skills').resolve() == shared / 'skills'
    assert (Path.home() / '.claude/agents').resolve() == claude / 'agents'
    print('PASS: global shared-source and Claude discovery links')
PY

repo="$(dirname -- "${BASH_SOURCE[0]}")/../.."
for path in .codex/auth.json .codex/sessions/check .codex/archived_sessions/check .codex/history.jsonl .codex/skills/.system/check .claude/transcripts/check .claude/.credentials.json .claude/projects/check .agents/skills/synced/check; do
  git -C "$repo" check-ignore --quiet "$path"
done
printf '%s\n' 'PASS: Codex/Claude runtime and synced skills stay ignored'
