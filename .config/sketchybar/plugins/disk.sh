#!/bin/bash

FREE=$(df -h / | awk 'NR==2 {print $4}')

sketchybar --set "$NAME" label="$FREE Free"
