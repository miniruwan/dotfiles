# Installs necessary tools via winget.
winget install ajeetdsouza.zoxide
winget install sharkdp.fd
winget install psmux
winget install --id GitHub.cli --source winget
winget install jqlang.jq
winget install fzf

# Chris Titus Tech's PowerShell profile setup.
# Source: https://github.com/ChrisTitusTech/powershell-profile
irm https://github.com/ChrisTitusTech/powershell-profile/raw/main/setup.ps1 | iex