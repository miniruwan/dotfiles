Set-Alias -Name v -Value nvim

$env:EDITOR = "C:\Program Files\Neovim\bin\nvim.exe"
Set-PSReadLineOption -EditMode Vi

$localConfig = Join-Path -Path $PSScriptRoot -ChildPath 'config.local.ps1'
if (Test-Path -Path $localConfig) {
	. $localConfig
}