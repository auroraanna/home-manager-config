#!/bin/sh
BARCODE_IMAGE="/tmp/barcode.png"

grim -g "$(slurp)" /tmp/barcode.png

SCANRESULT=$(zbarimg --quiet --raw "$BARCODE_IMAGE" | tr -d '\n')

if [ -z "$SCANRESULT" ]; then
    notify-desktop "zbar" "No scan data found"
else
    echo "$SCANRESULT" | wl-copy
    convert $BARCODE_IMAGE -resize 75x75 "$BARCODE_IMAGE"
    notify-desktop -i "$BARCODE_IMAGE" "zbar" "$SCANRESULT\n(copied to clipboard)"
    xdg-open "$SCANRESULT"
fi