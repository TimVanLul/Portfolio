#------------------------------------------------------------------
#- Install ADK/WDS                                    -------------
#------------------------------------------------------------------

function TestPath($Path) {
if ( $(Try { Test-Path $Path.trim() } Catch { $false }) ) {
   write-host "Path OK"
 }
Else {
   write-host "$Path not found, please fix and try again."
   break
 }}

# Variables
$SourcePath = "C:\Source"
## Filelocations
$file1 = $SourcePath+"\adksetup.exe"
$file2 = $SourcePath+"\adkwinpesetup.exe"
## Installtion location
$ADKPath = '{0}\Windows Kits\10\ADK' -f $SourcePath;
$ADKPath2 = '{0}\Windows Kits\10\ADK\Installers\Windows PE x86 x64-x86_en-us.msi' -f $SourcePath;
##Install command
$ArgumentList = '/layout "{0}" /quiet' -f $ADKPath;

#Check if user is administrator

    If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] “Administrator”))
    {
        Write-Warning “You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!”
        Break
    }

# Check if source directory exists
if (Test-Path $SourcePath){
    Write-Host "Path $SourcePath exists."
} else {
    New-Item -ItemType Directory -Path C:\Source
}

# Check if these files exists

if (Test-Path $file1){
 write-host "The file $file1 exists."
 } else {
 # Download ADK to sourcepath if it doesn't exist
        Write-Host "Downloading Adksetup.exe " -nonewline
		$url = "https://go.microsoft.com/fwlink/?linkid=2120254"
		Invoke-WebRequest $url -OutFile $file1
		Write-Host "done!" -ForegroundColor Green
 }

if (Test-Path $ADKPath){
 Write-Host "The folder $ADKPath exists, skipping download"
 } else{
 
Write-Host "Downloading Windows ADK 10, please wait..."  -nonewline
Start-Process -FilePath $file1 -Wait -ArgumentList $ArgumentList
Write-Host "done!" -ForegroundColor Green
 }
 
Start-Sleep -s 3


if (Test-Path $file2){
 write-host "The file $file2 exists."
 } else {
 # Download Windows PE for ADK to sourcepath if it doesn't exist
        Write-Host "Downloading Adkwinpesetup.exe " -nonewline
		$url = "https://go.microsoft.com/fwlink/?linkid=2120253"
		Invoke-WebRequest $url -OutFile $file2
		Write-Host "done!" -ForegroundColor Green
 }

if (Test-Path $ADKPath2){
 Write-Host "The file $ADKPath2 exists, skipping download"
 } else{
 
Write-Host "Downloading the Windows PE addon for ADK, please wait..."  -nonewline
Start-Process -FilePath $file2 -Wait -ArgumentList $ArgumentList
Write-Host "done!" -ForegroundColor Green
 }
 
Start-Sleep -s 10

# This installs Windows Deployment Service
Write-Host "Installing Windows Deployment Services..."  -nonewline
Import-Module ServerManager
Install-WindowsFeature -Name WDS -IncludeManagementTools
Sleep 10

# Install ADK Deployment Tools
Write-Host "Installing Windows ADK ..."
Start-Process -FilePath "$ADKPath\adksetup.exe" -Wait -ArgumentList " /Features OptionId.DeploymentTools OptionId.ImagingAndConfigurationDesigner OptionId.UserStateMigrationTool /norestart /quiet /ceip off"
Sleep 20
Write-Host "Done !"

# Install Windows Preinstallation Enviroment
Write-Host "Installing Windows PE..."
Start-Process -FilePath "$ADKPath\adkwinpesetup.exe" -Wait -ArgumentList " /Features OptionId.WindowsPreinstallationEnvironment /norestart /quiet /ceip off"
Sleep 20

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