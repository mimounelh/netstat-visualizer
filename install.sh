#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root."
    exit 1
fi

# Set the installation directory
INSTALL_DIR="/usr/local/bin/netstat-visualizer"

# Ensure directories exist
mkdir -p "$INSTALL_DIR/files" || { echo "Error creating directories."; exit 1; }

# Copy files to the installation directory
cp -r files/* "$INSTALL_DIR/files" || { echo "Error copying files."; exit 1; }
cp netstat-node.sh netstat-service.sh "$INSTALL_DIR" || { echo "Error copying scripts."; exit 1; }

# Create symlinks
ln -s "$INSTALL_DIR/netstat-node.sh" /usr/local/bin/netstat-node 2>/dev/null || true
ln -s "$INSTALL_DIR/netstat-service.sh" /usr/local/bin/netstat-service 2>/dev/null || true

# Make the scripts executable
chmod +x "$INSTALL_DIR/netstat-node.sh" "$INSTALL_DIR/netstat-service.sh" || { echo "Error setting permissions."; exit 1; }

echo "Installation completed."

