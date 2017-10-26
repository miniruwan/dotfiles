# Alias
alias zshrc='vim $PROJECT_DIR/configs/config.zshrc'
alias vimrc='vim $PROJECT_DIR/configs/config.vim'
alias cdp='cd $PROJECT_DIR/'
alias cdw='cd ~/work'
alias v='vim'

# grep in plugin excluding some directories
function codegrep 
{
    grep -r "$1" * | grep -Ev '(tags|Makefile|CMakeFiles|.cc|Release|cscope|Binary|logs|node_modules)'
}

function vl
{
    vim `ls -t $1 | head -1`
}

function showWindowsMessageBox
{
    # Show notification (only on windows because Mac can use iTerm2 triggers)
    if [[ `uname` == 'CYGWIN'* ]] then
        cscript `cygpath -d "$PROJECT_DIR/configs/Helpers/MessageBox.vbs"` $1
    fi
}
