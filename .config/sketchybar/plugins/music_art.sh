#!/bin/bash

ART=$(osascript -e 'tell application "Spotify" to artwork url of current track' 2>/dev/null)

if [ -n "$ART" ]; then
  curl -s "$ART" -o /tmp/spotify_art.jpg
  sketchybar --set music image=/tmp/spotify_art.jpg image.drawing=on
fi
