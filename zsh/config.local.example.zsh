# The place where the config files are located
CONFIG_DIR=${0:a:h:h}

# Source the config.zsh which is the main zsh file
source $CONFIG_DIR/zsh/config.zsh

#Your exports
[ -f /usr/local/bin/nvim ] && export EDITOR=/usr/local/bin/nvim

# Your aliases
alias v='vim'
