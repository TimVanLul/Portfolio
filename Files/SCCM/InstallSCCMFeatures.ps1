#------------------------------------------------------------------
#- Install Features                                   -------------
#------------------------------------------------------------------

# Variables
$NETLocation = 'd:\sources\sxs'

function TestPath($Path) {
if ( $(Try { Test-Path $Path.trim() } Catch { $false }) ) {
   write-host "Path OK"
 }
Else {
   write-host "$Path not found, please fix and try again."
   break
 }}

# check is media found
 
$Path = $NETLocation
TestPath $Path

# check if user is Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] “Administrator”))

    {
        Write-Warning “You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!”
        Break
    }

# install features

Write-Host "Installing roles and features, please wait... "  -nonewline

Get-Module servermanager
Install-WindowsFeature Web-Windows-Auth, Web-ISAPI-Ext, Web-Metabase, Web-WMI, Web-App-Dev, Web-Default-Doc, Web-Dir-Browsing, Web-Filtering, Web-Health, Web-Http-Errors,
Web-Http-Logging, Web-Http-Redirect, Web-Http-Tracing, Web-ISAPI-Filter, Web-Log-Libraries, Web-Mgmt-Compat, Web-Mgmt-Console, Web-Mgmt-Tools, Web-Net-Ext, Web-Net-Ext45,
Web-Performance, Web-Request-Monitor, Web-Security, Web-Server, Web-Stat-Compression, Web-Static-Content, Web-WebServer, BITS, RDC, NET-Framework-Features, Web-Asp-Net,
Web-Asp-Net45, NET-HTTP-Activation, NET-Non-HTTP-Activ, BITS-IIS-Ext, MSMQ, MSMQ-Server, MSMQ-Services, NET-Framework-45-ASPNET, NET-Framework-Core, NET-WCF-HTTP-Activation45,
NET-WCF-MSMQ-Activation45, NET-WCF-Pipe-Activation45, NET-WCF-TCP-Activation45, RSAT, RSAT-Bits-Server, RSAT-Feature-Tools, WAS, WAS-Config-APIs, WAS-Process-Model -source $NETLocation 

Write-Host "Exiting script"