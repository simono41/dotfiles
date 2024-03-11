#!/bin/bash

set -ex

while true; do

    # Konfiguration
    screenshot_path="$HOME/Desktop/screenshot.png"
    bridge_ip='192.168.1.115'
    username='Jhw0h63UZOXZCkGsRUvMtAH7kbjWEe1YS1xh0yrl'
    light_id='7'

    # Test, ob die Bridge erreichbar ist
    max_attempts=10
    attempt=0
    while ! ping -c 1 $bridge_ip &>/dev/null; do
        attempt=$((attempt+1))
        echo "Versuch $attempt von $max_attempts: Bridge nicht erreichbar, warte 10 Sekunden..."
        if [ $attempt -ge $max_attempts ]; then
            echo "Bridge nach $max_attempts Versuchen nicht erreichbar, breche Skript ab."
            exit 1
        fi
        sleep 10
    done

    # 1. Screenshot erstellen
    spectacle -b -f -n -o $screenshot_path

    # 2. Durchschnittliche Farbe des Screenshots berechnen und in Ganzzahlen konvertieren
    average_color=$(convert $screenshot_path -resize 1x1\! -format "%[pixel:u]" info:- | tr -d ' ' | sed 's/.*[(]\(.*\)[)].*/\1/' | tr -d '%')
    IFS=',' read r g b _ <<< "$average_color"

    # Konvertiere RGB in xy-Werte
    convertRGBtoXY() {
        # Konvertiere die Eingabewerte von 0-255 zu 0-1
        local r=$(echo "$1 / 255" | bc -l)
        local g=$(echo "$2 / 255" | bc -l)
        local b=$(echo "$3 / 255" | bc -l)

        # Anpassen der Helligkeit der Farben gemäß der Formel
        adjustColor() {
            local color=$1
            if (( $(echo "$color <= 0.04045" | bc -l) )); then
                echo $(echo "$color / 12.92" | bc -l)
            else
                echo $(echo "e(l(($color + 0.055) / 1.055) * 2.4)" | bc -l)
            fi
        }

        r=$(adjustColor $r)
        g=$(adjustColor $g)
        b=$(adjustColor $b)

        # Konvertierung zu XYZ
        local X=$(echo "scale=5; (0.4124 * $r) + (0.3576 * $g) + (0.1805 * $b)" | bc -l)
        local Y=$(echo "scale=5; (0.2126 * $r) + (0.7152 * $g) + (0.0722 * $b)" | bc -l)
        local Z=$(echo "scale=5; (0.0193 * $r) + (0.1192 * $g) + (0.9505 * $b)" | bc -l)

        # Konvertierung zu xy
        local x=$(echo "scale=5; $X / ($X + $Y + $Z)" | bc -l)
        local y=$(echo "scale=5; $Y / ($X + $Y + $Z)" | bc -l)

        # Ausgabe der xy-Werte
        echo "0$x 0$y"
    }

    # Ausführen der Konvertierung
    read x y <<< $(convertRGBtoXY $r $g $b)

    # Setze Helligkeit und Sättigung (Beispielwerte, anpassen nach Bedarf)
    bri=254 # Maximalwert für die Helligkeit
    sat=254 # Maximalwert für die Sättigung

    # 4. Farbe an Philips Hue Lampe senden
    echo "Senden der Farbe an Lampe $light_id: xy-Werte: $x,$y, Helligkeit: $bri, Sättigung: $sat"

    url="http://${bridge_ip}/api/${username}/lights/${light_id}/state"
    #payload="{\"on\": true, \"xy\": [$x, $y], \"bri\": $bri, \"sat\": $sat}"
    payload="{\"on\": true, \"xy\": [$x, $y]}"
    response=$(curl --request PUT --header "Content-Type: application/json" --data "$payload" $url)
    echo $response

    echo "Farbe erfolgreich gesendet!"

    sleep 1

done
