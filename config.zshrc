platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  if ( grep -q Microsoft /proc/version ); then
    platform='wsl'
  else 
    platform='linux'
  fi
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
elif [[ `uname` == 'CYGWIN'* ]]; then
   platform='cygwin'
fi

# Some plugins seems not working with windows subsystem for linux.
if [[ $platform == 'wsl' ]]; then
  # See https://github.com/Microsoft/BashOnWindows/issues/1887
  unsetopt BG_NICE

  alias open=explorer.exe
  alias git="/mnt/c/Program\ Files/Git/bin/git.exe"
  export PATH=mnt/c/Program\ Files/Git/bin:$PATH

  command_not_found_handler() {
      if cmd.exe /c "(where $1 || (help $1 |findstr /V Try)) >nul 2>nul && ($* || exit 0)"; then
          return $?
      else
          [[ -x /usr/lib/command-not-found ]] || return 1
          /usr/lib/command-not-found --no-failure-msg -- ${1+"$1"} && :
      fi
  }
fi

# ----- start zplug configuration ----- 
source ~/.zplug/init.zsh

zplug "rupa/z", use:z.sh #Tracks your most used directories, based on 'frecency'
zplug "changyuheng/fz", defer:1 # The missing fuzzy tab completion feature of z
# Install zsh-iterm-touchbar only for OS X
if [[ $platform == 'osx' ]]; then
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
alias vimrc='vim $PROJECT_DIR/configs/vim/config.vim'
alias cdp='cd $PROJECT_DIR/'
alias cdw='cd ~/work'
alias v='vim'

# Exports
export TERM=xterm-256color # Assuming terminal to support 256 colors
export DOTNET_CLI_TELEMETRY_OPTOUT=1

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

function vl
{
    vim `ls -t $1 | head -1`
}

function showWindowsMessageBox
{
    # Show notification (only on windows because Mac can use iTerm2 triggers)
    if [[ $platform == 'cygwin' ]]; then
        cscript `cygpath -d "$PROJECT_DIR/configs/Helpers/MessageBox.vbs"` $1
    fi
}

# arg1 : Environment variable name
# arg2 : Value to be set for the  environment variable if not set
function setEnvVariableIfNotSet
{
  if ! [[ -v $1 ]]; then
    export "$1"="$2"
  fi
}

if [[ $platform == 'osx' ]]; then
  export PATH="/usr/local/opt/openssl/bin:$PATH"
fi

# set tab space to 2
tabs -2

# https://unix.stackexchange.com/questions/241726/fix-ls-colors-for-directories-with-777-permission
if ! [[ $platform == 'osx' ]]; then
[ -e ~/.dircolors ] && eval $(dircolors -b ~/.dircolors) ||
    eval $(dircolors -b)
fi
