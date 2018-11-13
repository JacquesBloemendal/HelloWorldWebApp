$service
$serviceName = "WebApp"
$serviceDisplayName = "Hello World Web Application"
$serviceDescription = "Provides an interface to the Hello World Application"
$installPath = "C:\svc"

# Remove service if already exists..
Invoke-Expression $PSScriptRoot\RemoveService.ps1

# Start publish
Write-Host "Start publishing..."
dotnet publish "..\$serviceName.csproj" -c Release -r win10-x64 --output $installPath
Write-Host "Done publishing"

Write-Host "Checking if service already exists "
try{ $service = Get-Service -Name $serviceName -ErrorAction Stop }
catch [Microsoft.PowerShell.Commands.ServiceCommandException] { 
    Write-Host "Service not found. Creating Service..."
    New-Service `
        -Name $serviceName `
        -BinaryPathName $installPath\$serviceName.exe `
        -DisplayName $serviceDisplayName `
        -Description $serviceDescription `
        -StartupType Automatic
    Write-Host "Service successfully created."
}