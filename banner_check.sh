#!/bin/bash

# Check if the banner file exists
if [ ! -f /etc/issue ]; then
  echo "Warning: /etc/issue file not found!"
  exit 1
fi

# Check for specific content (example)
if ! grep -q "Unauthorized access is prohibited" /etc/issue; then
  echo "Warning: Banner does not contain required legal notice!"
  exit 1
fi

echo "Banner check passed."
