#!/bin/bash
set -e

DEVICE="/dev/xvdg"
MOUNT_POINT="/data"

echo "=== Disk Cleanup Script ==="

# 1. Unmount
if mount | grep -q "$MOUNT_POINT"; then
  echo " Unmounting $MOUNT_POINT"
  umount $MOUNT_POINT
fi

# 2. Remove fstab entry
UUID=$(blkid -s UUID -o value $DEVICE || true)

if [ -n "$UUID" ]; then
  echo " Removing fstab entry"
  sed -i "\|UUID=$UUID|d" /etc/fstab
fi

# 3. Remove mount directory (if empty)
if [ -d "$MOUNT_POINT" ] && [ -z "$(ls -A $MOUNT_POINT)" ]; then
  echo " Removing empty directory $MOUNT_POINT"
  rmdir $MOUNT_POINT
fi

echo "✅ Disk unmounted and cleaned up"

