# prerequisite : PROJECT_DIR is defined

# Some variables to be used later in this file
SIG_ROOT_DIR=$PROJECT_DIR/temasys-signaling

alias sigZshrc='vim $PROJECT_DIR/configs/Temasys/sig.zshrc'
alias cds='cd $SIG_ROOT_DIR'
alias rms='rm $SIG_ROOT_DIR/logs/daily/*;rm $SIG_ROOT_DIR/logs/global/*';
alias lastSigLog='vim `ls -t $SIG_ROOT_DIR/logs/daily/* | head -1`'
alias cdSigLog='cd $SIG_ROOT_DIR/logs/daily/'

function startSignalling
{
  cd $SIG_ROOT_DIR/app
  pm2 start main.js --name sig-main
  pm2 start service.js --name sig-service
}

# grep in webrtc excluding some directories (excluding test directories also)
function siggrep 
{
    cds
    grep -R --exclude-dir={deploy,key,logs,node_modules,patch,ssl_certs} "$1" .
}
