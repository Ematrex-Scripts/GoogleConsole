#!/bin/bash

# Function to clean all files and directories in the current directory
clean_directory() {
    echo "Cleaning all files and directories in the current directory..."
    rm -rf ./*
    echo "Clean completed."
    exit 0
}

# Check if the first argument is "clean"
if [[ "$1" == "clean" ]]; then
    clean_directory
fi

# File to store the domain and email
CONFIG_FILE="config.txt"

# Check if the file already exists
if [[ -f "$CONFIG_FILE" ]]; then
    # Read the domain and email from the file
    DOMAIN=$(grep "DOMAIN=" "$CONFIG_FILE" | cut -d '=' -f2)
    EMAIL=$(grep "EMAIL=" "$CONFIG_FILE" | cut -d '=' -f2)
else
    # Prompt user for input
    read -p "Enter the domain: " DOMAIN
    read -p "Enter the email: " EMAIL
    
    # Save the domain and email to the file
    echo "DOMAIN=$DOMAIN" > "$CONFIG_FILE"
    echo "EMAIL=$EMAIL" >> "$CONFIG_FILE"
fi

# Update system and install necessary packages
sudo apt update
sudo apt install git cron -y

# Ensure the cron service is running
sudo service cron restart
sudo service cron status

# Clone the repository if not already cloned
REPO_DIR="GoogleConsole"
if [[ ! -d "$REPO_DIR" ]]; then
    git clone https://github.com/Ematrex-Scripts/GoogleConsole.git
fi

# Navigate to the directory and set permissions
cd "$REPO_DIR" || exit
chmod 777 *

# Run the Postfix script
bash postfix.sh

# Define paths for the Python script and log file
PYTHON_SCRIPT_PATH="$(pwd)/main.py"  # Adjust if the path differs
OUTPUT_LOG_PATH="$(pwd)/output.log"

# Execute the Python script
python3 "$PYTHON_SCRIPT_PATH" "$DOMAIN" "$EMAIL" 
