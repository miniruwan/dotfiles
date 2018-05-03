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
  alias cdr2='cd /mnt/c/Users/Miniruwan/AppData/Roaming/MetaQuotes/Terminal/AA84C4F093F61E811C5503872251820D/MQL4/Experts/Miniruwan'
  alias cdr3='cd /mnt/c/Users/Miniruwan/AppData/Roaming/MetaQuotes/Terminal/73501E913F7423FCDED27CA37B6C44E8/MQL4/Experts/Miniruwan'
fi

# Source any more custome zshrc files
source $PROJECT_DIR/configs/Temasys/mcu.zshrc
