#!/bin/bash
#
# prune_backups.sh
#
# This script manages backup retention by deleting old backups.
#
# Cron Job:
# 5 4 * * * /home/container/custom/scripts/prune_backups.sh >> /dev/null 2>&1
#

# CONFIGURATION
BASE_DIR="/home/container/custom"
BACKUP_DIR="$BASE_DIR/backups"
RETENTION_DAYS=5
LOG_DIR="$BASE_DIR/logs/$(date +"%Y%m%d")"
LOG_FILE="$LOG_DIR/backup.log"

# CREATE LOG DIR
mkdir -p "$LOG_DIR"

# LOG FUNCTION
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> "$LOG_FILE"
}

log "Starting backup pruning..."

find "$BACKUP_DIR" -mindepth 1 -maxdepth 1 -type d -mtime +$RETENTION_DAYS -exec rm -rf {} \;

log "Backup pruning finished."
