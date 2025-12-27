#Ayuda
Get-Help
Get-Help *SQL*
Get-Help -showWindow

#Variables
$nombre=hostname
$nombre

#Restriccion
Get-ExecutionPolicy
Set-ExecutionPolicy Unrestricted
Get-ExecutionPolicy

#Alias
Get-Alias
$nombre | out-file C:\hostname.txt
Get-Alias
New-Alias -Name notas -Value Notepad
notas


#Instalar SQL
Install-Module -Name SqlServer -AllowClobber
#Comprobar instalación
Get-Module SqlServer -ListAvailable
#Comprobar comandos
Get-Command -Module SqlServer -CommandType Cmdlet | Out-GridView 
Get-Command -Module SqlServer | Out-GridView 