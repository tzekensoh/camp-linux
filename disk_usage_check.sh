#!/bin/bash

# Script to monitor disk space usage and send an alert if it's below a threshold.

# Configuration:
THRESHOLD_PERCENT=80  # Disk usage threshold (80%)
MOUNT_POINT="/"        # Mount point to check (root partition)
RECIPIENT="admin@example.com" # Email address for alerts

# Function to get disk usage percentage
get_disk_usage() {
  df -h | grep "$MOUNT_POINT" | awk '{print $5}' | sed 's/%//'
}

# Main loop
while true; do
  DISK_USAGE=$(get_disk_usage)

  # Check if disk usage is below the threshold
  if (( $(echo "$DISK_USAGE $THRESHOLD_PERCENT" | awk '{print $1 < $2}') )); then # Corrected comparison
      SUBJECT="Low Disk Space Alert"
      BODY="Disk space on $MOUNT_POINT is below $THRESHOLD_PERCENT%: $DISK_USAGE%"
      echo "$BODY" | mail -s "$SUBJECT" "$RECIPIENT"  # Send email alert.  Adjust mail command as needed
      echo "$(date): Alert sent." # Log the alert.
  fi

  # Log disk usage (optional)
  echo "$(date): Disk usage on $MOUNT_POINT: $DISK_USAGE%" >> /var/log/disk_monitor.log

  sleep 300 # Check every 5 minutes (adjust as needed)
done
