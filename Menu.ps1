<#
.SYNOPSIS
	Deixa o computador pronto para uso no padrão da empresa.
.DESCRIPTION
    Este script powershell foi criado para configurar e instalar todos os programas necessários para o uso diário do usuário comum, assim, deixando o computador pronto para uso de acordo com os padrões da empresa. Privilégios de administrador são necessários.
.EXAMPLE
	PS> ./Menu.ps1
.LINK
	https://github.com/
.NOTES
	Autor: Anderson Costa
#>

# Desbloqueando script
$policy = Get-ExecutionPolicy CurrentUser;
if ($policy -eq "Unrestricted") {
    'servicos',
    'Menu',
    'scp\coleta',
    'scp\profLocal',
    'scp\partDisk',
    'scp\programas',
    'scp\winUpdate',
    'scp\status' | 
    ForEach-Object -Process {
    
        Unblock-File "$PSScriptRoot\$_.ps1" -ErrorAction SilentlyContinue;
    
    }
    Set-ExecutionPolicy RemoteSigned CurrentUser;
}

# Variaveis
$mbar = '=' * 90;
# $mbar = '='*[console]::WindowWidth;
# [console]::BackgroundColor = "red";
$empresa = 'Manutenção de Computadores';
$coleta = 'Coleta Basica de Informacoes';
$escolha = 'Voce Escolheu a Opcao';
$cadeira = 'Todas as Opcoes Abaixo';
$mip1 = 'Modificar as Configuracoes de Rede (Wi-Fi - IP Estatico)';
$mip2 = 'Modificar as Configuracoes de Rede (Wi-Fi - DHCP)';
$mpr1 = 'Instalar Automaticamente os Programas';
$mse1 = 'Modificar e Iniciar os Serviços do Windows';
$mcl1 = 'Ativar a Conta de Administrador Local';
$mpm1 = 'Instalar Programas Restantes (manual)';
$wup1 = 'Atualizar o Windows';
$ingre = 'Ingressar o Computador no Dominio';
$sta1 = 'Mostrar o Status Atual do Computador';
$part = 'Particionar Disco e Mudar Perfil Padrao Users';
$addNet = 'Adicionar conexão da rede (Wi-Fi)';
$irsat = 'Instalar RSAT';
$cript = 'Criar nova senha para o ADM';

