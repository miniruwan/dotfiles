#!/bin/bash

# Exit on error
set -e

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

  # Install the Basic version of https://github.com/amix/vimrc
  git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
  echo "source ~/.vim_runtime/vimrcs/basic.vim" >> ~/.vimrc

  # Source this project's vim config
  echo "source $CONFIG_DIR/vim/config.vim" >> ~/.vimrc

  # youcompleteme
  #sudo apt install -y build-essential cmake python-dev python3-dev
  #cd ~/.vim/plugged/YouCompleteMe
  #./install.py --clang-completer --cs-completer --js-completer
}
