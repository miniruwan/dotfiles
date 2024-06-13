#!/bin/bash

# Exit on error
set -e

print_info "Installing PowerLevel"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

ln -s $CONFIG_DIR/zsh/powerlevel.config.zsh ~/.p10k.zsh
