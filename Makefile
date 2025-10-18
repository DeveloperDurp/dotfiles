include .env
export

run:
	ansible-playbook ./ansible/local.yml -K

update:
	ansible-playbook ./ansible/update.yml -K

devpod:
	ansible-playbook ./ansible/devpod.yml
