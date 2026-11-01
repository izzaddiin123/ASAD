# Run this as Administrator on both base Windows VMs before running Ansible
Set-ExecutionPolicy Unrestricted -Force

# Enable WinRM and configure HTTP transport for local lab provisioning
Enable-PSRemoting -Force -SkipNetworkProfileCheck

Configure-SMBServer -Force

# Set WinRM Listener settings
Set-Item WSMan:\localhost\Service\AllowUnencrypted -Value true
Set-Item WSMan:\localhost\Service\Auth\Basic -Value true

# Restart WinRM Service
Restart-Service WinRM

# Open Firewall Ports for WinRM
New-NetFirewallRule -Name "WinRM-HTTP" -DisplayName "Allow WinRM HTTP" -Enabled True -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow
