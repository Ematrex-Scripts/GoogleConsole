#!/bin/bash

# Validate required arguments
if [ $# -ne 5 ]; then
  echo "Usage: $0 <subject> <from_name> <body_content> <header> <datalists>"
  exit 1
fi

# Assign arguments to variables

BODY_CONTENT=$1
HEADER=$2
DATALISTS=$3

# Split the delimited email list into an array
IFS=',' read -r -a EMAIL_ARRAY <<< "$DATALISTS"

# Loop through each email and send the email
for email in "${EMAIL_ARRAY[@]}"
do
  echo "Sending email to: $email"

  # Send the email using Postfix with HTML content
  cat <<EOF | /usr/sbin/sendmail -t &
To: $email

$HEADER
MIME-Version: 1.0
Content-Type: text/html

$BODY_CONTENT
EOF

done

echo "All emails sent."
