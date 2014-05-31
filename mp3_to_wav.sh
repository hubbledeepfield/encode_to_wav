#!/bin/bash

DIR=/Volumes/WD1T/music_to_go/jazz

ffmpeg=/usr/local/bin/ffmpeg

#ls $DIR > tracklist.txt

#sed 's/ //g' _tracklist.txt >> tracklist.txt

cat jazz | while read i; do
   # track=$( echo $i | awk -F".mp3" '{print $1}' )
    track=$i
    echo ${track}
    $ffmpeg -i ${DIR}/${track}.mp3 ${DIR}/${track}.wav
    echo 'next';
done
