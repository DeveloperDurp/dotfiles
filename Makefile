include .env
export

run:
	ansible-playbook ./ansible/local.yml -K

devpod:
	ansible-playbook ./ansible/local.yml
