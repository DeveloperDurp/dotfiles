#!/usr/bin/env bash
set -euo pipefail
python3 - "$(dirname -- "${BASH_SOURCE[0]}")/.." <<'PY'
from pathlib import Path
import re
import sys
import tomllib

root = Path(sys.argv[1]).resolve()
expected = {'build', 'plan', 'correctness', 'security', 'qa', 'explore', 'metis', 'oracle', 'prometheus', 'visual_qa'}
config = tomllib.loads((root / 'config.toml').read_text())
assert config['sandbox_mode'] == 'workspace-write'
assert config['approval_policy'] == 'on-request' and config['agents']['enabled'] is True
assert '~/.codex/roles/build.md' in config['developer_instructions']
agents = {p.stem: tomllib.loads(p.read_text()) for p in (root / 'agents').glob('*.toml')}
assert set(agents) == expected
assert {p.stem for p in (root / 'roles').glob('*.md')} == expected
for name, agent in agents.items():
    assert agent['name'] == name and agent['description']
    assert agent['approval_policy'] == 'on-request'
    assert agent['sandbox_mode'] == ('workspace-write' if name in {'build', 'qa'} else 'read-only')
    assert f'~/.codex/roles/{name}.md' in agent['developer_instructions']
    assert (root / 'roles' / f'{name}.md').is_file()
assert agents['qa']['model'] == 'gpt-6-luna'
assert agents['qa']['model_reasoning_effort'] == 'low'
for name in ('plan', 'visual_qa'):
    assert agents[name]['model'] == 'gpt-6.1-sol'
    assert agents[name]['model_reasoning_effort'] == 'medium'
plan = tomllib.loads((root / 'plan.config.toml').read_text())
assert plan['model'] == agents['plan']['model']
assert plan['model_reasoning_effort'] == agents['plan']['model_reasoning_effort']
assert plan['sandbox_mode'] == 'read-only' and plan['approval_policy'] == 'on-request'
assert '~/.codex/roles/plan.md' in plan['developer_instructions']
visual_skill = (root / 'skills/visual-qa/SKILL.md').read_text()
assert visual_skill.count('task(subagent_type="visual_qa",') == 2
assert 'subagent_type="general"' not in visual_skill
skills = [p for p in (root / 'skills').glob('*/SKILL.md') if p.parent.name != '.system']
expected_skills = {'alpinejs', 'debugging', 'frontend', 'git-master', 'pr-plan', 'programming', 'refactor', 'remove-ai-slops', 'review', 'ultimate-browsing', 'visual-qa'}
assert {p.parent.name for p in skills} == expected_skills
for skill in skills:
    assert not skill.parent.is_symlink()
    text = skill.read_text()
    assert text.startswith('---\n') and f'\nname: {skill.parent.name}\n' in text and '\ndescription: ' in text
    for target in re.findall(r'\[[^\]]+\]\(([^\s)]+)\)', text):
        if '://' in target or target.startswith('#'):
            continue
        reference = target.split('#', 1)[0]
        assert (skill.parent / reference).exists(), (skill, target)
for path in [root / 'AGENTS.md', root / 'config.toml', root / 'plan.config.toml', *list((root / 'agents').glob('*.toml')), *list((root / 'roles').glob('*.md'))]:
    assert '~/.agents/' not in path.read_text(), path
print(f'PASS: Codex has 10 local roles, safe profiles, and {len(skills)} independent skills')
PY
repo="$(dirname -- "${BASH_SOURCE[0]}")/../.."
for filename in .codex/auth.json .codex/sessions/check .codex/history.jsonl .codex/skills/.system/check .codex/skills/frontend/node_modules/check; do
  git -C "$repo" check-ignore --quiet "$filename"
done
printf '%s\n' 'PASS: Codex auth, sessions, bundled skills, and dependency caches remain ignored'
