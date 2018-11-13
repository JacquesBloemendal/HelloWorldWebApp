$service
$serviceName = "WebApp"
$installPath = "C:\svc"
$removeService = $false

try{
    $service = Get-Service -Name $serviceName -ErrorAction Stop
    $removeService = $true }
catch [Microsoft.PowerShell.Commands.ServiceCommandException] { 
    if(Test-Path($installPath)) {$removeService = $true}
}

if($removeService -eq $false) {
    Write-Host "The service does not exist."
    Break
}

# Start remove
Write-Host "Start removing service $serviceName..."
try{
    $service = Get-Service -Name $serviceName -ErrorAction Stop
    Write-Host "Checking if service needs to be stopped..."
    if($service.Status -ne "Stopped") {
        Write-Host "Stopping service..."
        $service.Stop()}

    Write-Host "Service is stopped. Removing service..."
    Remove-Service $serviceName }
catch [Microsoft.PowerShell.Commands.ServiceCommandException] { 

    Write-Host "The service does not exist."
}

Write-Host "Deleting files of service..."
if(Test-Path $installPath) { Remove-Item $installPath -Recurse } 
Write-Host "Service successfully removed."