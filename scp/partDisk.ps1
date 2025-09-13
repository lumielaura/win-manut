# variaveis
$divs = 1000000000; # 1 Milhão
$pathD = "D:\";
$pathE = "E:\";

# funções
function Format-NewDisk {
    
    # Pegar a letra da unidade
    Start-Sleep -Seconds 3;
    $rDiskLetter = (get-Content -Path "$PSScriptRoot\temp.txt" -ReadCount 1);

    # Formatando a nova partição
    if ($rDiskLetter -eq "D") {
        
        Format-Volume -DriveLetter D;

    } elseif ($rDiskLetter -eq "E") {

        Format-Volume -DriveLetter E;

    } else {

        "A sua particao foi criada com sucesso, mas precisa ser formatada manualmente.";
        Break;

    }
    
}

function Set-ProfileUsers {        
    
    # Alterar o registro - local padrão da pasta Users
    if (Test-Path $pathD) {
            
        # Informações da Partição D
        $dpartD = Get-Partition -DriveLetter D | Select-Object -ExpandProperty size;
        $partD = $dpartD/$divs;
        $gpartD = 250;

        Start-Sleep -Seconds 3;
        
        if ([int]$partD -gt [int]$gpartD) {

            # trocar o local da pasta padrão dos usuários - Disco D
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" -Name ProfilesDirectory -Value "D:\Users";
        
            # outra forma de fazer a mudança no registro
            # $plpath = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" -Name ProfilesDirectory;
            # $pathUsers = $plpath.ProfilesDirectory = "D:\Users";
            
        } 
        
    } elseif (Test-Path $pathE) {

        # Informações da Partição E
        $dpartE = Get-Partition -DriveLetter E | Select-Object -ExpandProperty size;
        $partE = $dpartE/$divs;
        $gpartE = 250;

        Start-Sleep -Seconds 3;
        
        if ([int]$partE -gt [int]$gpartE) {
            
            # trocar o local da pasta padrão dos usuários - Disco E
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" -Name ProfilesDirectory -Value "E:\Users";
            
        }
        
    }

}

# Informações da partição C
$dpartC = Get-Partition -DriveLetter C | Select-Object -ExpandProperty size;
$partC = $dpartC/$divs;
$gpartC = 400;

Start-Sleep -Seconds 3;

# mudar o tamanho da particao C e criar uma particao nova
if ([int]$partC -gt [int]$gpartC) {

    Get-Disk | Format-Table;
    "`nInforme o HD/SSD Principal";
    $diskN = Read-Host "Numero do Disco";

    # Redimensionar partição C
    Resize-Partition -DriveLetter C -Size 150GB;
    Start-Sleep -Seconds 3;
    
    # get-disk | Where-Object { $_.OperationalStatus -eq "Online" -and $_.Number -eq "0" } | Select-Object -ExpandProperty Number
    
    # Criar uma nova partição
    if ($diskN -eq "0") {
        
        New-Partition -DiskNumber 0 -UseMaximumSize -AssignDriveLetter | Select-Object -ExpandProperty DriveLetter | Out-File "$PSScriptRoot\temp.txt";
        "`tParticao criada com Sucesso.";
        Format-NewDisk;
        Set-ProfileUsers;

        # New-Partition -DiskNumber 0 -UseMaximumSize -DriveLetter D;
        # New-Partition -DiskNumber 0 -UseMaximumSize -AssignDriveLetter;
        
    } elseif ($diskN -eq "1") {

        New-Partition -DiskNumber 1 -UseMaximumSize -AssignDriveLetter | Select-Object -ExpandProperty DriveLetter | Out-File "$PSScriptRoot\temp.txt";
        "`tParticao criada com Sucesso.";
        Format-NewDisk;
        Set-ProfileUsers;

    } else {

        "`tVoce não conseguiu criar a Nova particao, mas o espaço total do seu disco C foi reduzido com sucesso.`n`n`tVerifique o Gerenciamento de Disco para mais informacoes.";
        Start-Sleep -Seconds 10;
        Break;

    }
    
}