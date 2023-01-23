# Configuration script for DC

# Network Variables
$ethalias = 'Ethernet'
$ethipaddress = '192.168.100.10'
$ethprefixlength = '24'
$ethdefaultgw = '192.168.100.10'
$Adapter = Get-NetAdapter -InterfaceAlias $ethalias

# Hostname Variables
$computername = 'WIN-DC-ALFA'

#Enable Remote Desktop Variable
$enablerdp = 'yes' #To enable set this to yes - to disable to no

#Disable IE Enhanced Security Config variable
$disableiesecconfig = 'yes'

# Configuration internal network
Try{ 
    New-NetIPAddress -IPAddress $ethipaddress -PrefixLength $ethprefixlength -DefaultGateway $ethdefaultgw -InterfaceAlias $ethalias -ErrorAction Stop | Out-Null 
    Set-DNSClientServerAddress -InterfaceAlias $ethalias -ServerAddresses $ethipaddress, "8.8.8.8"
    Write-Host "Ip address succesfully set to $($ethipaddress), subnet $($ethprefixlength), default gateway $($ethdefaultgw)" -ForegroundColor Green
    }
Catch{
    Write-Warning -Message $("Failed to apply network settings. Error: "+ $_.Exception.Message)
    Break;
}

#Disable IE enhanced security config
Try{
    IF($disableiesecconfig -eq "yes")
    {
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}' -name IsInstalled -Value 0 -ErrorAction stop
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}' -name IsInstalled -Value 0 -ErrorAction stop
    Write-Host "IE Enhanced Security Configuration successfullyy disabled " -ForegroundColor Green
    }
}
Catch {
    Write-Warning -Message $("Failed to disable IE Security config. Error: "+ $_.Exception.Message)
    Break;
}

#Set Hostname
Try{
    if($env:COMPUTERNAME -ne $computername){
    Rename-Computer -ComputerName $env:COMPUTERNAME -NewName $computername -ErrorAction Stop
    Write-Host "Computer name changed into $($computername)" -ForegroundColor Green
    }
    Else{
    Write-Host "Computername is already $computername" -ForegroundColor Gray
    }
 }
Catch{
    Write-Warning -Message $("Failed to change computername. Error "+ $_.Exception.Message)
    Break;
}

# Auto login
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$DefaultUsername = "Administrator"
$DefaultPassword = "Server19"
Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1" -type String 
Set-ItemProperty $RegPath "DefaultUsername" -Value "$DefaultUsername" -type String 
Set-ItemProperty $RegPath "DefaultPassword" -Value "$DefaultPassword" -type String

#Reboot to apply settings
Write-Host "Computer rebooting in 10 sec"
Sleep 10

Try{
   Restart-Computer -ComputerName $env:COMPUTERNAME -ErrorAction Stop
    Write-Host "Rebooting now" -ForegroundColor Green
    }
Catch{
    Write-Warning -Message $("Failed to restart comp $($env:computername). Error: "+ $_.Exception.Message)
    Break;
    }
