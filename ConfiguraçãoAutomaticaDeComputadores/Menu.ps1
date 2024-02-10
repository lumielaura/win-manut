# Script criado por Anderson Machado.
# Email: anderson.machado@sims.ap.gov.br

# Objetivo: Este Script foi criado para auxiliar no LENTO processo de manutenção de computadores da empresa onde trabalho, agilizar os procedimentos, assim, diminuindo a carga de trabalho de todos os funcionários do setor de técnologia.

# Desbloqueando script
$policy = Get-ExecutionPolicy CurrentUser;
if ($policy -eq "Unrestricted")
{
    Unblock-File $PSScriptRoot\Menu.ps1; Unblock-File $PSScriptRoot\scp\servicos.ps1; Unblock-File $PSScriptRoot\scp\coleta.ps1; Unblock-File $PSScriptRoot\scp\profLocal.ps1; Unblock-File $PSScriptRoot\scp\partDisk.ps1; Unblock-File $PSScriptRoot\scp\programas.ps1; Unblock-File $PSScriptRoot\scp\winUpdate.ps1; Unblock-File $PSScriptRoot\scp\servicos.ps1; Unblock-File $PSScriptRoot\scp\status.ps1;
    Set-ExecutionPolicy RemoteSigned CurrentUser;
}

# Definindo Variaveis
$mbar = '='*90;
$Mkey = 'Pass';
# $mbar = '='*[console]::WindowWidth;
# [console]::BackgroundColor = "red";
$empresa = 'Manutenção de Computadores';
$pnece = 'Instalacao de programas necessarios';
$coleta = 'Coleta Basica de Informacoes';
$escolha = 'Voce Escolheu a Opcao';
$cadeira = 'Todas as Opcoes Abaixo';
$mip1 = 'Modificar as Configuracoes de Rede (Wi-Fi - IP Estatico)';
$mip2 = 'Modificar as Configuracoes de Rede (Wi-Fi - DHCP)';
$mpr1 = "Instalar Automaticamente os Programas";
$mse1 = 'Modificar e Iniciar os Serviços do Windows';
$mcl1 = 'Ativar a Conta de Administrador Local';
$mpm1 = 'Instalar Programas Restantes (manual)';
$wup1 = 'Atualizar o Windows';
$ingre = 'Ingressar o Computador no Dominio';
$sta1 = 'Mostrar o Status Atual do Computador';
$part = 'Particionar Disco e Mudar Perfil Padrao Users';
$addNet = "Adicionar conexão da rede (Wi-Fi)";
$irsat = 'Instalar RSAT';

# Função - Centralizar texto
function Write-HostCenter 
{ 
    param($Message) Write-Host ("{0}{1}" -f (' ' * (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Floor($Message.Length / 2)))), $Message)
}

# Função - Menu
function Show-Menu {

    param ([string]$Title = "Script $empresa")

    Clear-Host    
    Write-HostCenter "$mbar";
    Write-HostCenter "$Title";
    Write-HostCenter "$mbar";
    "`n`tNome do Computador: $hlet$hnum
    `n`tDigite
    `t1: $cadeira.`n
    `t2: $mse1.
    `t3: $wup1.
    `t4: $mpr1.
    `t5: $mip1.
    `t6: $ingre. (Atalho)
    `t7: $mpm1.
    `t8: $mcl1.
    `t9: $sta1.`n";
    Write-HostCenter "$mbar";
    Write-HostCenter "Opções Extras";
    Write-HostCenter "$mbar";
    "`n`tDigite
    `t10: $mip2.
    `t11: $part. (Em Teste)
    `t12: $addNet. (Em Teste)
    `t13: $irsat.
    `n`tS: Digite 'S' para sair.`n";
}

# Função - SubMenu
function Show-SubMenu {

    param ([string]$subTitle)

    Clear-Host
    "$escolha`n";
    Write-HostCenter "$mbar";
    Write-HostCenter "$subTitle";
    Write-HostCenter "$mbar`n";

}

# Definindo Aplicação SendKeys (Contribuição Edson Leal)
# $wshell = New-Object -ComObject wscript.shell;
# $wshell.SendKeys("{ENTER}");

