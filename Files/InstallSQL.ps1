
# Installation of SQL
Start-Process -FilePath ./SQLServer.exe -ArgumentList "/action=download /quiet /enu /MediaPath=C:/" -wait
& 'SETUP.exe /Q /IACCEPTSQLSERVERLICENSETERMS /Action=Install /Hideconsole /Features=SQL,RS,Tools /InstanceName=SQLExpress /SQLSYSADMINACCOUNTS="Builtin\Administrators" /SQLSVCACCOUNT="NT AUTHORITY\SYSTEM"'