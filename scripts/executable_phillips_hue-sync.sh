#!/bin/bash

#set -ex

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

    # Konvertiere Fließkommazahlen zu Ganzzahlen mit awk
    r=$(echo $r | awk '{printf "%.0f", $1}')
    g=$(echo $g | awk '{printf "%.0f", $1}')
    b=$(echo $b | awk '{printf "%.0f", $1}')

    # Einfache Umrechnung der RGB-Werte für die Hue API (diese Werte sind stark angenähert)
    hue=$((r * 65535 / 255))
    saturation=$((g * 254 / 255))
    brightness=$((b * 254 / 255))

    # 4. Farbe an Philips Hue Lampe senden
    echo "Senden der Farbe Hue: $hue, Saturation: $saturation, Brightness: $brightness an Lampe $light_id"

    # Hier würde der tatsächliche Befehl zum Senden der Farbe stehen.
    url="http://${bridge_ip}/api/${username}/lights/${light_id}/state"
    payload="{\"on\": true, \"sat\": $saturation, \"bri\": $brightness, \"hue\": $hue}"
    response=$(curl --request PUT --data "$payload" $url)
    echo $response

    echo "Farbe erfolgreich gesendet!"

    sleep 1

done
