<#
.SYNOPSIS
    Enables advanced PowerShell and Process auditing flags for purple-team testing.
#>

Write-Host "[*] Enabling advanced logging policies for ASAD detection testing..." -ForegroundColor Cyan

# Enable PowerShell Script Block Logging (Event ID 4104)
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
if (!(Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}
Set-ItemProperty -Path $RegistryPath -Name "EnableScriptBlockLogging" -Value 1

# Enable Module Logging
$ModulePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging"
if (!(Test-Path $ModulePath)) {
    New-Item -Path $ModulePath -Force | Out-Null
}
Set-ItemProperty -Path $ModulePath -Name "EnableModuleLogging" -Value 1

Write-Host "[+] Advanced logging enabled. Check Event Viewer under Microsoft-Windows-PowerShell/Operational." -ForegroundColor Green
