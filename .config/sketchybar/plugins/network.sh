#!/bin/bash

NET=$(netstat -ib | awk '/en0/ { in += $7; out += $10 } END { print in, out }')
sketchybar --set "$NAME" label="$NET"
