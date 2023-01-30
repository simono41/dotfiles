#!/bin/bash
#
# Use nmcli to display the VPN status
#
if ip link | grep -q tun; then
  echo ""
else
  echo ""
fi
