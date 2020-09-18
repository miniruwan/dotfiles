#!/bin/bash

# Exit on error
set -e

# Warning : This is not completely tested yet

# ========== Common sources ==========
source scripts/set_variables.sh
source scripts/set_platform.sh
source scripts/print_helper.sh

# ================= functions for each configuration task =====================

source scripts/zsh.sh
source scripts/vim.sh
source scripts/fzf.sh
source scripts/cmake.sh
source scripts/tmux.sh

configure_symlinks() {
  rm -rf ~/Downloads && ln -s '/media/miniruwan/Data/Downloads' ~/Downloads
  rm -rf ~/Downloads && ln -s '/media/miniruwan/Data/Documents' ~/Documents
  rm -rf ~/Downloads && ln -s '/media/miniruwan/Data/Music' ~/Music
  rm -rf ~/Downloads && ln -s '/media/miniruwan/Data/Videos' ~/Videos
  rm -rf ~/Downloads && ln -s '/media/miniruwan/Data/Pictures' ~/Pictures
  rm -rf ~/Downloads && ln -s '/media/miniruwan/Data/projects' ~/projects
}

configure_ack() {
  if [[ "$platform" == 'linux' ]]; then
    sudo apt install -y silversearcher-ag ack-grep
  elif [[ "$platform" == 'osx' ]]; then
    brew install the_silver_searcher
  fi
}

configure_mono() {
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    sudo apt install -y apt-transport-https
    echo "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
    sudo apt update
    sudo apt install -y mono-devel
}

configure_node() {
	curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
	sudo apt install -y nodejs
}

configure_python() {
  if [[ $platform == 'linux' ]]; then
    sudo apt install -y python-pip python-setuptools
    pip install wheel
  fi
}

configure_powerline_font() {
  if [[ $platform == 'linux' ]]; then
    print_info "Installing powerline font"
    sudo apt install -y fonts-powerline
    configure_python
    pip install --user powerline-status
  fi
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
    cd ~/packages
    wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
    sudo dpkg -i gitkraken-amd64.deb
    rm ~/packages/gitkraken-amd64.deb
  fi
}

configure_vscode() {
  if [ -d ~/.config/Code/User ]; then
    cd ~/.config/Code/User
    ln -s $CONFIG_DIR/vscode/settings.json settings.json
    ln -s $CONFIG_DIR/vscode/keybindings.json keybindings.json
  else
    print_important "Couldnn't find VSCode config directory"
  fi
}

configure_iterm() {
  if [[ $platform == 'osx' ]]; then
    ln -s -f $CONFIG_DIR/iterm/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
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

# https://github.com/nvbn/thefuck
configure_thefuck() {
  print_info "Installing thefuck"
  if [[ $platform == 'osx' ]]; then
    brew install thefuck
  else
    sudo apt update
    sudo apt install -y python3-dev python3-pip python3-setuptools
    sudo pip3 install thefuck
  fi
}

run_all_configurations() {

  if [[ $platform == 'linux' ]]; then
    sudo apt update
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
elif [[ $* == *--node* ]] ; then
  configure_node
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
else
  print_important "Unsupported argument: $*"
  echo "$usage"
fi
