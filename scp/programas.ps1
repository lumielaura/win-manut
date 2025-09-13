
# programas winget
winget upgrade --all --accept-source-agreements --accept-package-agreements; ""

# Outras opções de pacotes 
# 'EclipseAdoptium.Temurin.17.JRE',
# 'ArtifexSoftware.GhostScript',
# 'Cyanfish.NAPS2',
# 'ChristianKindahl.InfraRecorder',
# 'LIGHTNINGUK.ImgBurn',
# 'TeamViewer.TeamViewer',
# 'Google.Chrome',
# 'Microsoft.Edge',
# 'BleachBit.BleachBit', 
# 'GlavSoft.TightVNC',
# 'PuTTY.PuTTY',
# 'AcroSoftware.CutePDFWriter',
# 'dotPDNLLC.paintdotnet',
# 'Zoom.Zoom',
# 'Google.EarthPro',

# Programas do meu computador
'7zip.7zip',
'Mozilla.Firefox',
'Foxit.FoxitReader',
'TheDocumentFoundation.LibreOffice',
'ONLYOFFICE.DesktopEditors',
'DuongDieuPhap.ImageGlass',
'OpenJS.NodeJS.LTS',
'aandrew-me.ytDownloader',
'OBSProject.OBSStudio',
'VideoLAN.VLC',
'GIMP.GIMP',
'Valve.Steam',
'Discord.Discord',
'JackieLiu.NotepadsApp',
'Microsoft.AppInstaller',
'Microsoft.PowerShell',
'Piriform.Speccy',
'Microsoft.WindowsTerminal',
'GitHub.GitHubDesktop',
'Oracle.MySQLWorkbench',
'ApacheFriends.Xampp.8.2',
'Microsoft.UI.Xaml.2.7',
'Microsoft.UI.Xaml.2.8',
'Microsoft.VCRedist.2005.x64',
'Microsoft.VCRedist.2008.x64',
'Microsoft.VCRedist.2010.x86',
'Microsoft.VCRedist.2010.x64',
'Microsoft.VCRedist.2012.x64',
'Microsoft.VCRedist.2013.x64',
'Microsoft.VCRedist.2015+.x86',
'Microsoft.VCRedist.2015+.x64',
'Microsoft.DotNet.DesktopRuntime.8',
'CodecGuide.K-LiteCodecPack.Basic',
'Microsoft.VCLibs.Desktop.14' |
ForEach-Object -Process { winget install --id="$_" -e; "" }

# exportar uma lista de app com winget
# winget export -o "$HOME\Documents\wingetprograms.txt"