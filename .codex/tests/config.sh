#!/usr/bin/env bash
set -euo pipefail

# Read-only configuration checks. No model calls, provisioning, or installs.
python3 - "$(dirname -- "${BASH_SOURCE[0]}")/.." <<'PY'
from pathlib import Path
import re
import sys
import tomllib

root = Path(sys.argv[1]).resolve()
source = root.parent / '.config/opencode'
config = tomllib.loads((root / 'config.toml').read_text())
assert config['sandbox_mode'] == 'workspace-write'
assert config['approval_policy'] == 'on-request'
assert config['agents']['enabled'] is True
assert 'agents/build.toml' in config['developer_instructions']

roles = {p.stem: tomllib.loads(p.read_text()) for p in (root / 'agents').glob('*.toml')}
expected = {p.stem for p in (source / 'agent').glob('*.md')}
assert set(roles) == expected, (set(roles), expected)
for name, role in roles.items():
    assert role['name'] == name
    assert role['description'] and role['developer_instructions']
    assert role['approval_policy'] == 'on-request'
    assert role['sandbox_mode'] == ('workspace-write' if name in {'build', 'qa'} else 'read-only')
    original = (source / 'agent' / f'{name}.md').read_text()
    model = re.search(r'^model: openai/(.+)$', original, re.MULTILINE)
    assert model and role['model'] == model[1], name

plan = tomllib.loads((root / 'plan.config.toml').read_text())
assert plan['sandbox_mode'] == 'read-only'
assert plan['approval_policy'] == 'on-request'
assert 'agents/plan.toml' in plan['developer_instructions']

skills = {p.parent.name: p for p in (root / 'skills').glob('*/SKILL.md') if p.parent.name != '.system'}
originals = {p.parent.name: p for p in (source / 'skills').glob('*/SKILL.md')}
assert set(skills) == set(originals), (set(skills), set(originals))
for name, path in skills.items():
    text = path.read_text()
    assert text.startswith('---\n') and '\n---\n' in text
    assert f'\nname: {name}\n' in text and '\ndescription: ' in text
    assert f'~/.config/opencode/skills/{name}/SKILL.md' in text
    assert '~/.codex/AGENTS.md' in text
    assert originals[name].is_file()

print(f'PASS: {len(roles)} roles, read-only plan profile, {len(skills)} shared workflows')
PY

repo="$(dirname -- "${BASH_SOURCE[0]}")/../.."
for path in .codex/auth.json .codex/sessions/check .codex/archived_sessions/check .codex/history.jsonl .codex/skills/.system/check; do
  git -C "$repo" check-ignore --quiet "$path"
done
printf '%s\n' 'PASS: auth, active/archived sessions, history, and bundled skills stay ignored'
