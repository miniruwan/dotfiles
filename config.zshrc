# Avoid printing name in prompt
DEFAULT_USER='miniruwan'

if [[ `uname` == 'Darwin' ]] then
    PROJECT_DIR='/Users/miniruwan/projects'
elif [[ `uname` == 'CYGWIN'* ]] then
    PROJECT_DIR='/cygdrive/d/projects'
else
    echo "Unsupported OS"
fi

# Alias
alias zshrc='vim $PROJECT_DIR/configs/.zshrc.txt'
alias vimrc='vim $PROJECT_DIR/configs/vimrc.vim'
alias cdp='cd $PROJECT_DIR/'
alias cdg='cd $PROJECT_DIR/Google-WebRTC-Samples/'
alias cdw='cd ~/work'
alias v='vim'

function showWindowsMessageBox
{
    # Show notification (only on windows because Mac can use iTerm2 triggers)
    if [[ `uname` == 'CYGWIN'* ]] then
        cscript `cygpath -d "/cygdrive/d/projects/configs/Helpers/MessageBox.vbs"` $1
    fi
}

source $PROJECT_DIR/configs/Temasys/temasys.zshrc
