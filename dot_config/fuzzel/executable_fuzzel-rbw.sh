#!/bin/bash

# Funktion zum Bereinigen des ausgewählten Textes
clean_text() {
    local text="$1"
    
    # Prüfe, ob der Text einen Doppelpunkt gefolgt von einem Leerzeichen enthält
    if [[ "$text" == *": "* ]]; then
        # Entferne alles bis zum ersten Doppelpunkt und das folgende Leerzeichen
        echo "$text" | sed 's/^[^:]*: //'
    else
        # Wenn kein Doppelpunkt mit folgendem Leerzeichen gefunden wird, gib den Text unverändert zurück
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
pass_name=$(rbw list | fuzzel -d)

# Wenn ein Eintrag ausgewählt wurde
if [[ $pass_name != "" ]]; then
    # Hole alle Details des Eintrags
    details=$(rbw get "$pass_name" --full)
    
    # Zeige Details in einem neuen Fuzzel-Fenster an und lasse den Benutzer eine Zeile auswählen
    selected_detail=$(echo "$details" | fuzzel --dmenu --prompt="Details für $pass_name: ")

    # Wenn eine Zeile ausgewählt wurde
    if [[ $selected_detail != "" ]]; then
        # Bereinige den ausgewählten Text
        cleaned_text=$(clean_text "$selected_detail")
        
        # Kopiere den bereinigten Text in die Zwischenablage
        copy_to_clipboard "$cleaned_text"
        
        echo "Bereinigter Text wurde in die Zwischenablage kopiert."
    fi
fi
