#!/bin/bash

# Prompt user for input
read -p "Enter the domain: " DOMAIN
read -p "Enter the email: " EMAIL

# Update system and install necessary packages
sudo apt update
sudo apt install git cron -y

# Ensure the cron service is running
sudo systemctl enable cron
sudo systemctl start cron

# Clone the repository
git clone https://github.com/Ematrex-Scripts/GoogleConsole.git

# Navigate to the directory and set permissions
cd GoogleConsole 
chmod 777 *

# Run the Postfix script
bash postfix.sh

# Define paths for the Python script and log file
PYTHON_SCRIPT_PATH="$(pwd)/main.py"  # Adjust if the path differs
OUTPUT_LOG_PATH="$(pwd)/output.log"

# Create the cron job content
CRON_JOB="* * * * * for i in {1..20}; do python3 $PYTHON_SCRIPT_PATH \"$DOMAIN\" \"$EMAIL\" >> $OUTPUT_LOG_PATH 2>&1; sleep 3; done"

# Add the cron job to the crontab
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

# Confirm the cron job was added
echo "Cron job added successfully. Here's the current crontab:"
crontab -l