do {
    Show-Menu
    $opcao = Read-Host "Por favor, digite uma opcao";
    switch ($opcao)
    {
        '1' 
        {
            # Todas as Opcoes Abaixo
            & "$PSScriptRoot\scp\servicos.ps1";
            & "$PSScriptRoot\scp\coleta.ps1";
            
            # Renomear computador
            if ( $hlet -like "???*" -and $hnum -like "?*" ) 
            {
                Rename-Computer -NewName "$hlet$hnum";
            }
            
            # Configurar rede
            if ($resIp -eq 'S' -and $hnum -like "?*" ) 
            { 
                # & "$PSScriptRoot\netwk\netwk.ps1";
                & "$PSScriptRoot\scp\ipConf.ps1";        
            }
            
            & "$PSScriptRoot\scp\profLocal.ps1";
            
            # particionar hd
            if ($hdpart -eq 'S') 
            { 
                & "$PSScriptRoot\scp\partDisk.ps1";
            }

            & "$PSScriptRoot\scp\programas.ps1"; 
            & "$PSScriptRoot\scp\winUpdate.ps1"; 
            & "$PSScriptRoot\scp\servicos.ps1";
            & "$PSScriptRoot\scp\status.ps1";
            & SystemPropertiesComputerName;
            "Pressione <ENTER> para Reiniciar o computador";
            Pause;
            Restart-Computer;
        } 

        '2' 
        {            
            # Modificar e Iniciar os Serviços do Windows
            & "$PSScriptRoot\scp\servicos.ps1";
        } 

        '3' 
        {            
            # Atualizar o Windows
            & "$PSScriptRoot\scp\winUpdate.ps1";
            Restart-Computer;
        } 
        
        '4' 
        {            
            # Instalar Automaticamente os Programas da SEAS
            & "$PSScriptRoot\scp\programas.ps1";
        } 
        
        '5' 
        {            
            Show-SubMenu ($subTitle = "$coleta");

            "`nDigite os NUMEROS do Hostname:`nEx: Digite: 17";
            $hnum = Read-Host "NUMEROS do Hostname";

            # Modificar as Configuracoes de Rede (Wi-Fi - IP Estatico)
            if ($hnum -like "?*" ) 
            { 
                & "$PSScriptRoot\scp\ipConf.ps1"; 
            } 
        } 
        
        '6' 
        {            
            # Ingressar o Computador no Dominio
            Show-SubMenu ($subTitle = "$ingre");

            & SystemPropertiesComputerName;
        } 

        '7' 
        {            
            # Instalar Programas Restantes (manual)
            & "$PSScriptRoot\scp\progMan.ps1";
        } 
        
        '8' 
        {            
            # Ativar a Conta de Administrador Local
            & "$PSScriptRoot\scp\profLocal.ps1";
        } 
        
        '9' 
        {            
            # Mostrar o Status Atual do Computador
            & "$PSScriptRoot\scp\status.ps1";
        } 
        
        '10' 
        {            
            # Modificar as Configuracoes de Rede (Wi-Fi - DHCP)
            Show-SubMenu ($subTitle = "$mip2");

            Remove-NetIPAddress -InterfaceAlias Wi-Fi -Confirm:$false;
            Remove-NetRoute -InterfaceAlias Wi-Fi -Confirm:$false;
            Set-NetIPInterface -InterfaceAlias Wi-Fi -DHCP enabled;
        } 
        
        '11' 
        {            
            # Particionar Disco e Mudar Perfil Padrao Users
            & "$PSScriptRoot\scp\partDisk.ps1";
        }  
        
        '12' 
        {            
            # Adicionar conexão da rede SIMS/AP (Wi-Fi)
            & "$PSScriptRoot\netwk\netwk.ps1";
        }  
        
        '13' 
        {            
            # Instalar RSAT
            Show-SubMenu ($subTitle = "$irsat");

            # Get-WindowsCapability -Name rsat* -online | Select-Object -Property Name, State;
            # Get-WindowsCapability -name rsat* -online | Add-WindowsCapability –Online;
            Get-WindowsCapability -Name "Rsat.ActiveDirectory.*" -online | Add-WindowsCapability –Online;
        }  
        
        '14' 
        {            
            # Testes
        } 
        
        's' 
        {            
            return
        }
    }
    pause
}
until ($opcao -eq 's')