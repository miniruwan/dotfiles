# The place where the config files are located
CONFIG_DIR=${0:a:h}
# The place where projects (including this project itself) are cloned
PROJECT_DIR=${0:a:h:h}

# Source the config.zshrc
source $CONFIG_DIR/config.zshrc

# Source any more custom zshrc files
source $CONFIG_DIR/Temasys/plugin.zshrc
source $CONFIG_DIR/Temasys/sig.zshrc
source $PROJECT_DIR/mcu-libwebrtc/dotfiles/config.example.zshrc
source $CONFIG_DIR/Temasys/skylink.zshrc
source $CONFIG_DIR/Temasys/skylink_old.zshrc

function startMcuDeps
{
  startSkylink # Depends on skylink.zshrc
  startSignalling # Depends on sig.zshrc
}
