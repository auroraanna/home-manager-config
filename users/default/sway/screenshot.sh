#!/bin/sh
sleep 3s &&
grim -t png /tmp/screenshot.png &&
convert /tmp/screenshot.png -crop "$(slurp -d -c \#ff0000 -f '%wx%h+%x+%y')" /tmp/screenshot.png &&
swappy -f /tmp/screenshot.png