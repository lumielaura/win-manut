Show-SubMenu ($subTitle = "$mpr1");

# programas winget
winget upgrade --all --accept-source-agreements --accept-package-agreements; "";

# Outras opções de pacotes 
# 'EclipseAdoptium.Temurin.17.JRE',
# 'ArtifexSoftware.GhostScript',
# 'Cyanfish.NAPS2',
# 'ChristianKindahl.InfraRecorder',
# 'LIGHTNINGUK.ImgBurn',
# 'TeamViewer.TeamViewer',

# Programas do meu computador
'7zip.7zip',
'Mozilla.Firefox',
'ONLYOFFICE.DesktopEditors',
'ApacheFriends.Xampp.8.2',
'DuongDieuPhap.ImageGlass',
'Oracle.MySQLWorkbench',
'OpenJS.NodeJS.LTS',
'aandrew-me.ytDownloader',
'OBSProject.OBSStudio',
'Valve.Steam',
'Microsoft.Edge',
'Microsoft.VCRedist.2008.x64',
'Microsoft.VCRedist.2005.x64',
'Microsoft.VCRedist.2013.x64',
'Microsoft.VCRedist.2010.x86',
'Microsoft.VCRedist.2010.x64',
'Microsoft.VCRedist.2012.x64',
'Microsoft.VCRedist.2015+.x86',
'Microsoft.VCRedist.2015+.x64',
'Microsoft.DotNet.DesktopRuntime.8',
'Microsoft.AppInstaller',
'Microsoft.PowerShell',
'Microsoft.UI.Xaml.2.7',
'Microsoft.UI.Xaml.2.8',
'Microsoft.VCLibs.Desktop.14',
'Microsoft.WindowsTerminal',
'VideoLAN.VLC',
'GIMP.GIMP',
'Discord.Discord',
'GitHub.GitHubDesktop',
'JackieLiu.NotepadsApp',
'BleachBit.BleachBit', # Programas do trabalho
'CodecGuide.K-LiteCodecPack.Basic',
'Google.Chrome',
'Piriform.Speccy',
'GlavSoft.TightVNC',
'PuTTY.PuTTY',
'AcroSoftware.CutePDFWriter',
'dotPDNLLC.paintdotnet',
'Zoom.Zoom',
'TheDocumentFoundation.LibreOffice',
'Google.EarthPro',
'Foxit.FoxitReader' |
ForEach-Object -Process {

    winget install --id="$_" -e; "";

}

# lista os programas instalados
# winget list

# exportar uma lista de app com winget
# winget export -o $HOME\Downloads\wingetprograms.txt