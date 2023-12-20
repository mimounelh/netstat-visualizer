@echo off

REM Check for administrative privileges
net session >nul 2>&1
if not %errorlevel% == 0 (
    echo Error: This script must be run as administrator.
    exit /b 1
)

REM Set the installation directory
set "INSTALL_DIR=C:\Program Files\netstat-visualizer"

REM Ensure directories exist
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
if not exist "%INSTALL_DIR%\files" mkdir "%INSTALL_DIR%\files"

REM Copy files to the installation directory
xcopy /Y /I files\* "%INSTALL_DIR%\files\"

REM Copy scripts to the installation directory
copy netstat-node.bat "%INSTALL_DIR%"
copy netstat-service.bat "%INSTALL_DIR%"

REM Add the installation directory to the system PATH
setx PATH "%PATH%;%INSTALL_DIR%" /M

echo Installation completed. You can now run 'netstat-node' and 'netstat-service' from the console.
