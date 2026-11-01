<#
.SYNOPSIS
    Resets the ASAD lab environment back to its original baseline vulnerabilities.
#>

Write-Host "[*] Restoring ASAD lab configurations to baseline vulnerable state..." -ForegroundColor Yellow

# Example 1: Reset specific test user password for AS-REP Roasting or Kerberoasting tests
$TargetUser = "svc_sql"
if (Get-ADUser -Filter "SamAccountName -eq '$TargetUser'") {
    Set-ADAccountPassword $TargetUser -NewPassword (ConvertTo-SecureString "Welcome123!" -AsPlainText -Force)
    Set-ADUser $TargetUser -PasswordNeverExpires $true -CannotChangePassword $true
    Write-Host "[+] Reset password and properties for $TargetUser" -ForegroundColor Green
}

# Example 2: Re-apply a weak ACL or SPN mapping if needed
# Set-ADUser <TargetUser> -ServicePrincipalName @{Add="MSSQLSvc/sql01.corp.local:1433"}

Write-Host "[+] ASAD lab successfully reset to default vulnerable state!" -ForegroundColor Cyan
