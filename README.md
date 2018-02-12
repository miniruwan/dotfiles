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
```vim
source <pathToClonedDirectory>/config.vim
```
#### Vim Plugin Installation
Step 1: Install awsome vim  
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime   
sh ~/.vim_runtime/install_awesome_vimrc.sh  

Step 2: Create dir to hold vim plugins   
cd ~   
mkdir -p .vim   

Step 3: Install vim plugin manager  

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim  

Step 4: Open vim and type ":PlugInstall"
