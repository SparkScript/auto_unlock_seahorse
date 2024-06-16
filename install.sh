#!/bin/bash

install_dotool () {
	echo load 'dotool' from repository
	git clone https://git.sr.ht/~geb/dotool
	cd dotool
	./build.sh
	echo install dotool needs sudo
	sudo ./build.sh install
	sudo groupadd -f input
	sudo usermod -a -G input $USER
}

install_nitropy () {
	python3 -m pip install --user pipx
	python3 -m pipx ensurepath
	pipx install pynitrokey
}


git_exec=$(command -v git)
if [ -z "$git_exec" ]; then
	echo git not found, aborting
	exit 1
fi



dotool_exec=$(command -v dotool)
if [ -z "$dotool_exec" ]; then
	install_dotool
fi

nitropy_exec=$(command -v nitropy)
if [ -z "$nitropy_exec" ]; then
	install_nitropy
fi

