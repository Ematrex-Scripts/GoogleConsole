#!/bin/bash

# Install Postfix and automatically provide answers to prompts
echo "postfix postfix/main_mailer_type select Internet Site" | sudo debconf-set-selections
echo "postfix postfix/mailname string localhost" | sudo debconf-set-selections

# Install Postfix
sudo apt-get update
sudo apt-get install -y postfix

# Remove the default Postfix configuration file
sudo rm /etc/postfix/main.cf

# Create a new Postfix configuration file and add the required configuration
sudo tee /etc/postfix/main.cf > /dev/null <<EOL
# Postfix main configuration file

# Define the local machine as the only place to accept mail from
inet_interfaces = loopback-only

# Set your hostname
myhostname = localhost

# Disable relay host, so no external SMTP server is used
relayhost = 

# Ensure local mail delivery is enabled
mydestination = localhost

# Disable SMTP authentication (since we're not relaying)
smtp_sasl_auth_enable = no
smtpd_sasl_auth_enable = no
smtp_sasl_security_options = noanonymous

# Disable TLS for outgoing mail (since no external server is used)
smtp_tls_security_level = none

# Set the Postfix queue settings for basic use
queue_directory = /var/spool/postfix
command_directory = /usr/sbin
daemon_directory = /usr/lib/postfix/sbin

# Mailbox settings (optional)
mailbox_size_limit = 0
recipient_delimiter = +
EOL

# Restart Postfix to apply the new configuration
sudo service postfix restart

# Install mailutils to enable sending mails
sudo apt-get install -y mailutils

echo "Postfix installation and configuration completed successfully!"
