# To Avoid printing name in the prompt
if [[ $platform != 'wsl' ]]; then
  DEFAULT_USER='miniruwan'
fi

# The place where projects (including this project itself) are cloned
PROJECT_DIR=${0:a:h:h}

# Source the config.zshrc
source $PROJECT_DIR/configs/config.zshrc

# Any platform specific custom configurations
if [[ $platform == 'wsl' ]]; then
  alias cdr='cd /mnt/c/Users/Miniruwan/AppData/Roaming/MetaQuotes/Terminal/D6A64B03CC8608512E2306E65B4C1A54/MQL4/Experts/Miniruwan'
fi

# Source any more custom zshrc files
source $PROJECT_DIR/mcu-libwebrtc/dotfiles/config.example.zshrc
