#!/bin/bash

set -x

wl-paste -t text --watch clipman store &

~/scripts/phillips_hue-sync.sh &
