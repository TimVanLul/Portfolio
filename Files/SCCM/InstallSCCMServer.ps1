#------------------------------------------------------------------
#- Install SCCM on server                             -------------
#------------------------------------------------------------------

  If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] “Administrator”))

    {
        Write-Warning “You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!”
        Break
    }

# below variables are customizable
$SourcePath = "C:\Source"
# where is the media mounted ?
$SCCMPath = "D:\"
$PrerequisitesPath = "C:\Source\SCCM"
$DestinationServer = "echo.corona2020.local"
# Installation specific variables
$Action="InstallPrimarySite"
$ProductID="EVAL"
$SiteCode="P01"
$Sitename="Corona2020 Primary Site"
$SMSInstallDir="F:\SCCM"
$SDKServer=$DestinationServer
$RoleCommunicationProtocol="HTTPorHTTPS"
$ClientsUsePKICertificate="0"
$PrerequisiteComp="1"
$ManagementPoint=$DestinationServer
$ManagementPointProtocol="HTTP"
$DistributionPoint=$DestinationServer
$DistributionPointProtocol="HTTP"
$DistributionPointInstallIIS="0"
$AdminConsole="1"
$JoinCEIP="0"
$SQLServerName=$DestinationServer
$DatabaseName="CM_P01"
$SQLSSBPort="4022"
$CloudConnector="1"
$CloudConnectorServer=$DestinationServer
$UseProxy="0"
$ProxyName=""
$ProxyPort=""
$SysCenterId=""

# please don't edit below this line

write-host ""
write-host "Starting the installation of System Center Configuration Manager."

# Check for SCCM source files
write-host "Looking for ConfigMgr media in '$SCCMPath'..." -nonewline
if (Test-Path "$SCCMPath\SMSSETUP"){
Write-Host "done!" -ForegroundColor Green
 } else {
write-host "Error" -ForegroundColor Red
write-host "Please extract the SCCM media to '$SCCMPath' and then try running this script again..."
break}

write-host "Checking for'$PrerequisitesPath' folder..." -nonewline

# Check for prerequisites download path folder, if not present create it
if (Test-Path "$PrerequisitesPath"){
 Write-Host "done!" -ForegroundColor Green
 
 } else {
mkdir "$PrerequisitesPath" | out-null
Write-Host "done!" -ForegroundColor Green

# start the SCCM prerequisite downloader
write-host "Downloading SCCM version prerequisite files..." -nonewline
$filepath = "$SCCMPath\SMSSETUP\bin\X64\SETUPDL.exe"
$Parms = "`"$PrerequisitesPath`""
$Prms = $Parms.Split(" ")

Try
{& "$filepath" $Prms | Out-Null}
catch
{Write-Host "error!" -ForegroundColor red
break}
Write-Host "done!" -ForegroundColor Green
}

# do not edit below this line

$conffile= @"
[Identification]
Action="$Action"

[SABranchOptions]
SAActive=1
CurrentBranch=1

[Options]
ProductID="$ProductID"
SiteCode="$SiteCode"
SiteName="$Sitename"
SMSInstallDir="$SMSInstallDir"
SDKServer="$SDKServer"
RoleCommunicationProtocol="$RoleCommunicationProtocol"
ClientsUsePKICertificate="$ClientsUsePKICertificate"
PrerequisiteComp="$PrerequisiteComp"
PrerequisitePath="$PrerequisitesPath"
ManagementPoint="$ManagementPoint"
ManagementPointProtocol="$ManagementPointProtocol"
DistributionPoint="$DistributionPoint"
DistributionPointProtocol="$DistributionPointProtocol"
DistributionPointInstallIIS="$DistributionPointInstallIIS"
AdminConsole="$AdminConsole"
JoinCEIP="$JoinCEIP"

[SQLConfigOptions]
SQLServerName="$SQLServerName"
DatabaseName="$DatabaseName"
SQLSSBPort="$SQLSSBPort"

[CloudConnectorOptions]
CloudConnector="$CloudConnector"
CloudConnectorServer="$CloudConnectorServer"
UseProxy="$UseProxy"
ProxyName="$ProxyName"
ProxyPort="$ProxyPort"

[SystemCenterOptions]
SysCenterId="$SysCenterId"

[HierarchyExpansionOption]
"@

# Check for Script Directory & file
if (Test-Path "$SourcePath"){
 write-host "The folder '$SourcePath' already exists, will not recreate it."
 } else {
mkdir "$SourcePath"
}
if (Test-Path "$SourcePath\ConfigMgrAutoSave.ini"){
 write-host "The file '$SourcePath\ConfigMgrAutoSave.ini' already exists, removing..."
 Remove-Item -Path "$SourcePath\ConfigMgrAutoSave.ini" -Force
 } else {
 # Create file:
 write-host "Creating '$SourcePath\ConfigMgrAutoSave.ini'..." -nonewline
New-Item -Path "$SourcePath\ConfigMgrAutoSave.ini" -ItemType File -Value $Conffile | Out-Null
Write-Host "done!" -ForegroundColor Green
}

# start the SCCM installer
write-host "installing SCCM (please wait)..." -nonewline
$filepath = "$SCCMPath\SMSSETUP\bin\X64\Setup.exe"
$Parms = "  /script $SourcePath\ConfigMgrAutoSave.ini"
$Prms = $Parms.Split(" ")
Try
{& "$filepath" $Prms | Out-Null}
catch
{Write-Warning -Message $("There was an error" + $_.Exception.Message)
break}
Write-Host "done!" -ForegroundColor Green


# exit script
write-host "Exiting script, goodbye."

