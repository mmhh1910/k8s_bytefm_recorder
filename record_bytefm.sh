#!/bin/bash

# Records one hour of the byte.fm radio stream.
# Supposed to be started at the full hour through a cron job
#
# Duration is passed as the only parameter in the format: 00:59:55



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
duration=$1


# Record stream with ffmpeg
echo Starting: ffmpeg -i https://bytefm.cast.addradio.de/bytefm/main/mid/stream.mp3?ar-distributor=ffa0 -nostats -t $duration -c copy "$filename"

ffmpeg -i https://bytefm.cast.addradio.de/bytefm/main/mid/stream.mp3?ar-distributor=ffa0 -nostats -t $duration -c copy "$filename"
echo " "

ls -la "$filename"
echo " "
echo "Done recording."

# Upload file to ondrive

# put secrets into /root/.config/rclone/rclone.conf
echo "drive_id = $RCLONE_ONEDRIVE_DRIVEID" >> /root/.config/rclone/rclone.conf
echo "token = $RCLONE_ONEDRIVE_TOKEN" >> /root/.config/rclone/rclone.conf

/usr/bin/rclone copyto "$filename" "onedrive:/bytefm/$filename"
echo " "
echo "Done uploading."
sleep 10 
