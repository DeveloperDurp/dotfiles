include .env
export

run:
	ansible-playbook ./DesktopAnsible/local.yml -K
