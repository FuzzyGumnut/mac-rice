#!/bin/bash

if pgrep -x "X-VPN" >/dev/null; then
  sketchybar --set "$NAME" icon="󰖂" label="ON"
else
  sketchybar --set "$NAME" icon="󰌾" label="OFF"
fi
