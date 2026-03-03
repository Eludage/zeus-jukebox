@echo off
setlocal

:: Load variables from .env file
set ENVFILE=%~dp0.env
if not exist "%ENVFILE%" (
    echo ERROR: .env file not found at %ENVFILE%
    echo Copy .env.example to .env and fill in your paths.
    pause
    exit /b 1
)
for /f "usebackq tokens=1,* delims==" %%A in ("%ENVFILE%") do (
    set "%%A=%%B"
)

if not exist "%~dp0$PBOPREFIX$" (
    echo ERROR: PBO prefix file not found at "%~dp0$PBOPREFIX$"
    exit /b 1
)

set /p PREFIX=<"%~dp0$PBOPREFIX$"

if "%PREFIX%"=="" (
    echo ERROR: PBO prefix value is empty. Please ensure "%~dp0$PBOPREFIX$" contains a valid prefix.
    exit /b 1
)
echo Building ZeusJukebox PBO...

if exist "%PRIVATEKEY%" (
    "%ADDONBUILDER%" "%SOURCE%" "%DEST%" -clear -prefix=%PREFIX% -sign="%PRIVATEKEY%" -temp="%TEMPDIR%" -project="%PROJECTDIR%" -exclude="%EXCLUDELIST%"
) else (
    echo WARNING: Private key not found, PBO will not be signed.
    "%ADDONBUILDER%" "%SOURCE%" "%DEST%" -clear -prefix=%PREFIX% -temp="%TEMPDIR%" -project="%PROJECTDIR%" -exclude="%EXCLUDELIST%"
)

if %ERRORLEVEL% == 0 (
    echo.
    echo Build succeeded: %DEST%
    echo.
    echo Deploying to local mods...
    del /Q "%DEPLOYDIR%\*.*"
    move /Y "%EXPORTDIR%\ZeusJukebox.pbo\*.*" "%DEPLOYDIR%\"
    echo Deploy complete: %DEPLOYDIR%
) else (
    echo.
    echo Build FAILED with error code %ERRORLEVEL%.
)
