#!/bin/bash

sleep 1

content=$(wl-paste)
{
  echo "typedelay 100"
  echo "type $content"
} | DOTOOL_XKB_LAYOUT=de dotool && \
notify-send -t 5000 "Eingabe abgeschlossen" "Inhalt wurde getippt"
