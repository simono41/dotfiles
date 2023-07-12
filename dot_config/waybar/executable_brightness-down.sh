WERT=$1
brightnessctl set ${WERT}%- | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > /tmp/wob
