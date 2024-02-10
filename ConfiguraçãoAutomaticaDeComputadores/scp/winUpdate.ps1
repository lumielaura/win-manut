Show-SubMenu ($subTitle = "$wup1");

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted;
Install-Module PSWindowsUpdate -PassThru;

Show-SubMenu ($subTitle = "$wup1");
Get-WindowsUpdate -AcceptAll -Install;