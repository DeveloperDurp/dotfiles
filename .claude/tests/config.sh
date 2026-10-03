#!/usr/bin/env bash
set -euo pipefail
python3 - "$(dirname -- "${BASH_SOURCE[0]}")/.." <<'PY'
from pathlib import Path
import json
import re
import sys

root = Path(sys.argv[1]).resolve()
expected = {'build', 'plan', 'correctness', 'security', 'qa', 'explore', 'metis', 'oracle', 'prometheus'}
agents = {p.stem: p for p in (root / 'agents').glob('*.md')}
assert set(agents) == expected
assert {p.stem for p in (root / 'roles').glob('*.md')} == expected
for name, path in agents.items():
    text = path.read_text()
    assert text.startswith('---\n')
    header, body = text[4:].split('\n---\n', 1)
    fields = dict(re.findall(r'^([A-Za-z]+): (.+)$', header, re.MULTILINE))
    assert fields['name'] == name and fields['model'] == 'inherit'
    assert f'~/.claude/roles/{name}.md' in body and '~/.agents/' not in text
    if name not in {'build', 'qa'}:
        tools = {tool.strip() for tool in fields['tools'].split(',')}
        assert not tools.intersection({'Bash', 'PowerShell', 'Edit', 'Write', 'NotebookEdit'})
        assert fields['permissionMode'] == 'plan'
    if name == 'qa':
        assert fields['tools'] == 'Read, Glob, Grep, Bash'
assert json.loads((root / 'settings.json').read_text())['permissions']['defaultMode'] == 'default'
assert not (root / 'skills').is_symlink()
skills = list((root / 'skills').glob('*/SKILL.md'))
assert len(skills) == 16
for skill in skills:
    assert not skill.parent.is_symlink()
    text = skill.read_text()
    assert text.startswith('---\n') and f'\nname: {skill.parent.name}\n' in text and '\ndescription: ' in text
for path in [root / 'CLAUDE.md', *list((root / 'roles').glob('*.md'))]:
    assert '~/.agents/' not in path.read_text(), path
print('PASS: Claude has 9 local roles, restricted tools, and 16 independent skills')
PY
repo="$(dirname -- "${BASH_SOURCE[0]}")/../.."
for filename in .claude/.credentials.json .claude/transcripts/check .claude/projects/check .claude/skills/synced/check .claude/skills/frontend/node_modules/check; do
  git -C "$repo" check-ignore --quiet "$filename"
done
printf '%s\n' 'PASS: Claude runtime, synced skills, and dependency caches remain ignored'
