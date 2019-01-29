# prerequisite : PROJECT_DIR is defined

# Some variables to be used later in this file
setEnvVariableIfNotSet SIG_ROOT_DIR $PROJECT_DIR/temasys-signaling

alias sigZshrc='vim $PROJECT_DIR/configs/Temasys/sig.zshrc'
alias cds='cd $SIG_ROOT_DIR'
alias rms='rm $SIG_ROOT_DIR/logs/daily/*;rm $SIG_ROOT_DIR/logs/global/*';
alias lastSigLog='vim `ls -t $SIG_ROOT_DIR/logs/daily/* | head -1`'
alias cdSigLog='cd $SIG_ROOT_DIR/logs/daily/'

function startSignalling
{
  export mcu_on_demand=true
  cd $SIG_ROOT_DIR
  pm2 start app/main.js --name sig-main
  pm2 start app/message.js --name sig-message
}

# grep in signalling code excluding some directories
function siggrep 
{
    cds
    grep  --recursive --exclude-dir={deploy,key,logs,node_modules,patch,ssl_certs} "$1" .
}
