#!/bin/bash
# Fix permissions for headless user on volumes
# Note: Using 1001:0 as per original Dockerfile configuration to match the headless user and root group
sudo chown -R 1001:0 /home/headless /dockerstartup
sudo chmod -R 775 /home/headless /dockerstartup

# Execute the command
exec "$@"
