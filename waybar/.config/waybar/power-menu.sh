#!/bin/sh

LOCK=" Lock"
LOGOUT=" Logout"
SUSPEND=" Suspend"
HIBERNATE="  Hibernate"
HYBRID_SLEEP=" Hybrid sleep"
RESTART=" Restart"
SHUTDOWN=" Shutdown"

list_icons() {
    echo $LOCK
	echo $LOGOUT
    echo $SUSPEND
	echo $HIBERNATE
	echo $HYBRID_SLEEP
    echo $RESTART
    echo $SHUTDOWN
}

handle_option() {
    case "$1" in
        "$LOCK")
          swaylock -f -c 000000
            ;;
        "$LOGOUT")
          swaymsg exit
            ;;
        "$SUSPEND")
          systemctl suspend
            ;;
		"$HIBERNATE")
          systemctl hibernate
            ;;
		"$HYBRID_SLEEP")
          systemctl hybrid-sleep
            ;;
        "$RESTART")
          reboot
            ;;
        "$SHUTDOWN")
          shutdown now
            ;;
    esac
}

SELECTION="$(list_icons | rofi -dmenu -theme options_menu)"
handle_option $SELECTION &
