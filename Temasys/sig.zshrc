# prerequisite : PROJECT_DIR is defined

# Some variables to be used later in this file
setEnvVariableIfNotSet SIG_ROOT_DIR $PROJECT_DIR/temasys-signaling

alias sigZshrc='vim $PROJECT_DIR/configs/Temasys/sig.zshrc'
alias cds='cd $SIG_ROOT_DIR'
alias rms='rm $SIG_ROOT_DIR/logs/daily/*;rm $SIG_ROOT_DIR/logs/global/*';
alias lastSigLog='vim `ls -t $SIG_ROOT_DIR/logs/daily/* | head -1`'
alias cdSigLog='cd $SIG_ROOT_DIR/logs/daily/'

function startNewSignalling
{
  cd $SIG_ROOT_DIR
  pm2 start app/main.js --name sig
}

function startOldSignalling
{
  cd $SIG_ROOT_DIR
  export DynamoDB=local
  pm2 start app/main.js --name sigMain --interpreter=node@6.10.3
  pm2 start app/service.js --name sigService --interpreter=node@6.10.3
}

# grep in signalling code excluding some directories
function siggrep 
{
    cds
    grep  --recursive --exclude-dir={deploy,key,logs,node_modules,patch,ssl_certs} "$1" .
}
