#!/bin/bash

gpu_temp=$(sensors | awk '/Sensor 2/ {print $3}')
cpu_temp=$(sensors | awk '/Tctl/ {print $2}')
echo "CPU: ${cpu_temp}|GPU ${gpu_temp}"
