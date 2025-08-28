Show-SubMenu
# Show-SubMenu ($subTitle = "$sta1");

# mandar o valor para variável
# $Today = (Get-Date).DayOfWeek

# vendo todas as propriedades de um objeto
# get-Service -Name Fax | select-Object -Property *;

# Get-WinEvent -FilterHashtable @{LogName="Security"; id=4726} | Format-Table -AutoSize;

# configurações basicas do computador
Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property Name,PrimaryOwnerName,Domain,UserName,SystemType,TotalPhysicalMemory | Format-Table;
"`n";

# SERVIÇOS
# ver se os serviços foram modificados 
Get-Service -Name 'Fax','SysMain','diagnosticshub.standardcollector.service','WMPNetworkSvc','SuperFetch','wscsvc','WSearch','TermService','WerSvc','BDESVC','WbioSrvc','SessionEnv','WpcMonSvc','SCardSvr' -ErrorAction SilentlyContinue | Select-Object -Property StartType,Status,DisplayName | Format-Table;
Get-Service -Name 'DiagTrack','MapsBroker','lmhosts','iphlpsvc','DPS','SDRSVC','stisvc' -ErrorAction SilentlyContinue | Select-Object -Property StartType,Status,DisplayName | Format-Table;
Get-Service -Name 'RpcLocator','Spooler','wuauserv','msiserver' -ErrorAction SilentlyContinue | Select-Object -Property StartType,Status,DisplayName | Format-Table;
"`n";

# DISCOS
# ver todos os discos que tenham nome
# Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | Where-Object { $_.VolumeName -like "?*" }  | Select-Object -Property DeviceID,VolumeName,Size,FreeSpace;

# ver os discos do sistema de arquivos
Get-PSDrive -PSProvider FileSystem;
"`n";

# CONTAS
# Ver todas as Contas do computador
# Get-CimInstance -ClassName Win32_NetworkLoginProfile | Where-Object {$_.userid -like "?*"} | Format-Table

# Ver as contas locais ativas
Get-localuser | where-object { $_.Enabled -eq "True" } | Select-Object -Property Enabled,SID,PrincipalSource,Name,FullName,LastLogon,PasswordLastSet;
"`n";

# REDE
# configurações rede wifi com maior detalhe
# netsh wlan show interfaces;

# ver as configurações do adaptador wifi 
Get-NetIPConfiguration -InterfaceAlias Wi-Fi* -Detailed | Select-Object -Property InterfaceAlias,InterfaceIndex,InterfaceDescription,IPv4Address;

# ver as configurações de DNS da interface wifi
Get-DnsClientServerAddress -InterfaceAlias Wi-Fi* | Select-Object -Property ElementName,InterfaceAlias,InterfaceIndex,ServerAddresses;
"`n";

# pegar a data atual
get-date -Format 'dd/MM/yyyy HH:mm'  ; 