# Função - Centralizar texto
function Write-HostCenter { 
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
    `t14: $cript.
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

do {
    Show-Menu
    $opcao = Read-Host "Por favor, digite uma opcao";
    switch ($opcao) {
        1 {
            # Todas as Opcoes Abaixo            
            Write-Progress -Activity "Progresso do Script: $mse1" -Status "Tarefa 1 de 10" -PercentComplete 10;
            & "$PSScriptRoot\servicos.ps1";
            
            Write-Progress -Activity "Progresso do Script: $coleta" -Status "Tarefa 2 de 10" -PercentComplete 20;
            & "$PSScriptRoot\scp\coleta.ps1";
            
            Write-Progress -Activity "Progresso do Script: Renomear Computador" -Status "Tarefa 3 de 10" -PercentComplete 30;
            # Renomear computador
            if ( $hlet -like "???*" -and $hnum -like "?*" ) { #modelo de nome da empresa
                Rename-Computer -NewName "$hlet$hnum";
            }

            # Configurar rede
            Write-Progress -Activity "Progresso do Script: $mip1" -Status "Tarefa 4 de 10" -PercentComplete 40;
            if ($resIp -eq 'S' -and $hnum -like "?*" ) { #modelo de rede da empresa  
                # & "$PSScriptRoot\netwk\netwk.ps1";
                & "$PSScriptRoot\scp\ipConf.ps1"; #IP estatico
            }
            
            Write-Progress -Activity "Progresso do Script: $mcl1" -Status "Tarefa 5 de 10" -PercentComplete 50;
            & "$PSScriptRoot\scp\profLocal.ps1";
            
            # particionar hd
            Write-Progress -Activity "Progresso do Script: $part" -Status "Tarefa 6 de 10" -PercentComplete 60;
            if ($hdpart -eq 'S') { 
                & "$PSScriptRoot\scp\partDisk.ps1";
            }
            
            Write-Progress -Activity "Progresso do Script: $mpr1" -Status "Tarefa 7 de 10" -PercentComplete 70;
            & "$PSScriptRoot\scp\programas.ps1"; 
            
            Write-Progress -Activity "Progresso do Script: $wup1" -Status "Tarefa 8 de 10" -PercentComplete 80;
            & "$PSScriptRoot\scp\winUpdate.ps1"; 
            
            Write-Progress -Activity "Progresso do Script: $mse1" -Status "Tarefa 9 de 10" -PercentComplete 90;
            & "$PSScriptRoot\servicos.ps1";
            
            Write-Progress -Activity "Todas as Tarefas Foram Finalizadas" -Status "Tarefa 10 de 10" -PercentComplete 100;
            & "$PSScriptRoot\scp\status.ps1";
            & SystemPropertiesComputerName.exe;
            Restart-Computer -Confirm;
        } 

        2 {            
            # Modificar e Iniciar os Serviços do Windows
            & "$PSScriptRoot\servicos.ps1";
        } 

        3 {            
            # Atualizar o Windows
            & "$PSScriptRoot\scp\winUpdate.ps1";
            Restart-Computer -Confirm;
        } 
        
        4 {            
            # Instalar Automaticamente os Programas da SEAS
            & "$PSScriptRoot\scp\programas.ps1";
        } 
        
        5 {            
            Show-SubMenu ($subTitle = "$coleta");

            "`nDigite os NUMEROS do Hostname:`nEx: Digite: 17";
            $hnum = Read-Host "NUMEROS do Hostname";

            # Modificar as Configuracoes de Rede (Wi-Fi - IP Estatico)
            if ($hnum -like "?*" ) { 
                & "$PSScriptRoot\scp\ipConf.ps1"; 
            } 
        } 
        
        6 {            
            # Ingressar o Computador no Dominio
            Show-SubMenu ($subTitle = "$ingre");
            & SystemPropertiesComputerName;
        } 

        7 {            
            # Instalar Programas Restantes (manual)
            & "$PSScriptRoot\scp\progMan.ps1";
        } 
        
        8 {            
            # Ativar a Conta de Administrador Local
            & "$PSScriptRoot\scp\profLocal.ps1";
        } 
        
        9 {            
            # Mostrar o Status Atual do Computador
            & "$PSScriptRoot\scp\status.ps1";
        } 
        
        10 {            
            # Modificar as Configuracoes de Rede (Wi-Fi - DHCP)
            Show-SubMenu ($subTitle = "$mip2");

            Remove-NetIPAddress -InterfaceAlias Wi-Fi -Confirm:$false;
            Remove-NetRoute -InterfaceAlias Wi-Fi -Confirm:$false;
            Set-NetIPInterface -InterfaceAlias Wi-Fi -DHCP enabled;
        } 
        
        11 {            
            # Particionar Disco e Mudar Perfil Padrao Users
            & "$PSScriptRoot\scp\partDisk.ps1";
        }  
        
        12 {            
            # Adicionar conexão da rede SIMS/AP (Wi-Fi)
            & "$PSScriptRoot\netwk\netwk.ps1";
        }  
        
        13 {            
            # Instalar RSAT
            Show-SubMenu ($subTitle = "$irsat");

            # Get-WindowsCapability -Name rsat* -online | Select-Object -Property Name, State;
            # Get-WindowsCapability -name rsat* -online | Add-WindowsCapability –Online;
            Get-WindowsCapability -Name "Rsat.ActiveDirectory.*" -online | Add-WindowsCapability –Online;
        }  
        
        14 {            
            # Nova senha ADM
            Show-SubMenu ($subTitle = "$cript");

            $caminho = "$PSScriptRoot\scp\101.txt";
            Read-Host "Nova Senha: " -AsSecureString | ConvertFrom-SecureString | Out-File $caminho
        } 
        
        15 {            
            # Testes
        } 
        
        's' {            
            return
        }
    }
    pause
}
until ($opcao -eq 's')