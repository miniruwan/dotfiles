# Jetbrains IdeaVim Plugin Configurations
### Introduction
This directory includes my configuration files for [IdeaVim](https://plugins.jetbrains.com/plugin/164-ideavim) plugin.

### How to use
#### vim_settings.xml
This file defines which key combinations are handled by IDE, and which are handled by the plugin.

Symlink to this file from IntelliJ platform based IDE's configuration directory.
Example for Jetbrains Rider IDE:
```mklink C:\Users\miniruwan.mangala\.Rider2019.3\config\options\vim_settings.xml C:\Projects\dotfiles\vim\Jetbrains_Rider\vim_settings.xml```

#### ideavimrc
Source the [ideavimrc](../ideavimrc) file.

#### Keymaps
You might need to change some of IDE's conflicting key mappings.
Refer [rider](../../rider) directory for KeyMapping files.
