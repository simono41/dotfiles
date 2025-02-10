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

# Liste mit Name+User kombinieren und formatieren
entries=$(rbw list --fields name,user | awk -F'\t' '{print $1 " | " $2}')

# Auswahl des kombinierten Eintrags
selected=$(select_item "Wähle einen Login: " "$entries")

if [[ -n "$selected" ]]; then
    # Extrahiere Name und User aus der Auswahl
    name=$(echo "$selected" | awk -F' \\| ' '{print $1}')
    user=$(echo "$selected" | awk -F' \\| ' '{print $2}')
    
    # Hole Details mit beiden Parametern
    details=$(rbw get "$name" "$user" --full 2>/dev/null)

    if [[ -z "$details" ]]; then
        echo "Fehler beim Abrufen der Details"
        exit 1
    fi

    # Detailauswahl wie bisher
    selected_detail=$(select_item "Details für $name: " "$details")
    
    if [[ -n "$selected_detail" ]]; then
        cleaned_text=$(clean_text "$selected_detail")
        copy_to_clipboard "$cleaned_text"
        echo "In Zwischenablage kopiert: ${cleaned_text:0:20}..."
    fi
fi
