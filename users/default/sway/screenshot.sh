#!/bin/sh
set -eu # So you don't have to keep using &&
FILENAME="$(mktemp --suffix .png)"
sleep 3s
grim -t png "${FILENAME}"
convert "${FILENAME}" -crop "$(slurp -d -c \#ff0000 -f '%wx%h+%x+%y')" "${FILENAME}"
swappy -f "${FILENAME}"
