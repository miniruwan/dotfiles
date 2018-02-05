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
