#!/bin/bash

# Funktion zur Auswahl mit fuzzel oder choose
select_item() {
    local prompt="$1"
    local input="$2"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "$input" | choose -p "$prompt"
    else
        echo "$input" | fuzzel -d -p "$prompt"
    fi
}

# Funktion zum Bereinigen des ausgewählten Textes
clean_text() {
    local text="$1"
    if [[ "$text" == *": "* ]]; then
        echo "$text" | sed 's/^[^:]*: //'
    else
        echo "$text"
    fi
}

# Funktion zum Kopieren in die Zwischenablage
copy_to_clipboard() {
    local text="$1"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo -n "$text" | pbcopy
    else
        echo -n "$text" | wl-copy
    fi
}

# Wähle einen Eintrag aus der Liste
pass_name=$(select_item "Wähle einen Eintrag:" "$(rbw list)")

# Wenn ein Eintrag ausgewählt wurde
if [[ $pass_name != "" ]]; then
    # Hole alle Details des Eintrags
    details=$(rbw get "$pass_name" --full)
    
    # Zeige Details an und lasse den Benutzer eine Zeile auswählen
    selected_detail=$(select_item "Details für $pass_name:" "$details")

    # Wenn eine Zeile ausgewählt wurde
    if [[ $selected_detail != "" ]]; then
        # Bereinige den ausgewählten Text
        cleaned_text=$(clean_text "$selected_detail")
        
        # Kopiere den bereinigten Text in die Zwischenablage
        copy_to_clipboard "$cleaned_text"
        
        echo "Bereinigter Text wurde in die Zwischenablage kopiert."
    fi
fi
