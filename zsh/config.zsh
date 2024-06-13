local modules_dir=$CONFIG_DIR/zsh/modules

source $CONFIG_DIR/scripts/set_platform.sh
source $modules_dir/wsl.zsh
source $modules_dir/plugin_config.zsh
source $modules_dir/aliases.zsh


# ==================================================================
# Exports
# ==================================================================
export TERM=xterm-256color # Assuming terminal to support 256 colors
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH=/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export ZSH_THEME="powerlevel10k/powerlevel10k"

if [[ $platform == 'osx' ]]; then
  export PATH=/usr/local/opt/openssl/bin:$PATH
else
  export PATH=$HOME/.local/bin:$PATH
fi

# https://github.com/wernight/powerline-web-fonts/issues/8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
# ==================================================================


# ==================================================================
# https://stackoverflow.com/questions/22600259/zsh-autocomplete-from-the-middle-of-filename
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# ==================================================================
# set tab space to 2
tabs -2


# ==================================================================
# https://unix.stackexchange.com/questions/241726/fix-ls-colors-for-directories-with-777-permission
if ! [[ $platform == 'osx' ]]; then
[ -e ~/.dircolors ] && eval $(dircolors -b ~/.dircolors) ||
    eval $(dircolors -b)
fi


# ==================================================================
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

# arg1 : Environment variable name
# arg2 : Value to be set for the  environment variable if not set
function setEnvVariableIfNotSet
{
  if ! [[ -z $1 ]]; then
    export "$1"="$2"
  fi
}
