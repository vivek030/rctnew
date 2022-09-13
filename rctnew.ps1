
function Show-Menu

{

    param (
        [string]$Title = 'Select type of User'
    )
    Clear-Host
    Write-Host "================ $Title ================"
 
    Write-Host "Press 1 for Default users."
    Write-Host "Press 2 for Management users."
    Write-Host "Press Q to quit."
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {

         $dns = "2a07:a8c0::e9:59cb,2a07:a8c1::e9:59cb"
Do {$email = Read-Host 'Enter Email ID'} while ([string]::IsNullOrWhiteSpace($email))
$emaill = $email -replace "\s", ""
Do {$id = Read-Host 'Enter Friendly Name'} while ([string]::IsNullOrWhiteSpace($id))
$idd = $id -replace "\s", ""
$hostname = hostname
$name = "$idd/$hostname"
Do {$api = Read-Host 'Enter API Key'} while ([string]::IsNullOrWhiteSpace($api))
$apii = $api -replace "\s", ""
$json = @"
{\"Email\":\"$emaill\",\"Identifier\":\"$name\",\"DNSStr\":\"$dns\"}
"@
curl.exe --silent  -f -k -X POST "https://digamber.korplink.com/api/v1/provisioning/peers" -H "accept: text/plain" -H "authorization: Basic $apii" -H "Content-Type: application/json" -d $json -o "C:\krpl.conf" | Out-Null
if($?)
{
   
   Write-Host "Installation in progress, please wait, completed 10%" -ForegroundColor Green
   #Write-Host "VPN Profile created succesfully" -ForegroundColor Green
}
else
{
  
   Write-Host "Could not create VPN profiles, please contact KorpLink Support" -ForegroundColor Red
    return
}
Start-Process msiexec.exe -ArgumentList '/q','DO_NOT_LAUNCH=True','/I', 'https://download.wireguard.com/windows-client/wireguard-amd64-0.4.9.msi' -Wait -NoNewWindow -PassThru | Out-Null
if($?)
{
    Write-Host "Installation in progress, please wait, completed 20%" -ForegroundColor Green
    #Write-Host "KorpLink Client installed succesfully" -ForegroundColor Green
}
else
{
   Write-Host "Could not install KorpLink Client, please contact KorpLink Support" -ForegroundColor Red
    return
}
Start-Process 'C:\Program Files\WireGuard\wireguard.exe' -ArgumentList '/installtunnelservice', '"C:\krpl.conf"' -Wait -NoNewWindow -PassThru | Out-Null
if($?)
{
 Write-Host "Installation in progress, please wait, completed 30%" -ForegroundColor Green
#Write-Host "KorpLink tunnel installed" -ForegroundColor Green
}
else
{
   Write-Host "KorpLink tunnel not installed, please contact KorpLink Support" -ForegroundColor Red
    return
}
Start-Process sc.exe -ArgumentList 'config', 'WireGuardTunnel$krpl', 'start= delayed-auto' -Wait -NoNewWindow -PassThru | Out-Null
if($?)
{
Write-Host "Installation in progress, please wait, completed 40%" -ForegroundColor Green   
#Write-Host "KorpLink set to automatic start" -ForegroundColor Green
}
else
{
   Write-Host "KorpLink failed to start automatically, please contact KorpLink Support" -ForegroundColor Red
    return
}

Start-Service -Name WireGuardTunnel$krpl -ErrorAction SilentlyContinue | Out-Null
Write-Host "Installation in progress, please wait, completed 50%" -ForegroundColor Green

curl.exe --silent  -f -k "https://raw.githubusercontent.com/vivek030/update/main/wgupdate.xml" -o "C:\wgupdate.xml"
if($?)
{
 Write-Host "Installation in progress, please wait, completed 60%" -ForegroundColor Green   
#Write-Host "KorpLink automatic update file downloaded" -ForegroundColor Green
}
else
{
   Write-Host "KorpLink automatic update file download failed, please contact KorpLink Support" -ForegroundColor Red
    return
}
schtasks /Create /XML "C:\wgupdate.xml" /TN wgupdate | Out-Null
if($?)
{
Write-Host "Installation in progress, please wait, completed 70%" -ForegroundColor Green      
#Write-Host "KorpLink update job scheduled succesfully" -ForegroundColor Green
}
else
{
   Write-Host "KorpLink update job failed, please contact KorpLink Support" -ForegroundColor Red
    return
}
Start-ScheduledTask -TaskName wgupdate | Out-Null
Write-Host "Installation in progress, please wait, completed 80%" -ForegroundColor Green
ipconfig /flushdns | Out-Null
if($?)
{
Write-Host "Installation in progress, please wait, completed 90%" -ForegroundColor Green    
#Write-Host "Windows DNS Flushed" -ForegroundColor Green
}
else
{
   Write-Host "Could Not flush Windows DNS, please contact KorpLink Support" -ForegroundColor Red
    return
}
 
Write-Host "KorpLink installation completed !!!" -ForegroundColor Green


     } '2' {
         $dns = "2a07:a8c0::ae:4156,2a07:a8c1::ae:4156"

Do {$email = Read-Host 'Enter Email ID'} while ([string]::IsNullOrWhiteSpace($email))
$emaill = $email -replace "\s", ""
Do {$id = Read-Host 'Enter Friendly Name'} while ([string]::IsNullOrWhiteSpace($id))
$idd = $id -replace "\s", ""
$hostname = hostname
$name = "$idd/$hostname"
Do {$api = Read-Host 'Enter API Key'} while ([string]::IsNullOrWhiteSpace($api))
$apii = $api -replace "\s", ""
$json = @"
{\"Email\":\"$emaill\",\"Identifier\":\"$name\",\"DNSStr\":\"$dns\"}
"@
curl.exe --silent  -f -k -X POST "https://digamber.korplink.com/api/v1/provisioning/peers" -H "accept: text/plain" -H "authorization: Basic $apii" -H "Content-Type: application/json" -d $json -o "C:\krpl.conf" | Out-Null
if($?)
{
   Write-Host "Installation in progress, please wait, completed 10%" -ForegroundColor Green
   #Write-Host "VPN Profile created succesfully" -ForegroundColor Green
}
else
{
   Write-Host "Could not create VPN profiles, please contact KorpLink Support" -ForegroundColor Red
    return
}
Start-Process msiexec.exe -ArgumentList '/q','DO_NOT_LAUNCH=True','/I', 'https://download.wireguard.com/windows-client/wireguard-amd64-0.4.9.msi' -Wait -NoNewWindow -PassThru | Out-Null
if($?)
{
    Write-Host "Installation in progress, please wait, completed 20%" -ForegroundColor Green
    #Write-Host "KorpLink Client installed succesfully" -ForegroundColor Green
}
else
{
   Write-Host "Could not install KorpLink Client, please contact KorpLink Support" -ForegroundColor Red
    return
}
Start-Process 'C:\Program Files\WireGuard\wireguard.exe' -ArgumentList '/installtunnelservice', '"C:\krpl.conf"' -Wait -NoNewWindow -PassThru | Out-Null
if($?)
{
 Write-Host "Installation in progress, please wait, completed 30%" -ForegroundColor Green
#Write-Host "KorpLink tunnel installed" -ForegroundColor Green
}
else
{
   Write-Host "KorpLink tunnel not installed, please contact KorpLink Support" -ForegroundColor Red
    return
}
Start-Process sc.exe -ArgumentList 'config', 'WireGuardTunnel$krpl', 'start= delayed-auto' -Wait -NoNewWindow -PassThru | Out-Null
if($?)
{
Write-Host "Installation in progress, please wait, completed 40%" -ForegroundColor Green   
#Write-Host "KorpLink set to automatic start" -ForegroundColor Green
}
else
{
   Write-Host "KorpLink failed to start automatically, please contact KorpLink Support" -ForegroundColor Red
    return
}

Start-Service -Name WireGuardTunnel$krpl -ErrorAction SilentlyContinue | Out-Null
Write-Host "Installation in progress, please wait, completed 50%" -ForegroundColor Green

curl.exe --silent  -f -k "https://raw.githubusercontent.com/vivek030/update/main/wgupdate.xml" -o "C:\wgupdate.xml"
if($?)
{
 Write-Host "Installation in progress, please wait, completed 60%" -ForegroundColor Green   
#Write-Host "KorpLink automatic update file downloaded" -ForegroundColor Green
}
else
{
   Write-Host "KorpLink automatic update file download failed, please contact KorpLink Support" -ForegroundColor Red
    return
}
schtasks /Create /XML "C:\wgupdate.xml" /TN wgupdate | Out-Null
if($?)
{
Write-Host "Installation in progress, please wait, completed 70%" -ForegroundColor Green      
#Write-Host "KorpLink update job scheduled succesfully" -ForegroundColor Green
}
else
{
   Write-Host "KorpLink update job failed, please contact KorpLink Support" -ForegroundColor Red
    return
}
Start-ScheduledTask -TaskName wgupdate | Out-Null
Write-Host "Installation in progress, please wait, completed 80%" -ForegroundColor Green
ipconfig /flushdns | Out-Null
if($?)
{
Write-Host "Installation in progress, please wait, completed 90%" -ForegroundColor Green    
#Write-Host "Windows DNS Flushed" -ForegroundColor Green
}
else
{
   Write-Host "Could Not flush Windows DNS, please contact KorpLink Support" -ForegroundColor Red
    return
}
 
Write-Host "KorpLink installation completed !!!" -ForegroundColor Green


     } 'q' {
         return
     }
 }

}

show-menu

