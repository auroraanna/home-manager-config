#!/bin/sh
DISK="/dev/sde1"
udisksctl unmount -b "$DISK" &&
notify-desktop "Unmount successful" "Unmounted $DISK"