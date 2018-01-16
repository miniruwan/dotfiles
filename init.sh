#!/bin/bash

# ========== General script ==========
# Detect platform
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
	  platform='freebsd'
fi

if [[ $platform == 'linux' ]]; then
    sudo apt-get update
fi


# ================= Configurations =====================

# Install and configure tmux
if [[ $platform == 'linux' ]]; then
    sudo apt-get install tmux
fi
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

# Install powerline font
if [[ $platform == 'linux' ]]; then
    sudo apt-get install fonts-powerline
fi

# Install Zenburn-for-Terminator
if [[ $platform == 'linux' ]]; then
    mkdir -p ~/.config/terminator/
    wget -O ~/.config/terminator/config https://raw.githubusercontent.com/alinmindroc/Zenburn-for-Terminator/master/config
fi

# Install gitkraken
if [[ $platform == 'linux' ]]; then
	wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
	sudo dpkg -i gitkraken-amd64.deb
fi
