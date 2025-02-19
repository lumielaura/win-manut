if ($Mkey -eq 'Pass') 
{    
    Show-SubMenu ($subTitle = "$mse1");
}
Unblock-File $PSScriptRoot\Menu.ps1;

# Alterando os serviços windows de acordo com a política da empresa
# Disabilitando servicos
'Fax','SysMain','diagnosticshub.standardcollector.service','WMPNetworkSvc','SuperFetch','wscsvc','WSearch','TermService','WerSvc','BDESVC','WbioSrvc','SessionEnv','WpcMonSvc','SCardSvr' |
ForEach-Object -Process {
    
    Set-Service -Name "$_" -StartupType Disabled -ErrorAction SilentlyContinue;

}

# Serviço Manual - Raramente usado
'DiagTrack','MapsBroker','lmhosts','iphlpsvc','DPS','SDRSVC','stisvc' |
ForEach-Object -Process {
    
    Set-Service -Name "$_" -StartupType Manual -ErrorAction SilentlyContinue;

}

# Habilitando servicos
'RpcLocator','Spooler','wuauserv','msiserver' |
ForEach-Object -Process {
    
    Set-Service -Name "$_" -StartupType Automatic -ErrorAction SilentlyContinue;
    Start-Service -Name "$_" -ErrorAction SilentlyContinue;

}


# Modificando as chaves de registro visando melhora de desempenho
# evitando problema com hd 100%
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" ClearPageFileAtShutdown -Value 1 -ErrorAction SilentlyContinue;

Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\SYSTEM\CurrentControlSet\Services\Schedule" Start -Value 4 -ErrorAction SilentlyContinue;

