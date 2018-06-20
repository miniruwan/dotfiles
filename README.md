# configs
### Introduction
This repository includes the configuration files like vimrc, bashrc, zshrc
### How to use
1. Clone the repository to the folder that you keep cloned projects
2. Copy config.local.example.zshrc to config.local.zshrc
3. Edit the config.local.zshrc according to your local configurations
4. Then refer to the cloned files as follows (Append following to your current configuration file)
#### zsh
```bash
source <pathToClonedDirectory>/config.local.zshrc
```
#### Vim
Step 1: Install awsome vimrc
```vim
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime   
" Add the following line to ~/.vimrc file
source ~/.vim_runtime/vimrcs/basic.vim
```
Step 2: Install vim plugin manager  
```vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim  
```
Step 3: Source this repo's vimrc
```vim
source <pathToClonedDirectory>/vim/config.vim
```
Step 4: Open vim and type ":PlugInstall"

#### Other configurations
Refer init.sh for other configurations including,

 - tmux
 - vscode

 Enjoy!
 ![alt text](https://scontent-sin6-1.xx.fbcdn.net/v/t31.0-1/c1105.233.223.223/s160x160/28337662_10216090704568247_617738601527671289_o.jpg?_nc_cat=0&oh=6e2a57b1076e0dbcde6c92a67d6eb18f&oe=5B530E37)
