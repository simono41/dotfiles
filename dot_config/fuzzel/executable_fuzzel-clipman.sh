#!/usr/bin/env bash

text=$(clipman pick --tool=STDOUT | fuzzel -d)

[[ $text != "" ]] && echo $text | wl-copy
