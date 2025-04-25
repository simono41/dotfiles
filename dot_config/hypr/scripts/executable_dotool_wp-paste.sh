#!/bin/bash

sleep 1

{
  echo "typedelay 100"
  echo "type $(wl-paste)"
} | DOTOOL_XKB_LAYOUT=de dotool && \
notify-send -t 5000 -u low "Eingabe abgeschlossen" "Inhalt wurde getippt"
