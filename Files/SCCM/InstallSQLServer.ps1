#------------------------------------------------------------------
#- Installation script for SQL Server                 -------------
#------------------------------------------------------------------

# below variables are customizable
$folderpath="C:\Source"
$inifile="$folderpath\ConfigurationFile.ini"

# Set user as a SQL sysadmin
$yourusername="corona2020\Administrator"

# Path to the SQL media (CD drive)
$SQLsource="D:"
# PLace where to install SQL
$SQLInstallDrive = "H:"

# SQL memory
$SqlMemMin = 4096
$SqlMemMax = 4096

# SQL Configuration Variables
$ACTION="Install"
$ASCOLLATION="Latin1_General_CI_AS"
$ErrorReporting="False"
$SUPPRESSPRIVACYSTATEMENTNOTICE="False"
$IACCEPTROPENLICENSETERMS="False"
$ENU="True"
$QUIET="True"
$QUIETSIMPLE="False"
$UpdateEnabled="True"
$USEMICROSOFTUPDATE="False"
$FEATURES="SQLENGINE,RS,CONN,IS,BC,SDK"
$UpdateSource="MU"
$HELP="False"
$INDICATEPROGRESS="False"
$X86="False"
$INSTANCENAME="MSSQLSERVER"
$INSTALLSHAREDDIR="$SQLInstallDrive\MSSQL"
$INSTALLSHAREDWOWDIR="$SQLInstallDrive\MSSQL(x86)"
$INSTANCEID="MSSQLSERVER"
$RSINSTALLMODE="DefaultNativeMode"
$SQLTELSVCACCT="NT Service\SQLTELEMETRY"
$SQLTELSVCSTARTUPTYPE="Automatic"
$ISTELSVCSTARTUPTYPE="Automatic"
$ISTELSVCACCT="NT Service\SSISTELEMETRY130"
$INSTANCEDIR="$SQLInstallDrive\MSSQL"
$AGTSVCACCOUNT="NT AUTHORITY\SYSTEM"
$AGTSVCSTARTUPTYPE="Automatic"
$ISSVCSTARTUPTYPE="Disabled"
$ISSVCACCOUNT="NT AUTHORITY\System"
$COMMFABRICPORT="0"
$COMMFABRICNETWORKLEVEL="0"
$COMMFABRICENCRYPTION="0"
$MATRIXCMBRICKCOMMPORT="0"
$SQLSVCSTARTUPTYPE="Automatic"
$FILESTREAMLEVEL="0"
$ENABLERANU="False"
$SQLCOLLATION="SQL_Latin1_General_CP1_CI_AS"
$SQLSVCACCOUNT="NT AUTHORITY\System"
$SQLSVCINSTANTFILEINIT="False"
$SQLSYSADMINACCOUNTS="$yourusername"
$SQLTEMPDBFILECOUNT="1"
$SQLTEMPDBFILESIZE="8"
$SQLTEMPDBFILEGROWTH="64"
$SQLTEMPDBLOGFILESIZE="8"
$SQLTEMPDBLOGFILEGROWTH="64"
# Change to SQL install drive
$SQLBACKUPDIR="H:\MSSQL\BACKUPDIR"
$SQLTEMPDBDIR="H:\MSSQL\TEMPDBDIR"
$SQLTEMPDBLOGDIR="H:\MSSQL\TEMPDBLOGDIR"
$SQLUSERDBLOGDIR="H:\MSSQL\USERDBLOGDIR"
$ADDCURRENTUSERASSQLADMIN="True"
$TCPENABLED="1"
$NPENABLED="1"
$BROWSERSVCSTARTUPTYPE="Disabled"
$RSSVCACCOUNT="NT AUTHORITY\System"
$RSSVCSTARTUPTYPE="Automatic"
$IAcceptSQLServerLicenseTerms="True"

if (Test-Path "$SQLsource\X64\sqlconf.dll"){
    write-host "Found SQL Server 2017..." -nonewline
    Write-Host "done!" -ForegroundColor Green
    } else {
        write-host "Could not find the media for SQL Server 2017 in $SQLsource, aborting..."
        break
        }

# do not edit below this line

