include .env
export

ANSIBLE_REPO ?= https://gitlab.durp.info/durp/home-ansible.git
ANSIBLE_DIR  ?= /home/user/.dotfiles/ansible

.PHONY: ansible-pull
ansible-pull:
	@if [ ! -d "$(ANSIBLE_DIR)" ]; then \
		echo "==> Cloning $(ANSIBLE_REPO) to $(ANSIBLE_DIR)"; \
		git clone $(ANSIBLE_REPO) $(ANSIBLE_DIR); \
	else \
		echo "==> Updating $(ANSIBLE_DIR)"; \
		git -C $(ANSIBLE_DIR) pull --rebase --autostash; \
	fi

.PHONY: run security update devpod

run: ansible-pull
	ansible-playbook $(ANSIBLE_DIR)/local.yml -K

security: ansible-pull
	ansible-playbook $(ANSIBLE_DIR)/security.yml -K

update: ansible-pull
	ansible-playbook $(ANSIBLE_DIR)/update.yml -K

devpod: ansible-pull
	ansible-playbook $(ANSIBLE_DIR)/devpod.yml
