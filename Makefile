include .env
export

run:
	ansible-playbook ./ansible/local.yml -K