$conffile= @"
[OPTIONS]
Action="$ACTION"
ErrorReporting="$ERRORREPORTING"
Quiet="$Quiet"
Features="$FEATURES"
InstanceName="$INSTANCENAME"
InstanceDir="$INSTANCEDIR"
SQLSVCAccount="$SQLSVCACCOUNT"
SQLSysAdminAccounts="$SQLSYSADMINACCOUNTS"
SQLSVCStartupType="$SQLSVCSTARTUPTYPE"
SQLBACKUPDIR="$SQLBACKUPDIR"
SQLTEMPDBDIR="$SQLTEMPDBDIR"
SQLTEMPDBLOGDIR="$SQLTEMPDBLOGDIR"
SQLUSERDBLOGDIR="$SQLUSERDBLOGDIR"
AGTSVCACCOUNT="$AGTSVCACCOUNT"
AGTSVCSTARTUPTYPE="$AGTSVCSTARTUPTYPE"
RSSVCACCOUNT="$RSSVCACCOUNT"
RSSVCSTARTUPTYPE="$RSSVCSTARTUPTYPE"
ISSVCACCOUNT="$ISSVCACCOUNT" 
ISSVCSTARTUPTYPE="$ISSVCSTARTUPTYPE"
ASCOLLATION="$ASCOLLATION"
SQLCOLLATION="$SQLCOLLATION"
TCPENABLED="$TCPENABLED"
NPENABLED="$NPENABLED"
IAcceptSQLServerLicenseTerms="$IAcceptSQLServerLicenseTerms"
"@


# Check for Script Directory & file
if (Test-Path "$folderpath"){
 write-host "The folder '$folderpath' already exists, will not recreate it."
 } else {
mkdir "$folderpath"
}
if (Test-Path "$folderpath\ConfigurationFile.ini"){
 write-host "The file '$folderpath\ConfigurationFile.ini' already exists, removing..."
 Remove-Item -Path "$folderpath\ConfigurationFile.ini" -Force
} else {
 # Create file:
write-host "Creating '$folderpath\ConfigurationFile.ini'..."
New-Item -Path "$folderpath\ConfigurationFile.ini" -ItemType File -Value $Conffile
}

# Configure Firewall settings for SQL

write-host "Configuring SQL Server 2017 Firewall settings..."

#Enable SQL Server Ports

New-NetFirewallRule -DisplayName "SQL Server" -Direction Inbound �Protocol TCP �LocalPort 1433 -Action allow
New-NetFirewallRule -DisplayName "SQL Admin Connection" -Direction Inbound �Protocol TCP �LocalPort 1434 -Action allow
New-NetFirewallRule -DisplayName "SQL Database Management" -Direction Inbound �Protocol UDP �LocalPort 1434 -Action allow
New-NetFirewallRule -DisplayName "SQL Service Broker" -Direction Inbound �Protocol TCP �LocalPort 4022 -Action allow
New-NetFirewallRule -DisplayName "SQL Debugger/RPC" -Direction Inbound �Protocol TCP �LocalPort 135 -Action allow

#Enable SQL Analysis Ports

New-NetFirewallRule -DisplayName "SQL Analysis Services" -Direction Inbound �Protocol TCP �LocalPort 2383 -Action allow
New-NetFirewallRule -DisplayName "SQL Browser" -Direction Inbound �Protocol TCP �LocalPort 2382 -Action allow

#Enabling related Applications

New-NetFirewallRule -DisplayName "HTTP" -Direction Inbound �Protocol TCP �LocalPort 80 -Action allow
New-NetFirewallRule -DisplayName "SQL Server Browse Button Service" -Direction Inbound �Protocol UDP �LocalPort 1433 -Action allow
New-NetFirewallRule -DisplayName "SSL" -Direction Inbound �Protocol TCP �LocalPort 443 -Action allow

#Enable Windows Firewall
Set-NetFirewallProfile -DefaultInboundAction Block -DefaultOutboundAction Allow -NotifyOnListen True -AllowUnicastResponseToMulticast True

Write-Host "done!" -ForegroundColor Green

# Download latest Cumulative Update for SQL Server

$filepath="$folderpath\SQLServer2017-KB4484710-x64.exe"
if (!(Test-Path $filepath)){
write-host "Downloading SQL Server 2017 Cumulative Update..." -nonewline

$URL = "https://download.microsoft.com/download/C/4/F/C4F908C9-98ED-4E5F-88D5-7D6A5004AEBD/SQLServer2017-KB4577467-x64.exe"
Invoke-WebRequest $URL -OutFile $filepath
Write-Host "done!" -ForegroundColor Green
}
 else {
write-host "SQL Server 2017 CU Installer found."
}

        
# start the SQL installer
Try
{
if (Test-Path $SQLsource){
 write-host "Installing SQL Server 2017..." -nonewline
$fileExe =  "$SQLsource\setup.exe"
$CONFIGURATIONFILE = "$folderpath\ConfigurationFile.ini"
& $fileExe  /CONFIGURATIONFILE=$CONFIGURATIONFILE
Write-Host "done!" -ForegroundColor Green
 } else {
write-host "Could not find the media for SQL Server 2017..."
break
}}
catch
{write-host "Something went wrong with the installation of SQL Server 2017, aborting."
break}

