# prerequisite : PROJECT_DIR is defined

# Some variables to be used later in this file
MCU_ROOT_DIR=$PROJECT_DIR/temasys-sfu-mcu

alias mcuzshrc='vim $PROJECT_DIR/configs/Temasys/mcu.zshrc'
alias cdm='cd $MCU_ROOT_DIR'
alias cdlicode='cd $MCU_ROOT_DIR/licode/erizo/src/erizo'
alias cdr='cd $PROJECT_DIR/recording'
alias rmm='rm $MCU_ROOT_DIR/logs/erizo-cores/*.log;rm $MCU_ROOT_DIR/logs/*.log*';
alias lsLastLicodeLog='ls -t $MCU_ROOT_DIR/logs/erizo-cores/*.log | head -1'
alias licodelog='vim `lsLastLicodeLog`'
alias mculog='vim $MCU_ROOT_DIR/logs/skylink-mcu-node.log'
alias tailmculog='tail -f $MCU_ROOT_DIR/logs/skylink-mcu-node.log'
alias cdlicodelog='cd $MCU_ROOT_DIR/logs/erizo-cores/'
alias vimex='vim $MCU_ROOT_DIR/licode/erizo/src/erizo/media/ExternalOutput.cpp'
alias vimmcu='vim $MCU_ROOT_DIR/app/sfu/MCU.js'
alias bl='cdm; ./licodeCompile.sh; rmm; pm2 restart mcu;'

# tail licode log. If no arguments given, last modified log will be tailed
function taillicode
{
    if (( $# != 0 )) then
        tail -f *$1*
    else
        tail -f `lsLastLicodeLog`
    fi
}

function gdblicode
{
    # first find the processID of licode thread
    local erizoProcessName=''
    if (( $# != 0 )) then
        erizoProcessName=$1
    else
        # Finding the erizo process name if not provided
        if [[ `lsLastLicodeLog` =~ sky-(.*)\.log$ ]]; then
            erizoProcessName=${match[1]}
        fi
    fi
    echo "Finding PID of erizo process: $erizoProcessName"
    local erizoPID=`ps aux | grep $erizoProcessName | grep node | awk '{print $2}'`
    echo "Found PID: $erizoPID, starting gdb..."
    sudo gdb -x ~/gdbconf attach $erizoPID
}

LD_LIBRARY_PATH=$MCU_ROOT_DIR/licode/erizo//build/erizo
