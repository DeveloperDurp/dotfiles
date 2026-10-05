#!/usr/bin/env bash
set -euo pipefail
python3 - "$(dirname -- "${BASH_SOURCE[0]}")/.." <<'PY'
from pathlib import Path
import json
import re
import sys

root = Path(sys.argv[1]).resolve()
expected = {'build', 'plan', 'correctness', 'security', 'qa', 'explore', 'metis', 'oracle', 'prometheus', 'visual_qa'}
config = json.loads((root / 'opencode.jsonc').read_text())
assert config['$schema'] == 'https://opencode.ai/config.json'
assert config['model'] == 'opencode-go/glm-5.3-flash'
assert config['small_model'] == config['model']
assert 'agent' not in config and 'instructions' not in config
agents = {p.stem: p for p in (root / 'agent').glob('*.md')}
assert set(agents) == expected
for name, path in agents.items():
    text = path.read_text()
    assert text.startswith('---\n')
    header, body = text[4:].split('\n---\n', 1)
    mode = re.search(r'^mode: (.+)$', header, re.MULTILINE)[1]
    assert mode == ('primary' if name in {'build', 'plan'} else 'subagent')
    assert re.search(r'^model: opencode-go/glm-5\.3-flash$', header, re.MULTILINE)
    assert f'`{name}`' in body and '~/.agents/' not in text
    if name != 'build':
        assert '  edit: deny' in header or '  "*": deny' in header
visual_skill = (root / 'skills/visual-qa/SKILL.md').read_text()
assert visual_skill.count('task(subagent_type="visual_qa",') == 3
assert 'subagent_type="general"' not in visual_skill
skills = list((root / 'skills').glob('*/SKILL.md'))
assert len(skills) == 16
for skill in skills:
    assert not skill.parent.is_symlink()
    text = skill.read_text()
    assert text.startswith('---\n') and f'\nname: {skill.parent.name}\n' in text and '\ndescription: ' in text
assert '~/.agents/' not in (root / 'AGENTS.md').read_text()
assert (root / 'command/review.md').is_file()
print('PASS: OpenCode native Markdown layout, 10 inline roles, 16 independent skills')
PY
repo="$(dirname -- "${BASH_SOURCE[0]}")/../../.."
git -C "$repo" check-ignore --quiet .config/opencode/skills/frontend/node_modules/check
printf '%s\n' 'PASS: OpenCode skill dependency caches remain ignored'
