#!/bin/bash

# Check for PermitRootLogin no
if ! grep -q "PermitRootLogin no" /etc/ssh/sshd_config; then
  echo "Warning: PermitRootLogin is not set to no!"
fi

# Check for PasswordAuthentication no
if ! grep -q "PasswordAuthentication no" /etc/ssh/sshd_config; then
  echo "Warning: PasswordAuthentication is not set to no!"
fi

# ... other SSH checks ...

echo "SSH configuration check complete."
