# prerequisite : PROJECT_DIR is defined (It is defined in ../config.zshrc)

# Some variables to be used later in this file
PLUGIN_ROOT_DIR=$PROJECT_DIR/temasys-webrtc-plugin
PLUGIN_BUILD_DIR_NAME='BUILD_AUTO'

alias zshrcTem='vim $PROJECT_DIR/configs/Temasys/temasys.zshrc'
alias tp='cd $PLUGIN_ROOT_DIR/Tests/AdapterJS/tests; karma start --browsers Safari'
alias cdt='cd $PLUGIN_ROOT_DIR'
alias cds='cd $PLUGIN_ROOT_DIR/plugin_src'
alias cdc='cd $PLUGIN_ROOT_DIR/plugin_src/temasys-webrtcplugin-configs'
alias cda='cd $PLUGIN_ROOT_DIR/Tests/AdapterJS'
alias rmb='rm -rf $PLUGIN_ROOT_DIR/$PLUGIN_BUILD_DIR_NAME/'
alias lastconfigure='vim `ls -t $PLUGIN_ROOT_DIR/$PLUGIN_BUILD_DIR_NAME/Testing/Temporary/LastConfigure* | head -1`'
alias lastbuild='vl $PLUGIN_ROOT_DIR/$PLUGIN_BUILD_DIR_NAME/Testing/Temporary/LastBuild*'


if [[ `uname` == 'Darwin' ]] then # Mac
    alias cdl='cd ~/Library/Application\ Support/TemWebRTCPlugin/logs'
    alias lsp='\
        echo "----------------------- ~/Library/Internet Plug-Ins/ --------------------------"; \
        ls -lt ~/Library/Internet\ Plug-Ins/; \
        echo "------------------------ /Library/Internet Plug-Ins/ --------------------------"; \
        ls -lt /Library/Internet\ Plug-Ins/'
elif [[ `uname` == 'CYGWIN'* ]] then # Windows
    alias cdl='cd /cygwindrive/c/Users/Miniruwan/AppData/LocalLow/TemWebRTCPlugin/logs'
fi

# echo plugin build directory (used in other functions in this file)
function echoBuildProject
{
    if (( $# != 0 )) then
        # Only one project is there inside projects directory. So, * will match it.
        echo $PLUGIN_ROOT_DIR/$PLUGIN_BUILD_DIR_NAME/build_$1/projects/*
    else
        dirname $(dirname $(dirname $(dirname $(grep YAML_CPP_BINARY_DIR $PLUGIN_ROOT_DIR/$PLUGIN_BUILD_DIR_NAME/CMakeCache.txt | grep -o "\/.*"))))
    fi
}

# cd to plugin project build directory
function cdb
{
    cd `echoBuildProject $1`
}

# Run ctest configure for plugin project
function confp
{
    cdt
    if (( $# != 0 )) then
        ctest -S CTestScript.cmake -DPLUGIN_CONFIG_LIST=$1 -DCMAKE_BUILD_TYPE=Debug -V -DNO_TESTS=ON
    else
        ctest -S CTestScript.cmake -DPLUGIN_CONFIG_LIST="Temasys-universal-trial" -DCMAKE_BUILD_TYPE=Debug -V -DNO_TESTS=ON
    fi
    showWindowsMessageBox "Configure and Build Finished"
}

# grunt publish adapter.js
function gruntpublish
{
    cda
    grunt publish --pluginInfoRoot=`echoBuildProject $1`/gen/global/
    cp publish/adapter.screenshare.js $PROJECT_DIR/Google-WebRTC-Samples/src/js/adapter.js
}

# build plugin project
function bp
{
    if [[ `uname` == 'Darwin' ]] then # Mac
        cdb $1
        xcodebuild -target install -project TemWebRTCPlugin.xcodeproj
        #osascript -e 'display notification "Plugin Build done." with title "Build"'
    elif [[ `uname` == 'CYGWIN'* ]] then # Windows
		cd $PLUGIN_ROOT_DIR/$PLUGIN_BUILD_DIR_NAME
        if (( $# != 0 )) then
            MSBuild.exe plugin.sln "/p:VisualStudioVersion=14.0" "/t:$1" 
        else
            MSBuild.exe plugin.sln "/p:VisualStudioVersion=14.0" "/t:TemWebRTCPlugin" 
        fi
        showWindowsMessageBox "Build Finished"
    fi
}

# install plugin
function ip
{
    if [[ `uname` == 'Darwin' ]] then # Mac
        # remove existing plugin first
        rm -rf ~/Library/Internet\ Plug-Ins/npTemWebRTCPlugin.plugin/
        # install new plugin
        cdb $1
        cmake -DBUILD_TYPE=Debug -P cmake_install.cmake
    elif [[ `uname` == 'CYGWIN'* ]] then # Windows
        if (( $# != 0 )) then
            regsvr32 `cygpath -d $PLUGIN_ROOT_DIR/$PLUGIN_BUILD_DIR_NAME/build_$1/bin/TemWebRTCPlugin/Debug/npTemWebRTCPlugin.dll`
        else
            regsvr32 `cygpath -d $PLUGIN_ROOT_DIR/$PLUGIN_BUILD_DIR_NAME/build_Temasys-universal-trial/bin/TemWebRTCPlugin/Debug/npTemWebRTCPlugin.dll`
        fi
    fi
}

# uninstall plugin
function up
{
    if [[ `uname` == 'Darwin' ]] then # Mac
        echo "++++++++++++++++++++++++++++++++ BEFORE ++++++++++++++++++++++++++++++++";
        lsp;
        echo "++++++++++++++++++++++++++++++ DELETING... +++++++++++++++++++++++++++++";
        rm -rf ~/Library/Internet\ Plug-Ins/npTemWebRTCPlugin.plugin/;
        sudo rm -rf /Library/Internet\ Plug-Ins/npTemWebRTCPlugin.plugin/;
        echo "+++++++++++++++++++++++++++++++++ AFTER +++++++++++++++++++++++++++++++";
        lsp
    elif [[ `uname` == 'CYGWIN'* ]] then # Windows
        if (( $# != 0 )) then
            regsvr32 /u `cygpath -d $PLUGIN_ROOT_DIR/$PLUGIN_BUILD_DIR_NAME/build_$1/bin/TemWebRTCPlugin/Debug/npTemWebRTCPlugin.dll`
        else
            regsvr32 /u `cygpath -d $PLUGIN_ROOT_DIR/$PLUGIN_BUILD_DIR_NAME/build_Temasys-universal-trial/bin/TemWebRTCPlugin/Debug/npTemWebRTCPlugin.dll`
        fi
    fi
}

# grep in plugin excluding some directories
function exgrep 
{
    cdt
    grep -R --exclude-dir={$PLUGIN_BUILD_DIR_NAME,WebRTC,ThirdParty,firebreath,LogServer,AutoBuildServer,Tests} "$1" .
}
