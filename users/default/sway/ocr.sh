#!/bin/sh
set -eu # So you don't have to keep using &&
SCREENSHOT_PATH="$(mktemp --suffix .png)"
TEXT_PATH="$(mktemp)"
sleep 3s
grim -t png "${SCREENSHOT_PATH}"
convert "${SCREENSHOT_PATH}" -crop "$(slurp -d -c \#ff0000 -f '%wx%h+%x+%y')" "${SCREENSHOT_PATH}"
tesseract "${SCREENSHOT_PATH}" "${TEXT_PATH}"
TEXT_PATH="${TEXT_PATH}.txt"
wl-copy < "${TEXT_PATH}"
