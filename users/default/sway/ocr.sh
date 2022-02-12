#!/bin/sh
sleep 2s &&
grim -t png /tmp/screenshot.png &&
convert /tmp/screenshot.png -crop "$(slurp -d -c \#ff0000 -f '%wx%h+%x+%y')" /tmp/screenshot.png &&
tesseract /tmp/screenshot.png /tmp/text &&
wl-copy < /tmp/text.txt
