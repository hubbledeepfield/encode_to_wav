#!/bin/bash

[ $# -eq 1 ] || { echo "Usage: $0 <inputdir>"; exit 1; }

INPUT_DIR="$1"
OUTPUT_DIR_NAME=$(basename "${INPUT_DIR}")
OUTPUT_STORAGE=/Volumes/WD1T/tests/

#TRACKLIST=$(${OUTPUT_STORAGE}/${OUTPUT_DIR}/tracklist.txt)
#mkdir /Volumes/WD1T/tests/${OUTPUT_DIR}

[ -d ${OUTPUT_STORAGE}/${OUTPUT_DIR_NAME} ] || mkdir ${OUTPUT_STORAGE}/${OUTPUT_DIR_NAME}

ffmpeg=/usr/local/bin/ffmpeg

ls ${INPUT_DIR}/ >> ${OUTPUT_STORAGE}/${OUTPUT_DIR_NAME}/tracklist.txt

#TODO:
#   done: create new folder for output files
#   done: substitute harcoded input dir
#   avoid white spaces in directory names
#   avoid white spaces in file names
#   make variable for tracklist

cat ${OUTPUT_STORAGE}/${OUTPUT_DIR_NAME}/tracklist.txt | while read i; do
    track=$( echo $i | awk -F".mp3" '{print $1}' )
   # track=$i
    echo ${track}
    $ffmpeg -i ${INPUT_DIR}/${track}.mp3 ${OUTPUT_DIR}/${track}.wav
    echo 'next';
done
