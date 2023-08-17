#!/bin/bash

# Records one hour of the byte.fm radio stream.
# Supposed to be started at the full hour through a cron job

# Wait 5 seconds to make sure the title is updated for the new hour
sleep 5 

# Fetch title
info=$(curl -q -s https://www.byte.fm/api/v1/player/live/)
echo Fetched info: $info
echo " "
title=$(echo $info | jq .broadcast_title | tr -d '"')
subtitle=$(echo $info | jq .show_subtitle | tr -d '"')
timestamp=$(date +%Y%m%d_%H%M)
filename="bytefm $timestamp $title - $subtitle.mp3"
echo filename: $filename
echo " "
duration=00:59:55


# Record stream with ffmpeg
echo Starting: ffmpeg -i https://bytefm.cast.addradio.de/bytefm/main/mid/stream.mp3?ar-distributor=ffa0 -nostats -t $duration -c copy "$filename"

ffmpeg -i https://bytefm.cast.addradio.de/bytefm/main/mid/stream.mp3?ar-distributor=ffa0 -nostats -t $duration -c copy "$filename"
echo " "

ls -la "$filename"
echo " "
echo "Done."
# Upload file
# TODO
