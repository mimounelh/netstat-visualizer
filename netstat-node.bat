@echo off

REM Output file
set "outfile=%TEMP%\output_netstat.html"

REM Removing old file
del "%outfile%" 2>nul

REM Set the installation directory
set "INSTALL_DIR=C:\Program Files\netstat-visualizer"

REM Run netstat -ta command and capture the output
set "netstat_output="
for /f "delims=" %%i in ('netstat -ta') do set "netstat_output=!netstat_output!%%i"

REM HTML template
set "html_template=^
<!DOCTYPE html^>
<html lang="en"^>
<head^>
    <meta charset="UTF-8"^>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"^>
    <title>netstat -ta</title^>
    <link rel="stylesheet" href="%INSTALL_DIR%\files\force-graph.css"^>
    <script src="%INSTALL_DIR%\files\jquery.min.js"></script^>
    <script src="%INSTALL_DIR%\files\d3.v3.min.js"></script^>
</head^>
<body^>
    
    <h3>Input Data</h3^>
    <textarea style="width:100%" rows="5" id="source"^>
    %netstat_output%
    </textarea^>
    <br/><br/>
    <div id="graph"></div^>

    <script src="%INSTALL_DIR%\files\force-graph.js"></script^>
</body^>
</html^>
"

REM Save the HTML to a file
echo %html_template% > "%outfile%"

REM Open the HTML file with the default browser
start "" "%outfile%"
