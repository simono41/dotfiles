#!/bin/bash

# Führe das install.sh Skript aus dem geklonten Repository aus
if [ -d "$HOME/.powerline-fonts" ]; then
    cd "$HOME/.powerline-fonts"
    ./install.sh
else
    echo "Powerline Fonts Repository wurde nicht gefunden."
fi
