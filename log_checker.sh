#!/bin/bash

# Configuration Variables
LOG_DIR="/var/log"        # Directory containing logs
DAYS_OLD=7                # Number of days before logs are archived/deleted
ERROR_KEYWORD="ERROR"     # Keyword to monitor in logs
ALERT_EMAIL="admin@example.com" # Optional email for alerts
SLEEP_INTERVAL=300        # Check interval in seconds (default: 5 minutes)

echo "Starting log maintenance script..."

while true; do
    echo "Checking log files..."

    # Step 1: Find and archive/delete old logs
    OLD_LOGS=$(find "$LOG_DIR" -type f -name "*.log" -mtime +$DAYS_OLD)
    
    if [[ -n "$OLD_LOGS" ]]; then
        echo "Archiving old logs..."
        for log in $OLD_LOGS; do
            tar -czf "${log}.tar.gz" "$log" && rm "$log"
            echo "Archived and removed: $log"
        done
    else
        echo "No old logs found."
    fi

    # Step 2: Scan logs for critical errors
    ERROR_FOUND=$(grep -i "$ERROR_KEYWORD" $LOG_DIR/*.log)

    if [[ -n "$ERROR_FOUND" ]]; then
        echo "Critical errors found in logs!"
        echo "Errors detected: $ERROR_FOUND"
        
        # Send alert email (optional, requires mailutils installed)
        if [[ -n "$ALERT_EMAIL" ]]; then
            echo -e "Subject: Log Alert!\n\n$ERROR_FOUND" | sendmail "$ALERT_EMAIL"
            echo "Alert email sent to $ALERT_EMAIL."
        fi
    else
        echo "No critical errors found."
    fi

    echo "Sleeping for $SLEEP_INTERVAL seconds..."
    sleep $SLEEP_INTERVAL
done
