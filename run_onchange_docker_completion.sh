#!/bin/sh

FILE="/usr/share/zsh/vendor-completions/_docker"

if [ -f "$FILE" ]; then
    echo "Removing $FILE"
    sudo rm "$FILE"
else
    echo "$FILE does not exist"
fi
