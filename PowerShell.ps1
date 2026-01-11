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

#Procedimientos Almacenados.
Invoke-Sqlcmd -Query "SELECT * FROM PRODUCTO" -ConnectionString "Data Source=.;Initial Catalog=Herboristeria;Integrated Security=True;TrustServerCertificate=True;ApplicationIntent=ReadOnly" | Format-Table -AutoSize
Invoke-Sqlcmd -ServerInstance localhost -Database Herboristeria -Query "CAMBIAR_PRECIO @nuevoprecio = 10.50, @nombre = 'Miel de Romero'" -TrustServerCertificate
Invoke-Sqlcmd -Query "SELECT * FROM PRODUCTO" -ConnectionString "Data Source=.;Initial Catalog=Herboristeria;Integrated Security=True;TrustServerCertificate=True;ApplicationIntent=ReadOnly" | Format-Table -AutoSize


#SMO
#Definimos variable para nuestro equipo
$instanceName = "localhost"
#Definimos variable para la instancia
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

# Consultamos las bases de datos de nuestra instancia.
$server.Databases | Select Name, Status, Owner, CreateDate

#Crear base de datos nueva
$dbName = "Herboristeria_SMO"
$creardb = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database($server, $dbName)
$creardb.Create()
# Consultamos las bases de datos de nuestra instancia.
$server.Databases | Select Name, Status, Owner, CreateDate

#Prueba de conexión
$conectarse = Connect-DbaInstance -SqlInstance LOCALHOST -TrustServerCertificate
Get-DbaDatabase -SqlInstance $conectarse -Database Herboristeria_SMO

#Borrar la bbdd.
$db = $server.Databases[$dbName]
if ($db)
{
    $server.KillDatabase($dbName)   #se usa "kill" porque con drop daría error si existiese conexión
}
#Comprobar 
$server.Databases | Select Name, Status, Owner, CreateDate



#ADO.NET
#Crear variable con nombre de la base de datos
$dbname = "Herboristeria_ADO.NET";
    #Se crea la conexión con SQL
$con = New-Object Data.SqlClient.SqlConnection;
$con.ConnectionString = "Data Source=.;Initial Catalog=master;Integrated Security=True;";
$con.open();
    #Creamos la base de datos
$sql = "CREATE DATABASE [$dbname];"
$cmd = New-Object Data.SqlClient.SqlCommand $sql, $con;
$cmd.ExecuteNonQuery();
Write-Host "Database $dbname creada!";
    #Cerramos y liberamos memoria
$cmd.Dispose();
$con.Close();
$con.Dispose();

#Eliminar BBDD
$con = New-Object Data.SqlClient.SqlConnection;
$con.ConnectionString = "Data Source=.;Initial Catalog=master;Integrated Security=True;";
$con.open();
$sqlCommand = New-Object Data.SqlClient.SqlCommand("DROP DATABASE [$dbname]", $con);
$sqlCommand.ExecuteNonQuery()
$cmd.Dispose();
$con.Close();
$con.Dispose();

#TRY - CATCH
try
{
    $connString = "Data Source=.;Database=Herboristeria;User ID=marga;Password=Abcd1234."
    $conn = New-Object System.Data.SqlClient.SqlConnection $connString
    $conn.Open()
    if($conn.State -eq "Open")
    {
        Write-Host "Cadena de conexión exitosa. Conectado correctamente"
        $conn.Close()
    }
}
catch
{
    Write-Host "Error en la cadena de conexión. No se ha podido establecer la conexión"

}
$cmd.Dispose();
$con.Close();
$con.Dispose();

#PROCEDIMIENTO ALMACENADO
#Abrimos la cadena de conexión
$SqlConn = New-Object System.Data.SqlClient.SqlConnection("Server = localhost; Database = Herboristeria; Integrated Security = True;")
$SqlConn.Open()
#Indicamos que vamos a utilizar el procedimiento almacenado "CAMBIAR_PRECIO"
$cmd = $SqlConn.CreateCommand()
$cmd.CommandType = 'StoredProcedure'
$cmd.CommandText = 'dbo.CAMBIAR_PRECIO'

# Damos valor al parametro de entrada @nombre
$p1 = $cmd.Parameters.Add('@nombre',[System.Data.SqlDbType]::VarChar)
$p1.ParameterDirection.Input
$p1.Value = "Lavanda Seca"

# Damos valor al parametro de entrada @nuevoprecio
$p2 = $cmd.Parameters.Add('@nuevoprecio',[System.Data.SqlDbType]::Money)
$p2.ParameterDirection.Input
$p2.Value = '6,55'
#Ejecutamos los cambios
$results = $cmd.ExecuteReader()
$dt = New-Object System.Data.DataTable
$dt.Load($results)
$SqlConn.Close()
