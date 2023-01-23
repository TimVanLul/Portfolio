#------------------------------------------------------------------
#- Extending Active Directory Schema                  -------------
#------------------------------------------------------------------

# Location Media (DC drive)
$SCCMPath = "D:\"

# please don't edit below this line

# Check for SCCM source files
write-host "Looking for ConfigMgr media in '$SCCMPath'..." -nonewline
if (Test-Path "$SCCMPath\SMSSETUP"){
Write-Host "done!" -ForegroundColor Green
 } else {
write-host "Error" -ForegroundColor Red
write-host "Please extract the SCCM media to '$SCCMPath' and then try running this script again..."
break}

$answer = Read-Host "Extend the schema ?" 

while("yes","no","y","n" -notcontains $answer)
{
	$answer = Read-Host "Yes No"
}
if ($answer -eq "No" -or $answer -eq "n"){
write-host "skipping schema extension"
}
else
{   $Credential = $Host.ui.PromptForCredential("Need credentials", "Please enter suitable administrative credentials for extending the schema.", "", "NetBiosUserName")
    # extend the schema 
    write-host "about to extend the schema..." -nonewline
    $filepath = "$SCCMPath\SMSSETUP\bin\X64\extadsch.exe"

Try
    {Start-Process "$filepath" -Credential $Credential | Out-Null}
    catch
    {Write-Warning -Message $("Failed to extend the schema, error:" + $_.Exception.Message)
    break;}
    Write-Host "done!" -ForegroundColor Green
    Start-Sleep 30
}
