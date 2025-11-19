#!/bin/bash

# Define backup directory
BACKUP_DIR="/mnt/usb_backup/pi_backup"

# Create directory if it doesn't exist
sudo mkdir -p "$BACKUP_DIR"

# Run rsync
# -a: Archive mode (keeps permissions, owners, dates)
# -A: Preserve ACLs
# -X: Preserve extended attributes
# -v: Verbose
# --delete: Delete files in backup that were deleted on source (keeps it an exact mirror)

echo "Starting backup..."

sudo rsync -aAXv --delete \
  --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} \
  / "$BACKUP_DIR"

echo "Backup complete: $(date)" >> /mnt/usb_backup/backup_log.txt
