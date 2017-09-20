# prerequisite : PROJECT_DIR is defined

# Some variables to be used later in this file
RECORDING_ROOT_DIR=$PROJECT_DIR/recording

alias recZshrc='vim $PROJECT_DIR/configs/Temasys/recording.zshrc'
alias cdRec='cd $RECORDING_ROOT_DIR'
alias rmRecLogs='rm $RECORDING_ROOT_DIR/logs/daily/*;rm $RECORDING_ROOT_DIR/logs/global/*';
alias rmRecRecordings='rm -rf $RECORDING_ROOT_DIR/recordings';
alias recLog='ls -t $RECORDING_ROOT_DIR/logs/daily/* | head -1'
alias vimRecLog='vim `recLog`'
alias tailRecLog='tail -f `recLog`'
alias cdRecLog='cd $RECORDING_ROOT_DIR/logs/daily/'
