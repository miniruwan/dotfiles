#!/bin/bash

# Exit on error
set -e

configure_vim_neovim_common() {
  # Install the Basic version of https://github.com/amix/vimrc
  git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
  echo "source ~/.vim_runtime/vimrcs/basic.vim" >> ~/.vimrc

  # Source this project's vim config
  echo "source $CONFIG_DIR/vim/config.vim" >> ~/.vimrc

  # youcompleteme
  sudo apt install -y build-essential cmake python-dev python3-dev
  cd ~/.vim/plugged/YouCompleteMe
  ./install.py --clang-completer --cs-completer --js-completer
}

configure_neovim() {
  curl -o /tmp/nvim -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod u+x /tmp/nvim
  sudo mv /tmp/nvim /usr/local/bin

  # vim-plug
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  if [[ $platform == 'linux' ]]; then
    # libclang is needed for arakashic/chromatica.nvim
    sudo apt install -y clang

    # xsel is needed to copy to clipboard
    sudo apt install -y xsel
  fi

  # https://vi.stackexchange.com/questions/12794/how-to-share-config-between-vim-and-neovim
  mkdir -p ~/.config/nvim
  echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> ~/.config/nvim/init.vim
  echo "let &packpath=&runtimepath" >> ~/.config/nvim/init.vim
  echo "source ~/.vimrc" >> ~/.config/nvim/init.vim


  pip3 install pynvim

  configure_vim_neovim_common
}

compile_vim() {
  local programName=vim
  local minimumRequriredVersion=8
  if [[ -x "$(command -v $programName)" ]]; then # program exists
    local availableVersion=$($programName --version | head -1 | cut -d ' ' -f 5)
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
							--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu \
							--enable-perlinterp=yes \
							--enable-cscope \
							--prefix=/usr/local
  make -j8 VIMRUNTIMEDIR=/usr/local/share/vim/vim82
  sudo make install
}

configure_vim() {
  print -P "\n\n%F{magenta}Do you want to use neovim instead vim??%f"
  read -q "useNeovim"
  if [[ $useNeovim == 'y' ]]; then
    configure_neovim
    return 0;
  fi

  compile_vim

  sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
  sudo update-alternatives --set editor /usr/local/bin/vim
  sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
  sudo update-alternatives --set vi /usr/local/bin/vim

  # vim-plug
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  configure_vim_neovim_common
}
