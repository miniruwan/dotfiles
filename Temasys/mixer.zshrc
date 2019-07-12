# prerequisite : PROJECT_DIR is defined

# Some variables to be used later in this file
MIXER_ROOT_DIR=$PROJECT_DIR/mixer

alias mixerZshrc='vim $PROJECT_DIR/configs/Temasys/mixer.zshrc'
alias cdmix='cd $MIXER_ROOT_DIR'
alias rmMixerLogs='rm $MIXER_ROOT_DIR/logs/daily/*;rm $MIXER_ROOT_DIR/logs/global/*';
alias cdMixerRecordings='cd $MIXER_ROOT_DIR/recordings';
alias rmMixerRecordings='rm -rf $MIXER_ROOT_DIR/recordings/*';
alias lsMixerLog='ls -t $MIXER_ROOT_DIR/logs/daily/* | head -1'
alias mixerlog='vim `lsMixerLog`'
alias pm2MixerLog='pm2 logs mixer'
alias tailmixerlog='tail -f `lsMixerLog`'
alias cdMixerLog='cd $MIXER_ROOT_DIR/logs/daily/'
alias vimmix='vim $MIXER_ROOT_DIR/mixing.js'

function startMixer
{
  cd $MIXER_ROOT_DIR
  pm2 start server.js --name mixer --interpreter=node@5.12.0
}
