#!/bin/bash

# Exit on error
set -e

configure_tmux() {
  print_info "Installing tmux"

  sudo apt install tmux

  # Install https://github.com/gpakosz/.tmux
  git clone https://github.com/gpakosz/.tmux.git ~/.tmux
  ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf
  cp ~/.tmux/.tmux.conf.local ~/
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "source-file $CONFIG_DIR/tmux/config.tmux" >> ~/.tmux.conf.local
}
