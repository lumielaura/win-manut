Show-SubMenu ($subTitle = "$mpr1");

# programas winget
winget upgrade --all --accept-source-agreements --accept-package-agreements; "";

'Microsoft.PowerShell',
'Microsoft.WindowsTerminal',
'7zip.7zip',
'BleachBit.BleachBit',
'AcroSoftware.CutePDFWriter',
'ArtifexSoftware.GhostScript',
'LIGHTNINGUK.ImgBurn',
'CodecGuide.K-LiteCodecPack.Basic',
'Microsoft.Edge',
'Mozilla.Firefox',
'Cyanfish.NAPS2',
'ONLYOFFICE.DesktopEditors',
'Piriform.Speccy',
'TeamViewer.TeamViewer',
'VideoLAN.VLC',
'Microsoft.VCRedist.2013.x64',
'Microsoft.DotNet.DesktopRuntime.5',
'ChristianKindahl.InfraRecorder',
'GlavSoft.TightVNC',
'PuTTY.PuTTY',
'EclipseAdoptium.Temurin.17.JRE',
'Microsoft.VCRedist.2015+.x64',
'dotPDNLLC.paintdotnet',
'Zoom.Zoom',
'TheDocumentFoundation.LibreOffice',
'Foxit.FoxitReader',
'Google.EarthPro' | 
ForEach-Object -Process {

    winget install --id="$_" -e; "";

}

# lista os programas instalados
# winget list

# exportar uma lista de app com winget
# winget export -o $HOME\Desktop\wingetprograms