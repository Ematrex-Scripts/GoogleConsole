#!/bin/bash

# Validate required arguments


# Assign arguments to variables

BODY_CONTENT=$1
HEADER=$2
DATALISTS=$3

# Split the delimited email list into an array
IFS=',' read -r -a EMAIL_ARRAY <<< "$DATALISTS"

# Loop through each email and send the email
for email in "${EMAIL_ARRAY[@]}"
do
  echo "Sending email  "

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
