k#!/bin/bash

if ! pgrep -x "Spotify" >/dev/null; then
    sketchybar --set "$NAME" label="No Music"
    exit 0
fi

SONG=$(osascript <<EOF
tell application "Spotify"
    if player state is playing then
        return name of current track
    end if
end tell
EOF
)

ART=$(osascript -e 'tell application "Spotify" to artwork url of current track' 2>/dev/null)

if [ -n "$ART" ]; then
    curl -sL "$ART" -o /tmp/spotify_art.jpg
    sketchybar --set "$NAME" image="/tmp/spotify_art.jpg"
fi

[ -z "$SONG" ] && SONG="Paused"

if [ ${#SONG} -gt 25 ]; then
    SONG="${SONG:0:22}..."
fi

sketchybar --set "$NAME" label="$SONG"
