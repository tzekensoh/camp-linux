#!/bin/bash

# Reference: https://chatgpt.com/share/673d6054-cd20-8001-a377-4050a67f67ea

DATA_DIR="/home/user/datasets"
URL="https://example.com/large_data.csv" #https://www.usaspending.gov/download_center/custom_award_data
FILENAME="data_$(date +%F).csv"

# Download dataset
wget -O "$DATA_DIR/$FILENAME" "$URL"

# Move to HDFS
hdfs dfs -put "$DATA_DIR/$FILENAME" /user/yourname/data/
echo "Data successfully uploaded to HDFS."
