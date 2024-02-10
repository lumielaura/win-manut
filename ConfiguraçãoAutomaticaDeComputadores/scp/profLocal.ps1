Show-SubMenu ($subTitle = "$mcl1");

# Coletando Passwd Manualmente
# $lpass = Read-Host -AsSecureString "Digite a senha de Administrador Local";
# $passwd = ConvertTo-SecureString –AsPlainText -Force -String $lpass

# Coletando Passwd Automáticamente
$passwd = ConvertTo-SecureString –AsPlainText -Force -String chmod@rwx

Enable-LocalUser -name 'administrador'
Set-LocalUser -Name 'administrador' -Password $passwd

Get-LocalUser | Where-Object { $_.Enabled -eq "True" } | Format-Table;

if ($locDRes -eq "S" -and $hlet -like "???*") {

    Disable-LocalUser -Name $hlet;
    Get-LocalUser -Name $hlet;

} elseif ($locDRes -eq "S") {

    "`nParece que faltam algumas informacoes para executar este comando.`nDigite o nome de usuario que voce deseja desabilitar.";
    $hlet = Read-Host "Nome do usuario";
    Disable-LocalUser -Name $hlet;
    Get-LocalUser -Name $hlet;

}