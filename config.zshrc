# ----- start zplug configuration ----- 
source ~/packages/zplug/init.zsh

zplug "rupa/z", use:z.sh #Tracks your most used directories, based on 'frecency'
zplug "changyuheng/fz", defer:1 # The missing fuzzy tab completion feature of z

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# ----- end zplug configuration ----- 

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
