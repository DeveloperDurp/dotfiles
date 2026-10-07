#!/usr/bin/env bash
set -euo pipefail

ansible_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
test_dir=$(mktemp -d)
trap 'rm -rf -- "$test_dir"' EXIT

cat > "$test_dir/update.yml" <<'YAML'
- hosts: localhost
  connection: local
  gather_facts: false
  vars:
    ansible_facts:
      hostname: "{{ test_hostname }}"
      os_family: Test
  roles:
    - update
  tasks:
    - name: Verify host Nix policy is loaded
      ansible.builtin.assert:
        that:
          - (skip_nix | default(false) | bool) == (expected_skip_nix | bool)
YAML

for test_hostname in scout citadel update-test-unknown-host; do
  expected_skip_nix=true
  if [[ $test_hostname == update-test-unknown-host ]]; then
    expected_skip_nix=false
  fi
  ANSIBLE_ROLES_PATH="$ansible_dir/roles" HOMEBREW_NO_AUTO_UPDATE=1 \
    ansible-playbook -i localhost, --check "$test_dir/update.yml" \
      -e "test_hostname=$test_hostname expected_skip_nix=$expected_skip_nix"
done
