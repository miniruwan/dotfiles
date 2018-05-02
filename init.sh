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
	git clone https://github.com/zplug/zplug ~/packages/zplug
	cp ~/projects/configs/config.local.example.zshrc ~/projects/configs/config.local.zshrc
	echo "source ~/projects/configs/config.local.zshrc" >> ~/.zshrc
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
  # Assumption : ~/projects/configs is the place where this file is located
  echo "source-file ~/projects/configs/config.tmux" >> ~/.tmux.conf.local
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

configure_node() {
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  sudo apt-get install -y nodejs
}

configure_vim() {
  # Make vim
  sudo apt remove vim vim-runtime gvim
  sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
  libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
  libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
  python3-dev ruby-dev libperl-dev
  cd ~/packages
  git clone https://github.com/vim/vim.git
  cd vim
  ./configure --with-features=huge \
              --with-compiledby=Miniruwan \
							--enable-multibyte \
							--enable-rubyinterp=yes \
							--enable-pythoninterp=yes \
							--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
							--enable-python3interp=yes \
							--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
							--enable-perlinterp=yes \
							--enable-gui=gtk2 \
							--enable-cscope \
							--prefix=/usr/local
  make VIMRUNTIMEDIR=/usr/local/share/vim/vim80
  sudo make install
  cd
  sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
  sudo update-alternatives --set editor /usr/local/bin/vim
  sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
  sudo update-alternatives --set vi /usr/local/bin/vim

  git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime

  echo "source ~/.vim_runtime/vimrcs/basic.vim" >> ~/.vimrc
  echo "let \$MY_VIM_CONFIG_DIR='~/projects/configs/vim'" >> ~/.vimrc
  echo "source \$MY_VIM_CONFIG_DIR/config.vim" >> ~/.vimrc

  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # youcompleteme
  sudo apt-get install build-essential cmake
  sudo apt-get install python-dev python3-dev
  cd ~/.vim/plugged/YouCompleteMe
  ./install.py --clang-completer --js-completer
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
