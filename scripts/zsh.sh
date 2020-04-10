#!/bin/bash

# Exit on error
set -e

compile_zsh() {
  # Checks whether the required version is installed
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

	cp $CONFIG_DIR/config.local.example.zsh $CONFIG_DIR/config.local.zsh
	echo "source $CONFIG_DIR/config.local.zsh" >> ~/.zshrc
}
