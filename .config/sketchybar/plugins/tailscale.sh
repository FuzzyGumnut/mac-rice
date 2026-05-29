#!/bin/bash

if tailscale status >/dev/null 2>&1; then
  sketchybar --set "$NAME" label="Connected"
else
  sketchybar --set "$NAME" label="Offline"
fi
