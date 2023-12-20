#!/bin/bash

# Output file
outfile="/tmp/output_netstat.html"

# Removing old file
rm "$outfile" 2>/dev/null

# Set the installation directory
INSTALL_DIR="/usr/local/bin/netstat-visualizer"

# Run netstat -ta command and capture the output
netstat_output=$(netstat -ta)

# HTML template
html_template="<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>netstat -ta</title>
    <link rel=\"stylesheet\" href=\"$INSTALL_DIR/files/force-graph.css\">
    <script src=\"$INSTALL_DIR/files/jquery.min.js\"></script>
    <script src=\"$INSTALL_DIR/files/d3.v3.min.js\"></script>
</head>
<body>
    
    <h3>Input Data</h3>
    <textarea style=\"width:100%\" rows=\"5\" id=\"source\">
    $netstat_output
    </textarea>
    <br/><br/>
    <div id=\"graph\"></div>

    <script src=\"$INSTALL_DIR/files/force-graph.js\"></script>
</body>
</html>"

# Save the HTML to a file
echo "$html_template" > "$outfile"

# Open the HTML file
xdg-open "$outfile"

