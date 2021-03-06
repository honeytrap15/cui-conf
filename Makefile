
NEOVIM_REPO="https://github.com/neovim/neovim.git"

.SILENT:\
	add_backports\
	install_usual\
	install_develop\
	install_nvim_stable\
	setup_neovim

all: add_backports install_usual install_develop install_nvim_stable install_peco

non-root:create_symlink install_choosenim install_pyenv setup_neovim

add_backports:
	echo
	echo "---- add backports repo start ----"
	bash -c "echo deb http://deb.debian.org/debian stretch-backports main >> /etc/apt/sources.list"
	echo "OK"
	echo "---- add backports repo end ----"

install_usual:
	echo
	echo "---- install usual packages start ----"
	apt install -y\
		tig
	echo "---- install usual packages end   ----"

install_develop:
	echo
	echo "---- install depends packages start ----"
	apt install -y\
		automake\
		clang\
		clang-format\
		cmake\
		curl\
		exuberant-ctags \
		libtool\
		m4\
		tmux\
		pkg-config\
		python3\
		python3-pip\
		silversearcher-ag \
		unzip\
		wget\
		xsel \
		zsh
	pip3 install neovim pyflakes
	echo "---- install depends packages end   ----"

install_peco:
	echo
	echo "---- install peco ----"
	wget https://github.com/peco/peco/releases/download/v0.5.3/peco_linux_amd64.tar.gz
	tar zxf peco_linux_amd64.tar.gz
	mv peco_linux_amd64/peco /usr/local/bin
	rm peco_linux_amd64.tar.gz
	rm -rf peco_linux_amd64

install_nvim_stable:
	echo
	echo "---- install neovim ----"
	wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
	tar zxf nvim-linux64.tar.gz
	mv nvim-linux64/bin/nvim /usr/local/bin
	mv nvim-linux64/share/nvim /usr/local/share
	rm nvim-linux64.tar.gz
	rm -rf nvim-linux64

install_choosenim:
	curl https://nim-lang.org/choosenim/init.sh -sSf | sh

install_pyenv:
	curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

install_goenv:
	git clone https://github.com/syndbg/goenv.git ~/.goenv

install_nvm:
	mkdir -p ~/.nvm
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
	command -v nvm

.PHONY: create_symlink
create_symlink:
	echo
	./create_symlink

setup_neovim:
	echo
	./nvim/nvim_setup
