#!/bin/bash

FILE="/var/log/custom/access.log"
MAX_SIZE=$((1024 * 1024 * 1024))  # 1 GB

# Jenkins details
JENKINS_URL="http://localhost:8080"
JENKINS_USER="Atharva"
JENKINS_API_TOKEN="117eb7d1b1da6c09715e6c1418b320938f"
JOB_NAME="UploadLogToS3"

if [ -f "$FILE" ]; then
  FILE_SIZE=$(stat -c%s "$FILE")

  if [ "$FILE_SIZE" -ge "$MAX_SIZE" ]; then
    echo " File exceeded 1GB. Triggering Jenkins job..."

    # Get Jenkins crumb for CSRF protection
    CRUMB=$(curl -s -u "$JENKINS_USER:$JENKINS_API_TOKEN" \
      "$JENKINS_URL/crumbIssuer/api/json" | jq -r '.crumbRequestField + ":" + .crumb')

    # Trigger Jenkins job with file path as parameter
    curl -X POST "$JENKINS_URL/job/$JOB_NAME/buildWithParameters" \
      --user "$JENKINS_USER:$JENKINS_API_TOKEN" \
      -H "$CRUMB" \
      --data-urlencode "LOG_PATH=$FILE"
  else
    echo " File size is below 1GB. No action taken."
  fi
else
  echo " File not found: $FILE"
fi
