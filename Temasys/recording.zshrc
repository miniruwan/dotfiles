# prerequisite : PROJECT_DIR is defined

# Some variables to be used later in this file
RECORDING_ROOT_DIR=$PROJECT_DIR/recording

alias recZshrc='vim $PROJECT_DIR/configs/Temasys/recording.zshrc'
alias cdrec='cd $RECORDING_ROOT_DIR'
alias rmRecLogs='/bin/rm -f $RECORDING_ROOT_DIR/logs/daily/*;/bin/rm -f $RECORDING_ROOT_DIR/logs/global/*';
alias cdRecRecordings='cd $RECORDING_ROOT_DIR/recordings';
alias rmRecRecordings='rm -rf $RECORDING_ROOT_DIR/recordings/*';
alias lsrecLog='ls -t $RECORDING_ROOT_DIR/logs/daily/* | head -1'
alias reclog='vim `lsrecLog`'
alias pm2RecordingLog='pm2 logs recording'
alias tailreclog='tail -f `lsrecLog`'
alias cdreclog='cd $RECORDING_ROOT_DIR/logs/daily/'
alias vimrec='vim $RECORDING_ROOT_DIR/recording.js'

function startRecording
{
  cd $RECORDING_ROOT_DIR
  pm2 start client.js --name recording --interpreter=node@6.10.3
}
