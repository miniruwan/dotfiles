#!/bin/bash

# Warning : This is not completely tested yet

# ========== General script ==========
CONFIG_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

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
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='osx'
fi

# ---------- Helper functions -----------
print_debug() {
  # Printing message in the console.
  BLUE='\e[94m'
  NC='\033[0m' # No Color
  echo ""
  echo -e "${BLUE}$1${NC}"
}

print_info() {
  # Printing message in the console.
  GREEN_BLINK_BOLD='\e[5m\e[32m\e[1m'
  NC='\033[0m' # No Color
  echo ""
  echo "------------------------------"
  echo -e "${GREEN_BLINK_BOLD}$1${NC}"
  echo "------------------------------"
}

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

// Checks whether the required version is installed

compile_zsh() {
  local programName=zsh
  local minimumRequriredVersion=5
  if [[ -x "$(command -v $programName)" ]]; then # program exists
    local availableVersion=$($programName --version | cut -d' ' -f 2)
    if [[ $availableVersion -gt $minimumRequriredVersion ]]; then
      print_debug "Compilation is not required for $programName because the available version($availableVersion) \
        already satisfies the minimumRequriredVersion($minimumRequriredVersion)"
      return 0;
    else
      print_debug "Compiling $programName because because the available version($availableVersion) \
        is less than the minimumRequriredVersion($minimumRequriredVersion)"
    fi
  else
    print_debug "Compiling $programName because $programName is not found"
  fi

  cd ~/packages
  wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download
  mkdir zsh && unxz zsh.tar.xz && tar -xvf zsh.tar -C zsh --strip-components 1
  cd zsh
  mkdir -p $HOME/.local
  ./configure --prefix=$HOME/.local
  make && make install
}

