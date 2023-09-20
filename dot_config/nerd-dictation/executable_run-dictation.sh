#!/bin/bash

set -e

if ! pgrep -f /usr/bin/nerd-dictation >/dev/null; then
  notify-send "Hinweis" "Speech to Text wurde gestartet" -t 3000 -i /usr/share/icons/Arc/actions/symbolic/call-start-symbolic.svg
  nerd-dictation begin --simulate-input-tool=YDOTOOL
else
  nerd-dictation end
  notify-send "Hinweis" "Speech to Text wurde beendet" -t 3000 -i /usr/share/icons/Arc/actions/symbolic/call-stop-symbolic.svg
fi
