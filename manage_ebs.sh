#!/bin/bash
set -e

DEVICE="/dev/xvdg"
MountPoint="/data"
FileSystemType="ext4"
OWNER="ubuntu:ubuntu"
MODE="755

echo "Disk MAnagement Script initalized successfully"

# Check if the device exists
if [ ! -b "$DEVICE" ]; then
    echo "Device $DEVICE does not exist. Exiting Back."
    exit 1
fi

# 2. Check if already mounted
if mount | grep -q "$DEVICE"; then
    echo "DEVICE $DEVICE is already mounted. Exiting Back."
    exit 1
fi

# 3. Check if the device has a filesystem
FS_EXIST=$(blkid -o value -s TYPE $DEVICE || true)

if [ -z "$FS_EXIST" ]; then
  echo "No filesystem found. Formatting $DEVICE as $FileSystemType"
  mkfs.$FileSystemType $DEVICE
else
  echo "Filesystem $FS_EXIST already exists"
fi

# 4. creating  Directory
if [ ! -d "$MountPoint" ]; then
    echo "Creating mount point $MountPoint"
    mkdir -p $MountPoint
fi

# 5. Mounting the disk
echo "Mounting $DEVICE to $MountPoint"
mount $DEVICE $MountPoint

# 6. Update /etc/fstab for persistence

UUID=$(blkid -s UUID -o value $DEVICE)
if ! grep -q "$UUID" /etc/fstab; then
  echo " Persisting mount in /etc/fstab"
  echo "UUID=$UUID  $MountPoint  $FileSystemType  defaults,nofail  0  2" >> /etc/fstab
fi

echo "Disk management completed successfully"

# ownership and permissions
chown -R "$OWNER" "$MountPoint"
chmod -R "$MODE" "$MountPoint"