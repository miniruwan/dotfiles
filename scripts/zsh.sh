#!/bin/bash

# Exit on error
set -e

local minimumRequriredVersion=5
local programName=zsh

compile_zsh() {
  mkdir -p ~/packages
  cd ~/packages
  wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download
  mkdir zsh && unxz zsh.tar.xz && tar -xvf zsh.tar -C zsh --strip-components 1
  cd zsh
  mkdir -p $HOME/.local
  ./configure --prefix=$HOME/.local
  make && make install
}

install_zsh() {
  local availableVersion=$(apt-cache policy $programName | grep Candidate | awk '{print $2}')
  if [[ $availableVersion -gt $minimumRequriredVersion ]]; then
    print_debug "Installing $programName from apt because a version($availableVersion) which is \
      greater than $minimumRequiredVersion is available to install from apt"
    sudo apt install zsh
  else
    print_debug "Compiling $programName because $programName is not available with the minimum required version($minimumRequiredVersion)"
    compile_zsh
  fi
}

configure_zsh() {
  print_info "Installing Zsh"

  # check installed version
  if [[ -x "$(command -v $programName)" ]]; then # program exists
    local installedVersion=$($programName --version | cut -d' ' -f 2)
    if [[ $installedVersion -gt $minimumRequriredVersion ]]; then
      print_debug "$programName executable already exists with the minimum required version. Installed version($installedVersion) \
        already satisfies the minimumRequriredVersion($minimumRequriredVersion)"
      return 0;
    fi
  else
    install_zsh
  fi

  print_info "Installing oh-my-zsh"

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  configure_fzf

  print_info "Setting up zplug"

  # zplug
	git clone https://github.com/zplug/zplug ~/.zplug
	echo "#" >> ~/.zshrc
	echo "# Mini's configs" >> ~/.zshrc
	echo "source ~/.zplug/init.zsh" >> ~/.zshrc

	cp $CONFIG_DIR/zsh/config.local.example.zsh $CONFIG_DIR/zsh/config.local.zsh
	echo "source $CONFIG_DIR/zsh/config.local.zsh" >> ~/.zshrc
}

powerlevel.sh
