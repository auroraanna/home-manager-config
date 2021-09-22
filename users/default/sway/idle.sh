#!/bin/sh
exec swayidle -w \
	timeout 240 'swaylock-fancy' \
	timeout 480 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
	#timeout 600 'systemctl suspend"' \
	before-sleep 'swaylock-fancy'