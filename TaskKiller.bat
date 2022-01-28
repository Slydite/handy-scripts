@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:-------------------------------------- 
@echo off
taskkill /im MonectServer.exe /f
taskkill /im MonectServerService.exe /f
taskkill /im mysqld.exe /f
taskkill /im AcrobatNotificationClient.exe /f
taskkill /im acrotray.exe /f
taskkill /im AdobeCollabSync.exe /f
taskkill /im AdobeIPCBroker.exe /f
taskkill /im OfficeClickToRun.exe /f
taskkill /im AdobeIPCBroker.exe /f
taskkill /im AdobeUpdateService.exe /f
taskkill /im CCXProcess.exe /f
taskkill /im AGMService.exe /f
taskkill /im AGSService.exe /f
taskkill /im armsvc.exe /f
taskkill /im WmiPrvSE.exe /f
taskkill /im acrotray.exe /f
taskkill /im fynews.exe /f
taskkill /im fyservice.exe /f
taskkill /im GoogleCrashHandler.exe /f
taskkill /im GoogleCrashHandler64.exe /f
taskkill /im TeamViewerService.exe /f
taskkill /im ctfmon.exe /f
taskkill /im hide.me.exe /f
taskkill /im armsvc.exe /f
taskkill /im everything.exe /f
taskkill /im Plex Update Service.exe /f
taskkill /im YourPhoneServer.exe /f
taskkill /im TeamViewer_Service.exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f

taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f

taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f

taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
taskkill /im .exe /f
