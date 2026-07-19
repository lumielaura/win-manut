# programas winget
winget upgrade --all --accept-source-agreements --accept-package-agreements

$ind=0 # Programas do meu computador
'7zip.7zip',
'Mozilla.Firefox',
'Foxit.FoxitReader',
'TheDocumentFoundation.LibreOffice',
'ONLYOFFICE.DesktopEditors',
'DuongDieuPhap.ImageGlass',
'aandrew-me.ytDownloader',
'OBSProject.OBSStudio',
'VideoLAN.VLC',
'GIMP.GIMP.3',
'Valve.Steam',
'Discord.Discord',
'OpenJS.NodeJS.LTS',
'Microsoft.AppInstaller',
'Microsoft.PowerShell',
'Piriform.Speccy',
'Microsoft.WindowsTerminal',
'GitHub.GitHubDesktop',
'Oracle.MySQLWorkbench',
'ApacheFriends.Xampp.8.2',
'9P8LTPGCBZXD', #wintoys
'XP89DCGQ3K6VLD', #powertoys preview
'Microsoft.UI.Xaml.2.7',
'Microsoft.UI.Xaml.2.8',
'Microsoft.VCRedist.2005.x64',
'Microsoft.VCRedist.2008.x64',
'Microsoft.VCRedist.2010.x64',
'Microsoft.VCRedist.2012.x64',
'Microsoft.VCRedist.2013.x64',
'Microsoft.VCRedist.2015+.x86',
'Microsoft.VCRedist.2015+.x64',
'Microsoft.DotNet.DesktopRuntime.8',
'CodecGuide.K-LiteCodecPack.Basic',
'Microsoft.VCLibs.Desktop.14' |
ForEach-Object -Process {    
    $ind++
    "`nID: $ind`tName: $_"
    winget install --id="$_" -e
}


# exportar uma lista de app com winget
# winget export -o "$HOME\Documents\wingetprograms.txt"
