#!/usr/bin/env bash

text=$(qdbus org.kde.klipper /klipper getClipboardHistoryMenu | fuzzel -d)

[[ $text != "" ]] && wl-copy $text
