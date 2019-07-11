# prerequisite : PROJECT_DIR is defined

# Some variables to be used later in this file
MCU_MANAGER_ROOT_DIR=$PROJECT_DIR/skylink-mcu-manager

alias mcuManagerZshrc='vim $PROJECT_DIR/configs/Temasys/mcu_manager.zshrc'
alias cdmcuManager='cd $MCU_MANAGER_ROOT_DIR'
alias rmMcuManagerLogs='rm $MCU_MANAGER_ROOT_DIR/logs/daily/*;rm $MCU_MANAGER_ROOT_DIR/logs/global/*';
alias lsMcuManagerLog='ls -t $MCU_MANAGER_ROOT_DIR/logs/daily/* | head -1'
alias mcuManagerlog='vim `lsMixerLog`'
alias tailMcuManagerlog='tail -f `lsMixerLog`'
alias cdMcuManagerLog='cd $MCU_MANAGER_ROOT_DIR/logs/daily/'
alias vimMcuManager='vim $MCU_MANAGER_ROOT_DIR/app/MCUManager.js'

function startMcuManager
{
  cd $MCU_MANAGER_ROOT_DIR/app
  pm2 start server.js --name mcuManager --interpreter=node@6.10.3
}
