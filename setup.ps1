Write-Host "🚀 Setting up Windows Integration..."
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
$SyncthingPath = "C:\Syncthing"
New-Item -ItemType Directory -Path $SyncthingPath -Force
Invoke-WebRequest -Uri "https://github.com/syncthing/syncthing/releases/latest/download/syncthing-windows-amd64.zip" -OutFile "$SyncthingPath\syncthing.zip"
Expand-Archive "$SyncthingPath\syncthing.zip" -DestinationPath $SyncthingPath -Force
Start-Process "$SyncthingPath\syncthing.exe"
winget install kdeconnect
Set-SmbServerConfiguration -EnableSMB1Protocol $true -Force
Write-Host "✅ Windows Setup Complete! Rebooting..."
Restart-Computer -Force
