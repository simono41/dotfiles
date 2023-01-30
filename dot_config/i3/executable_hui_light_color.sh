#!/bin/bash

set -x
curl --location --request PUT 'http://192.168.1.123/api/EYlLGomum-wwCSoil1oRkIpcmYORn3KR03201tQg/lights/1/state' --header 'Content-Type: text/plain' --data-raw '{"hue":'$1'}'
