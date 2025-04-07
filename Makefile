include .env
export

run:
	ansible-playbook ./DesktopAnsible/local.yml -K

devpod:
	ansible-playbook ./DesktopAnsible/local.yml
