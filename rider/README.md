# Jetbrains Rider IDE Configurations
## Introduction
This directory includes my configuration files for [Rider](https://www.jetbrains.com/rider/)

### Keymaps
These keymaps are mainly because some of the default keymaps conflicts with ideavim plugin's keys. So I've remapped them.
Symlink to this file from the Rider's configuration directory.

Example:

```mklink C:\Users\MiniruwanMangala\AppData\Roaming\JetBrains\Rider2023.3\keymaps\Miniruwan.xml C:\dotfiles\rider\keymaps\Miniruwan.xml```

## Jetbrains IdeaVim Plugin Configurations
### Introduction
Configuration files for [IdeaVim](https://plugins.jetbrains.com/plugin/164-ideavim) plugin is at [vim](./vim) directory

### How to use vim_settings.xml
This file defines which key combinations are handled by IDE, and which are handled by the plugin.

Symlink to this file from IntelliJ platform based IDE's configuration directory.

Example for Jetbrains Rider IDE:

```mklink C:\Users\MiniruwanMangala\AppData\Roaming\JetBrains\Rider2023.3\options\vim_settings.xml C:\dotfiles\rider\vim\vim_settings.xml```

### How to use ideavimrc
Source the [ideavimrc](./vim/ideavimrc) file.

```mklink C:\Users\MiniruwanMangala\.ideavimrc C:\dotfiles\rider\vim\ideavimrc```