# ----- start zplug configuration ----- 
source ~/.zplug/init.zsh

zplug "rupa/z", use:z.sh #Tracks your most used directories, based on 'frecency'
zplug "changyuheng/fz", defer:1 # The missing fuzzy tab completion feature of z
zplug "zsh-users/zsh-autosuggestions"
# Install zsh-iterm-touchbar only for OS X
if [[ $platform == 'osx' ]]; then
    zplug "iam4x/zsh-iterm-touchbar"
fi
# Note that zsh-syntax-highlighting must be the last plugin sourced
zplug "zsh-users/zsh-syntax-highlighting", defer:2

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


# fzf
export PATH=$HOME/.fzf/bin:$PATH
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf/plugin/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh ] && source ~/.fzf/plugin/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh

# zsh-users/zsh-autosuggestions
if [[ $platform == 'wsl' ]]; then
    bindkey '^^' autosuggest-execute
fi