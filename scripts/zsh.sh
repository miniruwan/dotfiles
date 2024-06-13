#!/bin/bash

# Exit on error
set -e

configure_zsh() {
  print_info "Installing Zsh"
  sudo apt install zsh

  print_debug "Installing oh-my-zsh"

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  print_debug "Configuring fzf"

  configure_fzf

  print_debug "Setting up zplug"

  # zplug
  git clone https://github.com/zplug/zplug ~/.zplug
  echo "#" >> ~/.zshrc
  echo "# Mini's configs" >> ~/.zshrc
  echo "source ~/.zplug/init.zsh" >> ~/.zshrc

  print_debug "Setting up configuration files"
  cp $CONFIG_DIR/zsh/config.local.example.zsh $CONFIG_DIR/zsh/config.local.zsh
  echo "source $CONFIG_DIR/zsh/config.local.zsh" >> ~/.zshrc

  print_debug "Invoking powerlevel"
  powerlevel.sh
}

