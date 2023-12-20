@echo off

REM Output file
set "outfile=%TEMP%\output_netstat.html"

REM Removing old file
del "%outfile%" 2>nul

REM Set the installation directory
set "INSTALL_DIR=C:\Program Files\netstat-visualizer"

REM Run netstat -talp command and capture the output
set "netstat_output="
for /f "delims=" %%i in ('netstat -talp') do set "netstat_output=!netstat_output!%%i"

REM HTML template
set "html_template=^
<!DOCTYPE html^>
<html lang="en"^>
<head^>
    <meta charset="UTF-8"^>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"^>
    <title>netstat -talp</title^>
    <link rel="stylesheet" href="%INSTALL_DIR%\files\netstat-service.css"^>
    <script src="%INSTALL_DIR%\files\jquery.min.js"></script^>
    <script src="%INSTALL_DIR%\files\d3.v3.min.js"></script^>
    <script src="%INSTALL_DIR%\files\dagre-d3.min.js"></script^>
</head^>
<body^>
    
    <h3>Input Data</h3^>
    <textarea style="width:100%" rows="15" id="source"^>
    %netstat_output%
    </textarea^>
    
    <div id="graph"></div^>

    <script src="%INSTALL_DIR%\files\netstat-service.js"></script^>
</body^>
</html^>
"

REM Save the HTML to a file
echo %html_template% > "%outfile%"

REM Open the HTML file with the default browser
start "" "%outfile%"
