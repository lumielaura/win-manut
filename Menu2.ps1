# Menu interativo PowerShell com log, Enter, Esc, funções em camelCase

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

    Write-Host ('=' * 70)
    Write-Host "$mensagem"
    Write-Host ('=' * 70)`n

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

        if ($key.VirtualKeyCode -eq 13 -or $key.Character -eq "`r") {
            break
        }

    } while ($true)

        
    $continuar = mostrarFrase $index

    " Index = $index"
    
    # O index vai ser um numero menor que as opções do menu
    switch ($index) {
        0 {"Switch 0"}
        1 {"Switch 1"}
        2 {}
        3 {}
        4 {}
        5 {}
        6 {}
        7 {}
        8 {& "$PSScriptRoot\scp\status.ps1"}
        9 {}
        10 {}
        11 {}
        12 {}
        13 {}
    }

    Write-Host "`nPressione qualquer tecla para voltar ao menu..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

} while ($continuar)
