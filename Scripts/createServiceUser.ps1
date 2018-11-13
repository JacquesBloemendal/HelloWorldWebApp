$UserName = ServiceUser
$DisplayName = ServiceUser for .NET Core app
$path = c:\svc


$Secure_String_Pwd = ConvertTo-SecureString "Movir2018!" -AsPlainText -Force
New-LocalUser -Name $UserName -Password $Secure_String_Pwd

$cmd = "icacls '"c:\svc'" /grant ServiceUser:(OI)(CI)WRX /t".


sc create WebApp binPath= "c:\svc\WebApp.exe" obj= "LPZWNL000027039\ServiceUser" password= "Movir2018!"