# start the SQL Server 2017 CU installer
write-host "Installing the SQL Server 2017 Cumulative Update..." -nonewline
$Parms = " /quiet /IAcceptSQLServerLicenseTerms /Action=Patch /AllInstances"
$Prms = $Parms.Split(" ")
& "$filepath" $Prms | Out-Null
Write-Host "done!" -ForegroundColor Green

# start the SQL SSMS downloader
$filepath="$folderpath\SSMS-Setup-ENU.exe"
if (!(Test-Path $filepath)){
write-host "Downloading SQL Server 2017 SSMS..." -nonewline
$URL = "https://go.microsoft.com/fwlink/?linkid=870039"
Invoke-WebRequest $URL -OutFile $filepath
Write-Host "done!" -ForegroundColor Green
}
 else {
write-host "found the SQL SSMS Installer, no need to download it..."
}

# Start the SQL SSMS installer
write-host "Installing SQL Server 2017 SSMS..." -nonewline
$Parms = " /Install /Quiet /Norestart /Logs SQLServerSSMSlog.txt"
$Prms = $Parms.Split(" ")
& "$filepath" $Prms | Out-Null
Write-Host "done!" -ForegroundColor Green


# Start the SQL RS downloader
$filepath="$folderpath\SQLServerReportingServices.exe"
if (!(Test-Path $filepath)){
write-host "Downloading SQL Server 2017 Reporting Services..." -nonewline
$URL = "https://aka.ms/ssmsfullsetup"
Invoke-WebRequest $URL -OutFile $filepath
Write-Host "done!" -ForegroundColor Green
}
 else {
write-host "found the SQL RS Installer, no need to download it..."
}

# Start the SQL RS installer
write-host "Installing SQL Server 2017 Reporting Services..." -nonewline
$Parms = "  /IAcceptLicenseTerms True /Quiet /Norestart /Log SQLServerReportingServiceslog.txt"
$Prms = $Parms.Split(" ")
& "$filepath" $Prms | Out-Null
Write-Host "done!" -ForegroundColor Green

# Configure SQL memory
write-host "Configuring SQL memory..." -nonewline

[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | Out-Null
$SQLMemory = New-Object ('Microsoft.SqlServer.Management.Smo.Server') ("(local)")
$SQLMemory.Configuration.MinServerMemory.ConfigValue = $SQLMemMin
$SQLMemory.Configuration.MaxServerMemory.ConfigValue = $SQLMemMax
$SQLMemory.Configuration.Alter()
Write-Host "done!" -ForegroundColor Green
write-host ""

# Update the SQL Server 2012 Native Client (installed with SQL Server 2017) to support TLS 1.2 - added by Niall Brady 2019/4/28        

# Checking SQL Server Native Client in registry
$Results = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\SQLNCLI11\CurrentVersion"| Select-Object Version
If ($Results.Version -lt  "11.4.7001.0")
    {write-host "Wrong SQL Server Native client version found, upgrading it..."
    # start the SQL Server Native Client downloader
    $filepath="$folderpath\sqlncli.msi"
    if (!(Test-Path $filepath)){
        write-host "Downloading SQL Server Native Client (64 bit) from https://www.microsoft.com/en-us/download/details.aspx?id=50402 ..." -nonewline
        $URL = "https://download.microsoft.com/download/B/E/D/BED73AAC-3C8A-43F5-AF4F-EB4FEA6C8F3A/ENU/x64/sqlncli.msi"
        Invoke-WebRequest $URL -OutFile $filepath
        Write-Host "done!" -ForegroundColor Green
        }
     else 
        {
        write-host "found the SQL Server Native Client (64 bit), no need to download it..."
        }

    # start the SQL Server Native Client (64 bit) upgrade...
    write-host "about to upgrade SQL Server Native Client (64 bit)..." -nonewline
    $arguments = "/i `"$filepath`" /quiet IACCEPTSQLNCLILICENSETERMS=YES"
    # to do, add logging... 
    # /L*V C:\Windows\temp\SQLNativeClient11\sqlNativeClientInstall.log
    Start-Process msiexec.exe -ArgumentList $arguments -Wait
    Write-Host "done!" -ForegroundColor Green
  
    }
else
    {write-host "SQL Server Native Client (64 bit) is an ok version for TLS 1.2, no need to update it."}

# exit script
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
