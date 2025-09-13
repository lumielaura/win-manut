# Coleta de informações

$hlet2 = Read-Host "`nDigite as LETRAS do Hostname:`nEx: Digite: GTI`nLETRAS do Hostname";
$hlet = $hlet2.toUpper();

$hnum = Read-Host "`nDigite os NUMEROS do Hostname:`nEx: Digite: 17`nNUMEROS do Hostname";

$resIp = Read-Host "`nVoce Deseja alterar as configucoes de IP?`n[S] Sim, [N] Nao";

$locDRes = Read-Host "`nVocê deseja desabilitar a conta local do usuario padrao?`n[S] Sim, [N] Nao";

$hdpart = Read-Host "`nVocê deseja particionar o HD?`n[S] Sim, [N] Nao";


# Definindo Aplicação SendKeys (Contribuição Edson Leal)
# $wshell = New-Object -ComObject wscript.shell;
# $wshell.SendKeys("{ENTER}");