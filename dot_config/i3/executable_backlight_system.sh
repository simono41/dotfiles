#!/bin/bash

set -x
if lspci | grep -e VGA -e 3D -m 1 | grep AMD; then echo $1 | sudo tee --append /sys/class/backlight/amdgpu_bl*/brightness; else echo $2 | sudo tee --append /sys/class/backlight/intel_backlight/brightness; fi
