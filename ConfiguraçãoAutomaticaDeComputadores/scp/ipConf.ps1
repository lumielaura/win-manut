Show-SubMenu ($subTitle = "$mip1");

# Variáveis
$rede = '10.156.9.';
$rprod1 = '192.168.250.7';
$rprod2 = '192.168.250.8';

# Limpar configurações da rede Wi-Fi
Remove-NetIPAddress -InterfaceAlias Wi-Fi -Confirm:$false;
Remove-NetRoute -InterfaceAlias Wi-Fi -Confirm:$false;

# Configurar rede Wi-Fi
New-NetIPAddress -InterfaceAlias Wi-Fi -IPAddress ($rede + $hnum) -AddressFamily IPv4 -PrefixLength 24 -DefaultGateway "$rede`1";
Set-DnsClientServerAddress -InterfaceAlias Wi-Fi -ServerAddresses "$rede`2", "$rede`4", "$rprod1", "$rprod2";

# Status da rede
Get-NetIPConfiguration -InterfaceAlias Wi-Fi -Detailed;
Get-DnsClientServerAddress -InterfaceAlias Wi-Fi;