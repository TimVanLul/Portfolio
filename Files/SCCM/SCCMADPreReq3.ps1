#------------------------------------------------------------------
#- Adding permissions container Pre Requisites For SCCM           -
#------------------------------------------------------------------

  If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] “Administrator”))

    {
        Write-Warning “You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!”
        Break
    }

# Install the needed windows feature to communicate with AD
Install-windowsfeature -name AD-Domain-Services –IncludeManagementTools

#Import AD module if not already loaded
Import-Module -Name ActiveDirectory

# Derive domain name
$namingContext = (Get-ADRootDSE).defaultNamingContext
$ConfigMgrSrv = "SCCM-Server"

# Define path for System Management Container
$sccmContainer = "CN=System Management,CN=System,$namingContext"

# Get SID of SCCM Server
$configMgrSid = [System.Security.Principal.IdentityReference] (Get-ADComputer $ConfigMgrSrv).SID

# Get current ACL set for System Management Container
$cnACL = Get-Acl -Path "ad:$sccmContainer"

# Sepcify Permission to Full Control
$adPermissions = [System.DirectoryServices.ActiveDirectoryRights] 'GenericAll'

# Specify Permission type to allow access
$permissionType = [System.Security.AccessControl.AccessControlType] 'Allow'

# Set Inheritance for the Container to "This object and all child objects"
$inheritanceType = [System.DirectoryServices.ActiveDirectorySecurityInheritance] 'All'

# Set System Management container Access Control Entry
$cnACE = New-Object -TypeName System.DirectoryServices.ActiveDirectoryAccessRule -ArgumentList $configMgrSid, $adPermissions, $permissionType , $inheritanceType

# Add Access Control Entry to existing ACL
$cnACL.AddAccessRule($cnACE) 

# Finally Set ACL on System Management Container
Set-Acl -AclObject $cnACL -Path "AD:$sccmContainer"
write-host "Permissions delegated."