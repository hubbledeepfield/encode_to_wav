#!/bin/bash

[ $# -eq 1 ] || { echo "Usage: $0 <inputdir>"; exit 1; }

INPUT_DIR="$1"
DIR_NAME=$(basename "${INPUT_DIR}")
OUTPUT_STORAGE=/Volumes/WD1T/tests/

#TRACKLIST=$(${OUTPUT_STORAGE}/${OUTPUT_DIR}/tracklist.txt)
#mkdir /Volumes/WD1T/tests/${OUTPUT_DIR}

#TODO:
#   done: create new folder for output files
#   done: substitute harcoded input dir
#   avoid white spaces in directory names
#   avoid white spaces in file names
#   make variable for tracklist
#   delete non-media files

#[ -d ${OUTPUT_STORAGE}/${OUTPUT_DIR_NAME} ] || mkdir ${OUTPUT_STORAGE}/${OUTPUT_DIR_NAME}

ffmpeg=/usr/local/bin/ffmpeg

cp -r ${INPUT_DIR} ${OUTPUT_STORAGE}

cd ${OUTPUT_STORAGE}/${DIR_NAME}

ls >> tracklist.txt
cat tracklist.txt | while read i; do
    mv "$i" "${i//[[:space:]]}"
done

rm tracklist.txt

ls >> tracks_to_encode.txt
cat tracks_to_encode.txt | while read i; do
    track=$( echo $i | awk -F".mp3" '{print $1}' )
   # $ffmpeg -i $track.mp3 $track.wav
    echo $track
done;

