#!/bin/bash

# Exit on error
set -e

install_neovim_binary() {
  if [[ "$platform" == 'linux' || "$platform" == 'wsl' ]]; then
    curl -L -o /tmp/nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    chmod u+x /tmp/nvim.appimage
    sudo mv /tmp/nvim.appimage /usr/local/bin/nvim
  elif [[ "$platform" == 'osx' ]]; then
    brew install neovim
  else
    print_important "Unsupported platform for automatic Neovim install: $platform"
  fi
}

install_neovim_dependencies() {
  if [[ "$platform" == 'linux' || "$platform" == 'wsl' ]]; then
    sudo apt install -y \
      build-essential \
      clang \
      curl \
      fd-find \
      git \
      nodejs \
      npm \
      python3 \
      python3-pip \
      ripgrep \
      unzip \
      xsel
  elif [[ "$platform" == 'osx' ]]; then
    brew install fd git node python ripgrep
  fi
}

tree_sitter_cli_is_current() {
  if ! command -v tree-sitter >/dev/null 2>&1; then
    return 1
  fi

  local version
  version=$(tree-sitter --version | awk '{ print $2 }')
  [[ "$(printf '%s\n%s\n' "0.26.1" "$version" | sort -V | head -n1)" == "0.26.1" ]]
}

install_treesitter_cli() {
  if tree_sitter_cli_is_current; then
    return
  fi

  if command -v cargo >/dev/null 2>&1; then
    cargo install tree-sitter-cli
  else
    print_important "tree-sitter-cli 0.26.1+ is required for nvim-treesitter; install Rust/cargo, then rerun this script."
  fi
}

link_neovim_config() {
  mkdir -p ~/.config

  if [[ -e ~/.config/nvim && ! -L ~/.config/nvim ]]; then
    mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d%H%M%S)
  fi

  ln -sfn "$CONFIG_DIR/nvim" ~/.config/nvim
}

configure_neovim() {
  install_neovim_binary
  install_neovim_dependencies
  install_treesitter_cli
  link_neovim_config

  python3 -m pip install --user --upgrade pynvim

  nvim --headless "+Lazy! sync" +qa
}