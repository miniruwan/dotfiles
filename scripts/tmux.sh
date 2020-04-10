#!/bin/bash

# Exit on error
set -e

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
    sudo apt install -y libncursesw5-dev bison byacc
  elif [[ "$platform" == 'wsl' ]]; then
    sudo apt install -y libssl-dev automake
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
  echo "source-file $CONFIG_DIR/tmux/config.tmux" >> ~/.tmux.conf.local
}