configure_fzf() {
  print_info "Installing fzf"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

configure_zsh() {
  print_info "Installing Zsh"

  compile_zsh

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  configure_fzf

  # zplug
	git clone https://github.com/zplug/zplug ~/.zplug
	echo "#" >> ~/.zshrc
	echo "# Mini's configs" >> ~/.zshrc
	echo "source ~/.zplug/init.zsh" >> ~/.zshrc

	cp $CONFIG_DIR/config.local.example.zshrc $CONFIG_DIR/config.local.zshrc
	echo "source $CONFIG_DIR/config.local.zshrc" >> ~/.zshrc
}

configure_ack() {
  if [[ "$platform" == 'linux' ]]; then
    sudo apt install silversearcher-ag ack-grep
  elif [[ "$platform" == 'osx' ]]; then
    brew install the_silver_searcher
  fi
}

configure_mono() {
		sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
		sudo apt install apt-transport-https
		echo "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
		sudo apt update
		sudo apt install mono-devel
}

configure_node() {
	curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
	sudo apt-get install -y nodejs
}

configure_python() {
  if [[ $platform == 'linux' ]]; then
    sudo apt install python-pip
    sudo apt install python-setuptools
    pip install wheel
  fi
}

configure_powerline_font() {
  if [[ $platform == 'linux' ]]; then
    print_info "Installing powerline font"
    sudo apt-get install fonts-powerline
    configure_python
    pip install --user powerline-status
  fi
}

configure_cmake() {
  if [[ $platform != 'linux' ]]; then
    print_important "Installing cmake is currently implemented only linux"
    return 1;
  fi

  local programName=cmake
  local minimumRequriredVersion=3
  if [[ -x "$(command -v $programName)" ]]; then # program exists
    local availableVersion=$($programName --version | head -n 1 | cut -d" " -f 3)
    if [[ $availableVersion -gt $minimumRequriredVersion ]]; then
      print_debug "Compilation is not required for $programName because the available version($availableVersion) \
        already satisfies the minimumRequriredVersion($minimumRequriredVersion)"
      return 0;
    else
      print_debug "Compiling $programName because because the available version($availableVersion) \
        is less than the minimumRequriredVersion($minimumRequriredVersion)"
    fi
  else
    print_debug "Compiling $programName because $programName is not found"
  fi

  cmakeLatestVersion=$(curl --silent "https://api.github.com/repos/Kitware/CMake/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")' | cut -d'v' -f 2)
  cd ~/packages
  wget https://github.com/Kitware/CMake/releases/download/v$cmakeLatestVersion/cmake-$cmakeLatestVersion-Linux-x86_64.tar.gz
  tar -xzvf cmake-$cmakeLatestVersion-Linux-x86_64.tar.gz
  cd cmake-$cmakeLatestVersion-Linux-x86_64
  # install
  mkdir -p ~/.local/bin/
  mkdir -p ~/.local/share/
  cp -r bin/* ~/.local/bin/
  cp -r share/* ~/.local/share/

  # cleanup
  cd ~/packages
  rm -rf cmake-$cmakeLatestVersion-Linux-x86_64
  rm cmake-$cmakeLatestVersion-Linux-x86_64.tar.gz
}

compile_tmux() {
  local programName=tmux
  local minimumRequriredVersion=2
  if [[ -x "$(command -v $programName)" ]]; then # program exists
    local availableVersion=$(tmux -V | cut -d' ' -f 2)
    if [[ $availableVersion -gt $minimumRequriredVersion ]]; then
      print_debug "Compilation is not required for $programName because the available version($availableVersion) \
        already satisfies the minimumRequriredVersion($minimumRequriredVersion)"
      return 0;
    else
      print_debug "Compiling $programName because because the available version($availableVersion) \
        is less than the minimumRequriredVersion($minimumRequriredVersion)"
    fi
  else
    print_debug "Compiling $programName because $programName is not found"
  fi

  # libevent is needed as a dependency to build tmux.
  cd ~/packages
  git clone https://github.com/libevent/libevent.git
  cd libevent && mkdir build && cd build
  cmake ..
  make && sudo make install

  # newer cmake is needed to compile
  configure_cmake

  # Some dependencies not available in old linux versions
  if [ "$platform" == 'linux' ] && [ `lsb_release -rs` == "14.04" ]; then
    sudo apt-get install -y libncursesw5-dev bison byacc
  elif [[ "$platform" == 'wsl' ]]; then
    sudo apt-get install -y libssl-dev automake
  fi

  cd ~/packages
  git clone https://github.com/tmux/tmux.git
  cd tmux
  # tmux versions >=3 doesn't seem to be working with gpakosz/.tmux
  git checkout tags/2.9


	sh autogen.sh
  ./configure --prefix=$HOME/.local
  make && make install
}

configure_tmux() {
  print_info "Installing tmux"

  compile_tmux

  # Install https://github.com/gpakosz/.tmux
  git clone https://github.com/gpakosz/.tmux.git ~/.tmux
  ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf
  cp ~/.tmux/.tmux.conf.local ~/
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "source-file $CONFIG_DIR/config.tmux" >> ~/.tmux.conf.local
}

configure_zenburn() {
  if [[ $platform == 'linux' ]]; then
    print_info "Installing Zenburn-for-Terminator"
    print_info "Installing Zenburn"
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
  # source : https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
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
							--enable-cscope \
							--prefix=/usr/local
  make VIMRUNTIMEDIR=/usr/local/share/vim/vim80
  sudo make install
  cd
  sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
  sudo update-alternatives --set editor /usr/local/bin/vim
  sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
  sudo update-alternatives --set vi /usr/local/bin/vim

  # Install the Basic version of https://github.com/amix/vimrc
  git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
  echo "source ~/.vim_runtime/vimrcs/basic.vim" >> ~/.vimrc

  # Source this project's vim config
  echo "source $CONFIG_DIR/vim/config.vim" >> ~/.vimrc

  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # youcompleteme
  sudo apt-get install build-essential cmake
  sudo apt-get install python-dev python3-dev
  cd ~/.vim/plugged/YouCompleteMe
  ./install.py --clang-completer --cs-completer --js-completer
}

configure_iterm() {
  if [[ $platform == 'osx' ]]; then
    ln -s -f $CONFIG_DIR/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
  fi
}

# https://github.com/nvbn/thefuck
configure_theFuck() {
  if [[ $platform == 'linux' ]]; then
    sudo apt update
    sudo apt install python3-dev python3-pip
    sudo pip3 install thefuck
  elif [[ $platform == 'osx' ]]; then
    brew install thefuck
  fi
}

configure_copyQ() {
  print_info "Installing CopyQ"
  if [[ $platform == 'linux' ]]; then
    sudo add-apt-repository -y ppa:hluk/copyq
    sudo apt update
    sudo apt install -y copyq
  elif [[ $platform == 'osx' ]]; then
    brew cask install copyq
  fi
}

configure_thefuck() {
  print_info "Installing thefuck"
  if [[ $platform == 'linux' ]]; then
    sudo apt update
    sudo apt install python3-dev python3-pip python3-setuptools
    sudo pip3 install thefuck
  elif [[ $platform == 'osx' ]]; then
    brew install thefuck
  fi
}

run_all_configurations() {

  if [[ $platform == 'linux' ]]; then
    sudo apt-get update
  fi
  configure_zsh
  configure_fzf
  configure_powerline_font
  configure_tmux
  configure_zenburn
  configure_gitkraken
  configure_vscode
  configure_thefuck
}
usage="Usage :
$(basename "$0") [--<option>]

where <option>:
    --help      show this help text
    --all       run all initialization scripts
    --zsh       install zsh with oh-my-zsh
    --fzf       install fzf
    --python    install pip
    --font      install powerline font
    --zenburn   install Zenburn-for-Terminator
    --copy      install CopyQ
    --cmake     install cmake
    --tmux      install tmux
    --thefuck   install thefuck"

# ======================== main ========================
if [[ $# -eq 0 ]] ; then # No arguments supplied.
  echo "$usage"
elif [[ $* == *--help* ]] ; then
  echo "$usage"
elif [[ $* == *--all* ]] ; then
  run_all_configurations
elif [[ $* == *--zsh* ]] ; then
  configure_zsh
elif [[ $* == *--fzf* ]] ; then
  configure_fzf
elif [[ $* == *--python* ]] ; then
  configure_python
elif [[ $* == *--font* ]] ; then
  configure_powerline_font
elif [[ $* == *--zenburn* ]] ; then
  configure_zenburn
elif [[ $* == *--copy* ]] ; then
  configure_copyQ
elif [[ $* == *--cmake* ]] ; then
  configure_cmake
elif [[ $* == *--tmux* ]] ; then
  configure_tmux
elif [[ $* == *--vim* ]] ; then
  configure_vim
elif [[ $* == *--thefuck* ]] ; then
  configure_thefuck
fi
