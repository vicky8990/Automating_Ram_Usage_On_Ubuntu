!/bin/bash

# Log file in your home directory
LOGFILE="/root/ram_usage.log"

# Timestamp
echo "RAM usage at $(date):" >> "$LOGFILE"

# Memory usage
free -h | grep Mem >> "$LOGFILE"

# Add separator
echo "-------------------------------" >> "$LOGFILE"
