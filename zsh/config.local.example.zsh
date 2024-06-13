# The place where the config files are located
CONFIG_DIR=${0:a:h:h}

# Source the config.zsh which is the main zsh file
source $CONFIG_DIR/zsh/config.zsh

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Doing above enough for the functionality.
# Below are some examples of things you can add.
# ===============================================================


# The place where projects are cloned
PROJECT_DIR=/mnt/c/Projects

# Exports
# =======
export EDITOR=nvim
export PATH=$PATH:'/mnt/c/Program Files (x86)/Microsoft SDKs/Azure/Storage Emulator'
export REQUESTS_CA_BUNDLE=/mnt/c/ProgramData/netskope/stagent/download/nscacert_combined.pem

# Project Directories
export IMPORTS_PROJECT_ROOT_DIR=$PROJECT_DIR/Wallace/Rifleman.Imports/Rifleman.Imports
export IMPORTING_API_PROJECT_DIR=$IMPORTS_PROJECT_ROOT_DIR/Rifleman.Imports.Api
export FUNCTIONS_PROJECT_DIR=$IMPORTS_PROJECT_ROOT_DIR/Rifleman.Imports.Functions

export GLOBAL_ADMIN_PROJECT_DIR=$PROJECT_DIR/Wallace/Rifleman.GlobalAdmin/Rifleman.GlobalAdmin
export RIFLEMAN_WEB_PROJECT_DIR=$PROJECT_DIR/Wallace/Rifleman/RiflemanWeb/RiflemanWeb


# Aliases
# =======

alias v='nvim'

# cd to some project directories
alias cdr='cd $PROJECT_DIR/Wallace/Rifleman/RiflemanWeb'
alias cdi='cd $IMPORTING_API_PROJECT_DIR'
alias cdg='cd $PROJECT_DIR/Wallace/Rifleman.GlobalAdmin'
alias cdf='cd $FUNCTIONS_PROJECT_DIR'

# build some projects
alias buildr='cdr && MSBuild.exe RiflemanWeb.sln'
alias buildi='cd $IMPORTING_API_PROJECT_DIR && dotnet build'
alias buildg='cd $GLOBAL_ADMIN_PROJECT_DIR && dotnet build'

alias rung='cd $GLOBAL_ADMIN_PROJECT_DIR && dotnet run'

alias copydll='cp /mnt/c/Projects/Wallace/Rifleman.Imports/Rifleman.Imports/Rifleman.Imports.Client/Rifleman.Imports.Client/bin/Debug/netstandard2.0/Rifleman.Imports.Client.dll /mnt/c/Projects/Wallace/Rifleman.GlobalAdmin/ImportsClientLibrary/Rifleman.Imports.Client.dll'

function runr
{
    cdr

    # Checkout branch and build if branch name is provided
    if (( # != 0 )); then
        git fetch && \
        git switch $1 && \
        git pull && \
        buildr
    fi

    # Open localhost
    #/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe --profile-directory="Default" "http://localhost:57204/Property/Details/50633?propertyTab=14"

    # Run
    iisexpress /config:C:/Projects/Wallace/Rifleman/RiflemanWeb/.idea/config/applicationhost.config /site:RiflemanWeb /apppool:Clr4IntegratedAppPool
}

function runi
{
    cd $IMPORTING_API_PROJECT_DIR

    [[ $(AzureStorageEmulator.exe status) == *False* ]] && AzureStorageEmulator.exe start

    dotnet run $1
}

function runf
{
    cdf

    [[ $(AzureStorageEmulator.exe status) == *False* ]] && AzureStorageEmulator.exe start

    func start $1
}

function testr
{
    cdr

    # Checkout branch and build if branch name is provided
    if (( # != 0 )); then
        git fetch && \
        git switch $1 && \
        git pull && \
        buildr
    fi

    # Run the tests
    packages/xunit.runner.console.2.4.1/tools/net472/xunit.console.exe $(find . -type f -regex ".*/bin/Debug/.*Tests\.dll")
}

function integration_tests
{
    tmux new -s integration_tests -d
    tmux split-window -p 40
    tmux split-window -h
    tmux send -t integration_tests:1.2 "runi IntegrationTests" C-m
    tmux send -t integration_tests:1.3 "runf IntegrationTests" C-m
    tmux send -t integration_tests:1.1 'cd $IMPORTS_PROJECT_ROOT_DIR/IntegrationTests/Rifleman.Importing.IntegrationTests' C-m
    tmux send -t integration_tests:1.1 "dotnet test"
    tmux select-pane -t 1
    tmux attach-session -t integration_tests
}
