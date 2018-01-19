# ----- start zplug configuration ----- 
source ~/packages/zplug/init.zsh

zplug "rupa/z", use:z.sh #Tracks your most used directories, based on 'frecency'
zplug "changyuheng/fz", defer:1 # The missing fuzzy tab completion feature of z
# Install zsh-iterm-touchbar only for OS X
if [[ `uname` == 'Darwin' ]]
then
    zplug "iam4x/zsh-iterm-touchbar"
fi

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

# https://stackoverflow.com/questions/22600259/zsh-autocomplete-from-the-middle-of-filename
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit

# Alias
alias zshrc='vim $PROJECT_DIR/configs/config.zshrc'
alias vimrc='vim $PROJECT_DIR/configs/config.vim'
alias cdp='cd $PROJECT_DIR/'
alias cdw='cd ~/work'
alias v='vim'

# Exports
export TERM=xterm-256color # Assuming terminal to support 256 colors

# set core file size to unlimited
ulimit -c unlimited

# Sometimes error described in the following link happens and need to do the suggested solution
# _arguments:450: _vim_files: function definition file not found
# https://github.com/robbyrussell/oh-my-zsh/issues/518
function fixCdAutoComplete
{
    rm ~/.zcompdump*
    rm ~/.zplug/zcompdump
    exec zsh
}

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
