brightnessctl set +5% | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > /tmp/wob
