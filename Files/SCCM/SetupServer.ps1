#------------------------------------------------------------------
#- Installation script for SQL Server                 -------------
#------------------------------------------------------------------

  If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] “Administrator”))

    {
        Write-Warning “You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!”
        Break
    }

# Variables
##IP config
$ethalias = 'Ethernet 2'
$ethdns = '192.168.20.2' 
$ethipaddress = '192.168.20.3'
#$ethipaddress = '192.168.20.149'
$ethprefixlength = '24'
#$ethdefaultgw = '192.168.20.153'
$Adapter = Get-NetAdapter -InterfaceAlias $ethalias

##Domain
$domain = "Corona2020.local"
$password = "Server19" | ConvertTo-SecureString -asPlainText -Force
$joindomainuser = "Administrator"
$computername = "echo"

$username = "$domain\$joindomainuser" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)

# Config IP
try {
    Remove-NetIPAddress -InterfaceAlias Ethernet -Confirm:$false
    remove-netroute -InterfaceAlias Ethernet -Confirm:$false
    New-NetIPAddress -IPAddress $ethipaddress -PrefixLength $ethprefixlength <#-DefaultGateway $ethdefaultgw#> -InterfaceAlias $ethalias -ErrorAction Stop | Out-Null 
    Set-DNSClientServerAddress -ServerAddresses $ethdns -InterfaceAlias $ethalias -ErrorAction Stop
    Write-Host "Ip address succesfully set to $($ethipaddress), subnet $($ethprefixlength), default gateway $($ethdefaultgw) and DNS server $($ethdns)" -ForegroundColor Green
    }
    Catch{
    Write-Warning -Message $("Failed to apply network settings. Error: "+ $_.Exception.Message)
    Break;
}
# Change hostname
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

# Joining domain
try{
     Add-Computer -DomainName $domain -Credential $credential -ErrorAction Stop
     Restart-Computer
}

catch{
    Write-Warning -Message $("Couldn't join the Domain, here is the error:" + $_.Exception.Message)
    Break;
}

write-host "Exiting script, computer rebooting in 10 sec."
Sleep 10

Try{
   Restart-Computer
    Write-Host "Rebooting now" -ForegroundColor Green
    }
Catch{
    Write-Warning -Message $("Failed to restart comp $($env:computername). Error: "+ $_.Exception.Message)
    Break;
    }

