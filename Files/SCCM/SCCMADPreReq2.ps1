#------------------------------------------------------------------
#- Adding OU and Users to AD Pre Requisites For SCCM              -
#------------------------------------------------------------------

# Variables
$DistinguishedName="DC=corona2020,DC=local"
$OUroot="corona2020"
$OUchild=@("Security Groups","Servers","Service Accounts","Users","Workstations")
$OUchild2=@("SCCM","MDT")
$Password = "Server19"

## Users
$CMUsers = @("CM_BA", "CM_JD", "CM_NAA", "CM_RS", "CM_TS", "CM_WS")
$MDTUsers = @("MDT_BA", "MDT_JD")

#Functions
function ADDOU($OUName, $OUPath) {
   try {$IsOUInAD=Get-ADOrganizationalUnit -Identity "OU=$OUName,$OUPath" 
         write-host "The $OUNAme OU was already found in AD."
        }
    catch {
   write-host "About to add the following OU: " -ForegroundColor White -NoNewline 
   write-host $OUName -ForegroundColor Green -NoNewLine
   write-host -ForegroundColor White " to this OUPath: " -NoNewLine
   write-host $OUPath -ForegroundColor Green -NoNewLine
            New-ADOrganizationalUnit -Name $OUName -Path $OUPath
            write-host " Done !" -ForegroundColor White}
}

function ADDUser($User, $DistinguishedName, $SelectedOU) {


    try {$IsUsserInAD=Get-ADUser -LDAPFilter "(sAMAccountName=$User)"
        If ($IsUsserInAD -eq $Null) 
            {write-host "User $User does not exist in AD, adding..." -NoNewline
            New-ADUser -Name $User -GivenName $User -SamAccountName $User -UserPrincipalName $User$DistinguishedName -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Path $SelectedOU -PassThru | Enable-ADAccount
            # -ErrorAction Stop -Verbose
            write-host "Done !" -ForegroundColor Green}
        Else {
            write-host "User $User was already found in AD."
             }
        }
        catch{
   write-host "About to add the following User: " -ForegroundColor White -NoNewline 
   write-host $User -ForegroundColor Green -NoNewLine
   write-host -ForegroundColor White " to this DistinguishedName: " -NoNewLine
   write-host $SelectedOU -ForegroundColor Green
            }  
}  

#end functions

#Check if script is run as an Administrator
  If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] “Administrator”))

    {
        Write-Warning “You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!”
        Break
    }

#Check if  script is run on AD
try {
    Import-Module ActiveDirectory
    }
    catch {
    Write-host "The Active Directory module was not found, try running this on the DC."
    }

#create Users and OUs


## add root OU

write-host "Adding the root OU..." -ForegroundColor yellow

$OUName=$OUroot
$OUPath=$DistinguishedName

ADDOU $OUName $OUPath

## add 2ndlevel OUs

write-host "Adding child OU's..." -ForegroundColor yellow

$OUName=$OUchild
$OUPath="OU=" + $OUroot + "," + $DistinguishedName  

## create an array of OUs to add to AD
foreach($OU in $OUchild){
            ADDOU $OU $OUPath
} 

write-host "Adding more child OU's..." -ForegroundColor yellow

## add 3rdlevel OUs

$OUName=$OUchild2
$OUPath="OU=Service Accounts,OU=" + $OUroot + "," + $DistinguishedName

## create an array of OUs to add to AD
foreach($OU in $OUchild2){
            ADDOU $OU $OUPath
}  

## add ConfigMgr users

$SelectedOU="OU=SCCM,OU=Service Accounts,OU=$OURoot," + $DistinguishedName

write-host "Adding Users to " -ForegroundColor yellow -NoNewline
write-host $SelectedOU -ForegroundColor green


foreach($User in $CMUsers){
ADDUser $User $DistinguishedName $SelectedOU
}

## add MDT users

$SelectedOU="OU=MDT,OU=Service Accounts,OU=$OURoot," + $DistinguishedName

write-host "Adding Users to " -ForegroundColor yellow -NoNewline
write-host $SelectedOU -ForegroundColor green

foreach($User in $MDTUsers){
ADDUser $User $DistinguishedName $SelectedOU
}