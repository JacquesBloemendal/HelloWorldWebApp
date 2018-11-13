
dotnet publish --configuration Release --runtime win10-x64 --output c:\svc

# Copy-Item -Path .\Bin\Release -Destination C:\Temp\WebApp\Bin -Recurse

try {
    Get-Service -Name WebApp 
}
catch {
    
    New-Service -BinaryPathName C:\svc\WebApp.exe -Name WebApp
}


