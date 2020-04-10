#!/bin/bash

# Exit on error
set -e

configure_fzf() {
  print_info "Installing fzf"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}
