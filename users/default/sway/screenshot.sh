#!/bin/sh
grim -t png /tmp/screenshot.png &&
convert /tmp/screenshot.png -crop "$(slurp -f '%wx%h+%x+%y')" /tmp/screenshot.png &&
swappy -f /tmp/screenshot.png