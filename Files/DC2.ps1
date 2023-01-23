#Installation script ADDS

#Check if user is administrator
  If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] “Administrator”))

    {
        Write-Warning “You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!”
        Break
    }

#Variables

$DomainName = "tim.corona"
$SafeModeAdministratorPassword = convertto-securestring "Server19" -asplaintext -force
$DomainMode = "WinThreshold"
$ForestMode = "WinThreshold"
$DatabasePath = "C:\Windows\NTDS"
$LogPath = "C:\Windows\NTDS"
$SysVolPath = "C:\Windows\SYSVOL"
$DHCPServerIP="192.168.100.10"
$DNSServerIP="192.168.100.10"
$StartRange="192.168.100.160"
$EndRange="192.168.100.200"
$Subnet="255.255.255.0"
$DHCPScriptPath="C:\Scripts\Part 1\DC01\InstallDHCP.ps1"
$Logfile = "C:\Windows\Temp\ConfigureADDS.log"

#Function to log installation process
Function LogWrite
{
   Param ([string]$logstring)
   $a = Get-Date
   $logstring = $a,$logstring
   Try
{   
    Add-content $Logfile -value $logstring -ErrorAction silentlycontinue
}
Catch
{
    $logstring="Invalid data encountered"
    Add-content $Logfile -value $logstring
}
   write-host $logstring
}

#Start of script
LogWrite "Starting script.."

#Create runonce job to run DHCP script on next logon
LogWrite "creating runonce job for the DHCP installer"
$DHCPScript = @"
# install the DHCP server role
Install-WindowsFeature -Name 'DHCP' -IncludeManagementTools
Add-DhcpServerInDC -DnsName $DomainName -IPAddress $DHCPServerIP
Add-DhcpServerInDC -DnsName $Env:COMPUTERNAME
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 -Name ConfigurationState -Value 2
Add-DhcpServerV4Scope -Name 'DHCP Scope' -StartRange $StartRange -EndRange $EndRange -SubnetMask $Subnet
Set-DhcpServerV4OptionValue -DnsDomain $DomainName -DnsServer $DNSServerIP
Set-DhcpServerv4Scope -ScopeId $DHCPServerIP -LeaseDuration 1.00:00:00
"@ 

#Check if DHCPScript exists
if (Test-Path "$DHCPScriptPath"){
 write-host "'$DHCPScriptPath' already exists, will not recreate it."
 } else {
New-Item -Path "$DHCPScriptPath" -ItemType File -Value $DHCPScript
}

#Create the runonce item
$DHCPScriptPath
$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" ('C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionPolicy Unrestricted -File ' + "`"$DHCPScriptPath`"")

LogWrite "Installing ADDS"

# installation ADDS
Install-windowsfeature -name AD-Domain-Services –IncludeManagementTools 2>&1
LogWrite "Importing ADDSDeployment module"
Import-Module ADDSDeployment
LogWrite "Installing ADDSForest"
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath $DatabasePath `
-DomainMode $DomainMode `
-DomainName $DomainName `
-ForestMode $ForestMode `
-InstallDns:$true `
-LogPath $LogPath `
-NoRebootOnCompletion:$false `
-SysvolPath $SysVolPath `
-SafeModeAdministratorPassword $SafeModeAdministratorPassword `
-Force:$true

#Change DNS
Add-DnsServerForwarder -IPAddress "8.8.8.8" -PassThru

#Enable routing
Try{ 
    Install-WindowsFeature Routing -IncludeManagementTools
    Restart-Computer
    Install-RemoteAccess -VpnType Vpn
    cmd.exe /c "netsh routing ip nat add interface Ethernet"
    cmd.exe /c "netsh routing ip nat set interface Ethernet mode=full"
    cmd.exe /c "netsh routing ip nat add interface Ethernet 2"
    Write-Host "Routing has been enabled"
    }
Catch{
    Write-Warning -Message $("Routing couldn't be enabled. Error: " + $_.Exception.Message)
    Break;
}
