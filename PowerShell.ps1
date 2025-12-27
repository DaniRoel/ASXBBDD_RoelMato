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
#Comprobar Servicios
Get-Service | where-Object{$_.name -like '*sql*'} | Format-Table –AutoSize
#Arrancar Servicio
Start-Service "SQLSERVERAGENT"
Get-Service | ?{$_.name -like '*SQLSERVERAGENT*'} | ogv
Stop-Service "SQLSERVERAGENT"
Get-Service | ?{$_.name -like '*SQLSERVERAGENT*'} | ogv
#Invoke-Sqlcmd
Invoke-Sqlcmd -Query "SELECT * FROM PRODUCTO" -ConnectionString "Data Source=.;Initial Catalog=Herboristeria;Integrated Security=True;TrustServerCertificate=True;ApplicationIntent=ReadOnly" | Format-Table -AutoSize
Invoke-Sqlcmd -ServerInstance "localhost" -Database "Herboristeria" -Username "sa" -Password "sa" -Query "SELECT * FROM VENTA" -TrustServerCertificate
#Backups
Backup-SqlDatabase -ServerInstance "localhost" -Database "Herboristeria"
#Backup_ruta
$dt = Get-Date -Format dd-MMM-yy
$instancename = "localhost"
$dbname = 'Herboristeria'
Backup-SqlDatabase -Serverinstance $instancename -Database $dbname -BackupFile "C:\Backup\BK_$($dbname)_$($dt).bak"
#Backup Invoke
Invoke-Sqlcmd -Query "BACKUP DATABASE Herboristeria TO DISK = 'C:\Backup\Invoke_herboristeria.bak' WITH FORMAT" -ConnectionString "Server=localhost;Integrated Security=True;TrustServerCertificate=True"

#Restore
    #Eliminar BBDD
$instancia = "localhost"
$bbdd = 'Herboristeria'
Invoke-Sqlcmd -Serverinstance $instancia -TrustServerCertificate -Query "Drop database $bbdd;"
    #Recuperar BBDD
$instancia = "localhost"
$bbdd = 'Herboristeria'
$archivo = 'C:\Backup\BK_Herboristeria_27-dic.-25.bak'
Restore-Sqldatabase -Serverinstance $instancia -Database $bbdd -Backupfile $archivo -replacedatabase
#Comprobar
Invoke-Sqlcmd -ServerInstance $instancia -Database $bbdd -Username "sa" -Password "sa" -Query "SELECT * FROM PRODUCTO" -TrustServerCertificate


#DBA Tools
#Instalar
Install-Module -Name dbatools 
#Actualizar DBATOOLS
Update-Module -Name dbatools 
#Test DBA
Get-Module dbatools -ListAvailable
Test-DbaConnection localhost 
Get-DbaDatabase -SqlInstance "Data Source=localhost;TrustServerCertificate=True;" -Database herboristeria 
#Crear BBDD
$instancia =  "Data Source=localhost;TrustServerCertificate=True;"
$Nombre = 'HerboristeriaDBA'
$Recoverymodel = 'Simple'
$Owner = 'sa'
$PrimaryFilesize = 1024
$PrimaryFileGrowth = 256
$LogSize = 512
$LogGrowth = 128
New-DbaDatabase -SqlInstance $instancia -Name $Nombre -Recoverymodel $Recoverymodel -Owner $Owner
#Comprobar
Get-DbaDatabase -SqlInstance $instancia -Database $Nombre
#Backup
    #Creo Carpeta
New-Item "C:\Backup\dbatools" -ItemType Directory
    #Lanzo Backup
$destino = 'C:\Backup\dbatools\'
Backup-DbaDatabase -SqlInstance  $instancia -Path $destino -Database $Nombre -Type Full
cd C:\Backup\dbatools
ls

#Borrar BBDD
Get-DbaDatabase -SqlInstance $instancia -Database $Nombre
Remove-DbaDatabase -SqlInstance $instancia -Database $nombre
Get-DbaDatabase -SqlInstance $instancia -Database $Nombre
#Restaurar DBA
Restore-DbaDatabase -SqlInstance $instancia -Path $destino -DestinationDataDirectory 'C:\BD Ejemplo' -WithReplace
Restore-DbaDatabase -SqlInstance $instancia -Path $destino
Get-DbaDatabase -SqlInstance $instancia -Database $Nombre