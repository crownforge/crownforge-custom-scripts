#!/bin/bash
#
# prune_logs.sh
#
# This script manages log retention by deleting old log files.
#
# Cron Job:
# 10 4 * * 0 /home/container/custom/scripts/prune_logs.sh >> /dev/null 2>&1
#

# CONFIGURATION
BASE_DIR="/home/container/custom"
LOG_DIR="$BASE_DIR/logs"
RETENTION_DAYS=30

# LOG FUNCTION
log() {
    # No logging here to prevent log file from logging its own pruning
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1"
}

log "Starting log pruning..."

find "$LOG_DIR" -mindepth 1 -maxdepth 1 -type d -mtime +$RETENTION_DAYS -exec rm -rf {} \;

log "Log pruning finished."
