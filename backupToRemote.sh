#!/bin/bash

# List of subdirectory names
subdirs=("images" "video" "audio" "bin" "text" "test" "edubiz")

# Local main directory name
local_main_dir="/Volumes/Extreme SSD/mir"

# Remote host user name
remote_user="ksoh"

# Remote host IP address
remote_ip="192.168.68.57"

# Remote main directory name
remote_main_dir="/Volumes/Crucial\ X6/mir"

# Log file name
log_file="/Volumes/Extreme SSD/mir/backupToRemote.log"

# Loop through each subdirectory and sync using rsync, logging output
for subdir in "${subdirs[@]}"; do
  echo "===== $(date '+%Y-%m-%d %H:%M:%S') Starting sync for ${subdir} =====" >> "$log_file"
  
  stdbuf -oL -eL rsync -avz "${local_main_dir}/${subdir}/" "${remote_user}@${remote_ip}:${remote_main_dir}/${subdir}/" >> "$log_file" 2>&1
  
  echo "===== $(date '+%Y-%m-%d %H:%M:%S') Finished sync for ${subdir} =====" >> "$log_file"
  echo >> "$log_file"
done  
