#!/bin/bash

[ $# -eq 2 ] || { echo "Usage: $0 <inputdir>, <dest_format>"; exit 1; }

INPUT_DIR="$1"
dest_format="$2"
DIR_NAME=$(basename "${INPUT_DIR}")
OUTPUT_STORAGE=/Volumes/WD1T/tests/

#TRACKLIST=$(${OUTPUT_STORAGE}/${OUTPUT_DIR}/tracklist.txt)
#mkdir ${OUTPUT_STORAGE}/${OUTPUT_DIR}

#TODO:
#   done: create new folder for output files
#   done: substitute harcoded input dir
#   avoid white spaces in directory names
#   avoid white spaces in file names
#   make variable for tracklist
#   delete non-media files

[ -d ${OUTPUT_STORAGE}/${DIR_NAME} ] || mkdir ${OUTPUT_STORAGE}/${DIR_NAME}

ffmpeg=/usr/local/bin/ffmpeg
acodec=pcm_s16le


cp -r ${INPUT_DIR} ${OUTPUT_STORAGE}

cd ${OUTPUT_STORAGE}/${DIR_NAME}

ls  > tracklist.txt
cat tracklist.txt | while read i; do
    mv "$i" "${i//[[:space:]]}"
done

if [ $dest_format == "mp3" ]; then
    for track in $INPUT_DIR
    do
        echo $track
        #$ffmpeg -y -i $track -codec:a libmp3lame -qscale:a 0 $track.mp3
    done
fi

ls | grep "mp3" > tracks_to_encode.txt
cat tracks_to_encode.txt | while read i; do
    title=$( echo $i | awk -F".mp3" '{print $1}' )
    $ffmpeg -y -i $title.mp3 -acodec $acodec $title.wav
    echo $title
    rm $title.mp3
done;

