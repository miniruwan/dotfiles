# Neovim configuration

This directory contains the Neovim configuration and is designed to work on
Windows, Linux, macOS, and WSL. Plugins are managed by
[lazy.nvim](https://github.com/folke/lazy.nvim) and are installed automatically
on the first launch.

## Requirements

- Neovim 0.10 or newer
- Git
- [ripgrep](https://github.com/BurntSushi/ripgrep) for searching
- A C compiler and `tree-sitter` CLI 0.26.1 or newer for Treesitter parsers
- Node.js/npm and Python 3 for language servers and editor providers
- Optional formatter executables used by Conform: `black`, `clang-format`,
  `prettier`, `shfmt`, and `stylua`

Run the following to install the Treesitter CLI when Rust is available:

```sh
cargo install tree-sitter-cli
```

## Windows setup

These instructions assume the repository is checked out at:

```text
C:\dotfiles
```

### Link only `init.lua`

Create Neovim's configuration directory from PowerShell:

```powershell
New-Item -ItemType Directory -Force "$env:LOCALAPPDATA\nvim" | Out-Null
```

Create the link with:

```powershell
cmd /c mklink "%LOCALAPPDATA%\nvim\init.lua" "C:\dotfiles\nvim\init.lua"
```

Move or remove an existing `%LOCALAPPDATA%\nvim\init.lua` before creating the
link. Creating symbolic links requires either Windows Developer Mode or an
elevated terminal.

Linking only `init.lua` is supported: it resolves its real path and loads the
`lua` directory beside the target file.

### Link the entire directory

As an alternative, link the complete configuration directory. The destination
`%LOCALAPPDATA%\nvim` must not already exist:

```powershell
cmd /c mklink /D "%LOCALAPPDATA%\nvim" "C:\dotfiles\nvim"
```

For two local NTFS paths, a directory junction usually does not require
Developer Mode or elevation:

```powershell
cmd /c mklink /J "%LOCALAPPDATA%\nvim" "C:\dotfiles\nvim"
```

## Linux, macOS, and WSL setup

From the repository root, use the setup script to install dependencies and
link this directory to `~/.config/nvim`:

```sh
./init.sh --nvim
```

To create only the link manually:

```sh
mkdir -p ~/.config
ln -s "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
```

Move or remove an existing `~/.config/nvim` before creating the manual link,
and adjust `$HOME/dotfiles` if the repository is elsewhere.

## Install and verify

Launch Neovim normally to bootstrap lazy.nvim and install plugins, or run a
headless synchronization:

```sh
nvim --headless "+Lazy! sync" +qa
```

Useful diagnostics inside Neovim:

```vim
:checkhealth
:Lazy
:Mason
```

To verify that the configuration loads without opening the UI:

```sh
nvim --headless "+lua print('Neovim configuration loaded')" +qa
```