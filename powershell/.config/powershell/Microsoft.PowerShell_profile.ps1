clear-host
oh-my-posh init pwsh --config ~/.config/powershell/config.json | Invoke-Expression
Set-PSReadLineOption -PredictionSource History

@(
    "cat,get-content"
    "cd,set-location"
    "clear,clear-host"
    "cp,copy-item"
    "history,get-history"
    "kill,stop-process"
    "ls,Get-ChildItem"
    "mv,move-item"
    "ps,get-process"
    "pwd,get-location"
    "which,get-command"
    "open,Invoke-Item"
    "basename,Split-Path"
    "realpath,resolve-path"
) | ForEach-Object {
    $Alias = ($PSItem -split ",")[0]
    $value = ($PSItem -split ",")[1]
    Set-Alias -Name $Alias -Value $value -Option AllScope
}

$env:POWERSHELL_TELEMETRY_OPTOUT = 1
$env:DOTNET_CLI_TELEMETRY_OPTOUT = 1
