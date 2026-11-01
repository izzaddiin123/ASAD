<#
.SYNOPSIS
    Generates background authentication, DNS, and file share noise for the ASAD lab.
#>

$TargetDC = $env:COMPUTERNAME
$Domains = (Get-ADDomain).DNSRoot

Write-Host "[*] Starting ASAD Background Traffic Generator..." -ForegroundColor Cyan

while ($true) {
    try {
        # 1. Generate DNS lookups
        [System.Net.Dns]::GetHostByName($TargetDC) | Out-Null
        
        # 2. Simulate SMB / File share connection attempts
        Get-ChildItem "\\$TargetDC\C$\" -ErrorAction SilentlyContinue | Out-Null

        # 3. Perform LDAP queries to simulate user/group enumeration noise
        Get-ADUser -Filter * -Properties LastLogonDate -ErrorAction SilentlyContinue | Select-Object -First 5 | Out-Null

        $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Write-Host "[$Timestamp] Generated background auth & LDAP noise..." -ForegroundColor Green
    }
    catch {
        Write-Warning "[-] Background activity loop minor error: $_"
    }

    # Sleep between 45 to 90 seconds to mimic realistic activity intervals
    Start-Sleep -Seconds (Get-Random -Minimum 45 -Maximum 90)
}
