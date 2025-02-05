#!/bin/bash

# Check for default deny policy (example)
if ! iptables -L -n | grep "Policy: ACCEPT"; then # Adjust based on your policy
   echo "Warning: Firewall policy might not be 'deny' by default."
fi

# Check open ports (customize as needed)
if iptables -L -n | grep ":22"; then # Example: Check if port 22 is open
   echo "Port 22 (SSH) is open."
fi

echo "Firewall check complete."
