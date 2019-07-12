# prerequisite : PROJECT_DIR is defined

# Some variables to be used later in this file
MIXING_MANAGER=$PROJECT_DIR/mixing-manager

alias mixingManagerZshrc='vim $PROJECT_DIR/configs/Temasys/mcu_manager.zshrc'
alias cdmixingManager='cd $MIXING_MANAGER'
alias rmMixingManagerLogs='rm $MIXING_MANAGER/logs/daily/*;rm $MIXING_MANAGER/logs/global/*';
alias lsMixingManagerLog='ls -t $MIXING_MANAGER/logs/daily/* | head -1'
alias mixingManagerlog='vim `lsMixerLog`'
alias pm2MixingManagerlog='pm2 logs mixingManager'
alias tailMixingManagerlog='tail -f `lsMixerLog`'
alias cdMixingManagerLog='cd $MIXING_MANAGER/logs/daily/'
alias vimMixingManager='vim $MIXING_MANAGER/app/MCUManager.js'

function startMixingManager
{
  cd $MIXING_MANAGER
  pm2 start server.js --name mixingManager --interpreter=node@6.10.3
}
