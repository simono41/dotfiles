#!/bin/bash

gpu_temp=$(sensors | awk '/temp1/ {print $2}')
cpu_temp=$(sensors | awk '/Tctl/ {print $2}')
echo "CPU: ${cpu_temp} | GPU ${gpu_temp}"
