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
export EDITOR=/usr/local/bin/vim
export PATH=$PATH:'/mnt/c/Program Files (x86)/Microsoft SDKs/Azure/Storage Emulator'

# Project Directories
export IMPORTING_API_PROJECT_DIR=$PROJECT_DIR/Wallace/Rifleman.Imports/Rifleman.Importing.Api/Rifleman.Importing.Api
export FUNCTIONS_PROJECT_DIR=$PROJECT_DIR/Wallace/Rifleman.Imports/Rifleman.Importing.Functions/Rifleman.Importing.Functions
export SHARED_PROJECT_DIR=$PROJECT_DIR/Wallace/Rifleman.Imports/Rifleman.Importing.Shared
export GLOBAL_ADMIN_PROJECT_DIR=$PROJECT_DIR/Wallace/Rifleman.GlobalAdmin/Rifleman.GlobalAdmin
export RIFLEMAN_WEB_PROJECT_DIR=$PROJECT_DIR/Wallace/Rifleman/RiflemanWeb/RiflemanWeb


# Aliases
# =======

alias v='vim'

# cd to some project directories
alias cdr='cd $PROJECT_DIR/Wallace/Rifleman'
alias cdi='cd $PROJECT_DIR/Wallace/Rifleman.Imports'
alias cdg='cd $PROJECT_DIR/Wallace/Rifleman.GlobalAdmin'

# run some projects
alias rung='cd $GLOBAL_ADMIN_PROJECT_DIR && dotnet run'

# build some projects
alias buildr='cdr && MSBuild.exe'
alias buildi='cd $IMPORTING_API_PROJECT_DIR && dotnet build'
alias buildg='cd $GLOBAL_ADMIN_PROJECT_DIR && dotnet build'



# Functions
# =========

function runi
{
    cdi

    [[ $(AzureStorageEmulator.exe status) == *False* ]] && AzureStorageEmulator.exe start

    dotnet run
}

function runf
{
    cdf

    [[ $(AzureStorageEmulator.exe status) == *False* ]] && AzureStorageEmulator.exe start

    func start
}

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
    /mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe --profile-directory="Default" "http://localhost:57204/Property/Details/50633?propertyTab=14"

    # Run
    iisexpress /config:C:/Projects/Wallace/Rifleman/RiflemanWeb/.idea/config/applicationhost.config /site:RiflemanWeb /apppool:Clr4IntegratedAppPool
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
