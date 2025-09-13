<#
.SYNOPSIS
	Deixa o computador pronto para uso no padrão da empresa.
.DESCRIPTION
    Este script powershell foi criado para configurar e instalar todos os programas necessários para o uso diário do usuário comum, assim, deixando o computador pronto para uso de acordo com os padrões da empresa. Privilégios de administrador são necessários.
.EXAMPLE
	PS> ./Menu.ps1
.LINK
	https://github.com/lumielaura/win-manut
.NOTES
	Autor: Lumiel Aura
#>

# Caminho do log (Área de Trabalho do usuário)
$logPath = "$PSScriptRoot\menu_log.txt"

# Verifica se o log existe; se não, cria com cabeçalho
if (-not (Test-Path $logPath)) {
    "=== Início do log do menu ===`n" | Out-File -FilePath $logPath -Append -Encoding utf8
}

# Opções do menu
$opcoes = @(
    "Opção 1: Todas as Opções Abaixo (2-9)",
    "Opção 2: Modificar e Iniciar os Serviços do Windows",
    "Opção 3: Atualizar o Windows",
    "Opção 4: Instalar Automaticamente os Programas",
    "Opção 5: Modificar as Configurações de Rede (Wi-Fi - IP Estático)",
    "Opção 6: Ingressar o Computador no Domínio",
    "Opção 7: Instalar Programas Adicionais (manual)",
    "Opção 8: Ativar a Conta de Administrador Local",
    "Opção 9: Mostrar o Status Atual do Computador",
    "Opção 10: Modificar as Configurações de Rede (Wi-Fi - DHCP)",
    "Opção 11: Particionar Disco e Mudar Perfil Padrão do Usuário",
    "Opção 12: Adicionar conexão da rede (Wi-Fi)",
    "Opção 13: Instalar RSAT",
    "Opção 14: Criar nova senha para o ADM",
    "Sair sem selecionar"
)

function escreverLog {
    param ($mensagem)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $mensagem" | Out-File -FilePath $logPath -Append -Encoding utf8
}

function mostrarFrase {
    param ($index)
    Clear-Host
    switch ($index) {
        0 { $mensagem = "$($opcoes[0])" }
        1 { $mensagem = "$($opcoes[1])" }
        2 { $mensagem = "$($opcoes[2])" }
        3 { $mensagem = "$($opcoes[3])" }
        4 { $mensagem = "$($opcoes[4])" }
        5 { $mensagem = "$($opcoes[5])" }
        6 { $mensagem = "$($opcoes[6])" }
        7 { $mensagem = "$($opcoes[7])" }
        8 { $mensagem = "$($opcoes[8])" }
        9 { $mensagem = "$($opcoes[9])" }
        10 { $mensagem = "$($opcoes[10])" }
        11 { $mensagem = "$($opcoes[11])" }
        12 { $mensagem = "$($opcoes[12])" }
        13 { $mensagem = "$($opcoes[13])" }
        14 { 
            escreverLog "Usuário escolheu: Sair sem selecionar"
            return $false 
        }
    }

    Write-Host ('=' * 60)
    Write-Host "$mensagem"
    Write-Host ('=' * 60)`n

    escreverLog "Usuário escolheu: $mensagem"
    return $true
}

function desenharMenu {
    param ($index, $opcoes)
    Clear-Host
    Write-Host "Use as setas ↑ ↓ para navegar. ENTER para selecionar. ESC para sair.`n"
    for ($i = 0; $i -lt $opcoes.Length; $i++) {
        if ($i -eq $index) {
            Write-Host "> $($opcoes[$i])" -ForegroundColor Cyan
        } else {
            Write-Host "  $($opcoes[$i])"
        }
    }
}


# Real corpo do código
do {
    $index = 0
    $maxIndex = $opcoes.Length - 1

    # Menu interativo, podendo usar as setas do teclado
    do {
        desenharMenu $index $opcoes
        $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

        switch ($key.VirtualKeyCode) {
            38 { if ($index -gt 0) { $index-- } }   # Seta ↑
            40 { if ($index -lt $maxIndex) { $index++ } } # Seta ↓
            27 { # Esc
                escreverLog "Usuário saiu com tecla ESC"
                Clear-Host
                return 
            } 
        }

        # Selecionar opção / Enter
        if ($key.VirtualKeyCode -eq 13 -or $key.Character -eq "`r") {
            break
        }

    } while ($true)

    $continuar = mostrarFrase $index
    
    # O index vai ser 1 numero menor que as opções do menu
    switch ($index) {
        0 {
            "Index = $index"
            # "Opção 1: Todas as Opções Abaixo (2-9)"
            "Área de Teste"
        }
        1 {
            # "Opção 2: Modificar e Iniciar os Serviços do Windows"
            & "$PSScriptRoot\scp\servicos.ps1"
        }
        2 {
            # "Opção 3: Atualizar o Windows"
            Set-PSRepository -Name PSGallery -InstallationPolicy Trusted;
            Install-Module PSWindowsUpdate -PassThru;
            Get-WindowsUpdate -AcceptAll -Install;
            Restart-Computer -Confirm
        }
        3 {
            # "Opção 4: Instalar Automaticamente os Programas"
            & "$PSScriptRoot\scp\programas.ps1"
        }
        4 {
            # "Opção 5: Modificar as Configurações de Rede (Wi-Fi - IP Estático)"
            "`nDigite os NUMEROS do Hostname:`nEx: Digite: 17"
            $hnum = Read-Host "NUMEROS do Hostname"

            if ($hnum -like "?*" ) { 
                & "$PSScriptRoot\scp\ipConf.ps1"
            } 
        }
        5 {
            # "Opção 6: Ingressar o Computador no Domínio"
            & SystemPropertiesComputerName
        }
        6 {
            # "Opção 7: Instalar Programas Adicionais (manual)"
            "Descontinuado - Segunda Área de Teste"
        }
        7 {
            # "Opção 8: Ativar a Conta de Administrador Local"
            & "$PSScriptRoot\scp\profLocal.ps1"
        }
        8 {
            # "Opção 9: Mostrar o Status Atual do Computador"
            & "$PSScriptRoot\scp\status.ps1"
        }
        9 {
            # "Opção 10: Modificar as Configurações de Rede (Wi-Fi - DHCP)"
            Remove-NetIPAddress -InterfaceAlias Wi-Fi -Confirm:$false
            Remove-NetRoute -InterfaceAlias Wi-Fi -Confirm:$false
            Set-NetIPInterface -InterfaceAlias Wi-Fi -DHCP enabled
        }
        10 {
            # "Opção 11: Particionar Disco e Mudar Perfil Padrão do Usuário"
            & "$PSScriptRoot\scp\partDisk.ps1"
        }
        11 {
            # "Opção 12: Adicionar conexão da rede (Wi-Fi)"
            & "$PSScriptRoot\netwk\netwk.ps1"
        }
        12 {
            # "Opção 13: Instalar RSAT"
            Get-WindowsCapability -Name "Rsat.ActiveDirectory.*" -online | Add-WindowsCapability –Online
        }
        13 {
            # "Opção 14: Criar nova senha para o ADM"
            $caminho = "$PSScriptRoot\scp\101.txt"
            Read-Host "Nova Senha: " -AsSecureString | ConvertFrom-SecureString | Out-File $caminho
        }
    }

    if ($index -eq 0..12) {
        "Index: $Index"
    }
    
    Write-Host "`nPressione qualquer tecla para voltar ao menu..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    

} while ($continuar)
