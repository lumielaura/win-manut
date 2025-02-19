# Coleta de informações
Show-SubMenu ($subTitle = "$coleta");

"`nDigite as LETRAS do Hostname:`nEx: Digite: GTI";
$hlet2 = Read-Host "LETRAS do Hostname";
$hlet = $hlet2.toUpper();

"`nDigite os NUMEROS do Hostname:`nEx: Digite: 17";
$hnum = Read-Host "NUMEROS do Hostname";

"`nVoce Deseja alterar as configucoes de IP?";
$resIp = Read-Host "[S] Sim, [N] Nao";

"`nVocê deseja desabilitar a conta local do usuario padrao?";
$locDRes = Read-Host "[S] Sim, [N] Nao";

"`nVocê deseja particionar o HD?";
$hdpart = Read-Host "[S] Sim, [N] Nao";