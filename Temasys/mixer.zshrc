# prerequisite : PROJECT_DIR is defined

# Some variables to be used later in this file
MIXER_ROOT_DIR=$PROJECT_DIR/mixer

alias mixerZshrc='vim $PROJECT_DIR/configs/Temasys/mixer.zshrc'
alias cdMixer='cd $MIXER_ROOT_DIR'
alias rmMixerLogs='rm $MIXER_ROOT_DIR/logs/daily/*;rm $MIXER_ROOT_DIR/logs/global/*';
alias lastMixerLog='vim `ls -t $MIXER_ROOT_DIR/logs/daily/ | head -1`'
alias cdMixerLog='cd $MIXER_ROOT_DIR/logs/daily/'
