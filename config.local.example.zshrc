# To Avoid printing name in the prompt
DEFAULT_USER='miniruwan'

# The place where projects (including this project itself) are cloned
PROJECT_DIR=${0:a:h:h}

# Source the config.zshrc
source $PROJECT_DIR/configs/config.zshrc

# Source any more custome zshrc files
source $PROJECT_DIR/configs/Temasys/mcu.zshrc
