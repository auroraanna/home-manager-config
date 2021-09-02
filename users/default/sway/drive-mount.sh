#!/bin/sh
DISK="/dev/sde1"
udisksctl mount -b "$DISK" &&
notify-desktop "Mount successful" "Mounted $DISK"