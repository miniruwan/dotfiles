#!/bin/bash

# ========== General script ==========
# Detect platform
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
	if grep -q Microsoft /proc/version; then
	  platform='wsl' # windows subsystem for linux
	else
	  platform='linux' # Native linux
	fi
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
fi

if [[ $platform == 'linux' ]]; then
  sudo apt-get update
fi

# ---------- Helper functions -----------
print_important() {
  # Printing message in the console.
  RED='\033[0;31m'
  NC='\033[0m' # No Color
  echo ""
  echo "------------------------------------- NOTICE -----------------------------------------"
  echo -e "${RED}$1${NC}"
  echo "--------------------------------------------------------------------------------------"
}

# ================= functions for each configuration task =====================

configure_zsh() {
	sudo apt-get install zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	echo "#" >> ~/.zshrc
	echo "# Mini's configs" >> ~/.zshrc
	echo "source ~/projects/configs/config.local.zshrc" >> ~/.zshrc

	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

}

configure_mono() {
		sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
		sudo apt install apt-transport-https
		echo "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
		sudo apt update
		sudo apt install mono-devel
}

configure_node() {
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install -y nodejs
}

configure_vim() {
	# source : https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
	sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
	libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
	libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
	python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev

	cd packages
	git clone https://github.com/vim/vim.git
	cd vim
	./configure --with-features=huge \
								--enable-multibyte \
								--enable-rubyinterp=yes \
								--enable-pythoninterp=yes \
								--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
								--enable-python3interp=yes \
								--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
								--enable-perlinterp=yes \
								--enable-luainterp=yes \
								--enable-gui=gtk2 \
								--enable-cscope \
								--prefix=/usr/local
	sudo make install
	sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
	sudo update-alternatives --set editor /usr/local/bin/vim
	sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
	sudo update-alternatives --set vi /usr/local/bin/vim

	git clone --depth=1 https://github.com/amix/vimrc.git ~/packages/vim_ultimate_vimrc
	echo "source ~/packages/vim_ultimate_vimrc/vimrcs/basic.vim" >> ~/.vimrc
	echo "let \$MY_VIM_CONFIG_DIR=~/projects/configs/vim" >> ~/.vimrc
	echo "source \$MY_VIM_CONFIG_DIR/config.vim" >> ~/.vimrc

	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# https://valloric.github.io/YouCompleteMe/#ubuntu-linux-x64
	if [[ $platform == 'linux' ]]; then
		sudo apt-get install build-essential cmake
		cd ~/.vim/plugged/YouCompleteMe
		# Assumption : all the dependencies installed
		./install.py --clang-completer --cs-completer --js-completer
	fi
	

}
configure_fzf() {
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

configure_powerline_font() {
  if [[ $platform == 'linux' ]]; then
    sudo apt-get install fonts-powerline
  fi
}

configure_tmux() {
  if [[ $platform == 'linux' ]]; then
    sudo apt-get install tmux
  fi
  cd
  git clone https://github.com/gpakosz/.tmux.git
  ln -s -f .tmux/.tmux.conf
  cp .tmux/.tmux.conf.local .
}

configure_zenburn() {
  # Install Zenburn-for-Terminator
  if [[ $platform == 'linux' ]]; then
    mkdir -p ~/.config/terminator/
    wget -O ~/.config/terminator/config https://raw.githubusercontent.com/alinmindroc/Zenburn-for-Terminator/master/config
  fi
}

configure_gitkraken() {
  if [[ $platform == 'linux' ]]; then
    wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
    sudo dpkg -i gitkraken-amd64.deb
  fi
}

configure_vscode() {
  if [ -d ~/.config/Code/User ]; then
    cd ~/.config/Code/User
    ln -s $PROJECT_DIR/configs/vscode/settings.json settings.json
    ln -s $PROJECT_DIR/configs/vscode/keybindings.json keybindings.json
  else
    print_important "Couldnn't find VSCode config directory"
  fi
}

run_all_configurations() {
  configure_powerline_font
  configure_tmux
  configure_zenburn
  configure_gitkraken
  configure_vscode
}

# ======================== main ========================
if [[ $# -eq 0 ]] ; then # No arguments supplied.
  run_all_configurations
fi
