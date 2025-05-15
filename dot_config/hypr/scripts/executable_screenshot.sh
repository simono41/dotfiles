#!/usr/bin/env bash

case $1 in
  "area")
    grim -g "$(slurp -d)" - | wl-copy
    ;;
  "edit")
    grim -g "$(slurp -d)" - | satty -f -
    ;;
  "window")
    grim -g "$(slurp -o -r -c '##ff0000ff')" -t ppm - | satty --filename - --fullscreen
    ;;
  *)
    echo "Usage: $0 [area|edit|window]"
    exit 1
    ;;
esac
