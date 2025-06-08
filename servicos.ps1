if ($Mkey -eq 'Pass') 
{    
    Show-SubMenu ($subTitle = "$mse1");
}
Unblock-File $PSScriptRoot\Menu.ps1 -ErrorAction SilentlyContinue;

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


# Desativar modo de hibernação
powercfg -h off

# Listar modelos de energia
powercfg /L
$powerScheme = Read-Host "Copie a GUID do modelo de energia de ALTO DESEMPENHO.`nGUID: "

# Ativar plano de energia de alto desempenho
powercfg /setactive $powerScheme

# Este plano foi feito para computadores de mesa
# desligar video 
powercfg /change monitor-timeout-ac 60

# suspender atividade (0 = nunca)
powercfg /change standby-timeout-ac 0

# suspender atividade HD
powercfg /change disk-timeout-ac 20

# exportando energyScheme
# powercfg /export $HOME\documents\energyScheme.pow  8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

# powercfg /L | Select-String -Pattern "[0-9,a-z]*-[0-9,a-z]*-[0-9,a-z]*-[0-9,a-z]*-[0-9,a-z]* " -CaseSensitive