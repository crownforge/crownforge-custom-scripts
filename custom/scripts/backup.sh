#!/bin/bash
#
# backup.sh
#
# This script creates a daily backup of the specified Minecraft world dimensions.
#
# Cron Job:
# 0 3 * * * /home/container/custom/scripts/backup.sh >> /dev/null 2>&1
#

# CONFIGURATION
BASE_DIR="/home/container/custom"
SERVER_DIR="/home/container"
WORLDS=("world" "world_nether" "world_the_end")
TIMESTAMP=$(date +"%Y%m%d")
BACKUP_DIR="$BASE_DIR/backups/$TIMESTAMP"
LOG_DIR="$BASE_DIR/logs/$TIMESTAMP"
LOG_FILE="$LOG_DIR/backup.log"

# CREATE DIRS
mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"

# LOG FUNCTION
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> "$LOG_FILE"
}

log "Starting backup..."

# STOPPING SERVER SAVES
screen -S minecraft -X stuff "say [Backup] Starting backup...\n"
screen -S minecraft -X stuff "save-off\n"
screen -S minecraft -X stuff "save-all\n"
sleep 5
log "Server saves disabled."

# BACKUP WORLDS
for world in "${WORLDS[@]}"; do
    if [ -d "$SERVER_DIR/$world" ]; then
        log "Backing up $world..."
        tar -czf "$BACKUP_DIR/$world.tar.gz" -C "$SERVER_DIR" "$world"
        log "$world backup complete."
    else
        log "World directory $SERVER_DIR/$world not found. Skipping."
    fi
done

# RESUME SERVER SAVES
screen -S minecraft -X stuff "save-on\n"
screen -S minecraft -X stuff "say [Backup] Backup complete!\n"
log "Server saves enabled."

log "Backup process finished."
