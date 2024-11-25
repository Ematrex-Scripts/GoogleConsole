#!/bin/bash
# Prompt user for input
read -p "Enter the domain: " DOMAIN
read -p "Enter the email: " EMAIL

# Update system and install git
sudo apt update
sudo apt install git -y

# Clone the repository
git clone https://github.com/Ematrex-Scripts/GoogleConsole.git

# Navigate to the directory and set permissions
cd GoogleConsole || exit
chmod 777 *

# Run the Postfix script
bash postfix.sh

# Run the Python script in the background with the provided arguments
nohup python3 main.py "$DOMAIN" "$EMAIL" > output.log 2>&1 &
echo "Script executed successfully. Check 'output.log' for details."
