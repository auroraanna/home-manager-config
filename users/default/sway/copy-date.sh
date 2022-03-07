#!/bin/sh
input=$(date --rfc-3339=s)
date=${input%}
wl-copy $date
notify-desktop "Copy current date" "$date"