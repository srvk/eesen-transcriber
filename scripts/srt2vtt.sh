#!/bin/bash
#
# srt2vtt.sh - convert SRT format to VTT format subtitle file

filename=$(basename "$1")
filename="${filename%.*}"

echo -e "WEBVTT\n" >$filename.vtt
cat $1 >>$filename.vtt
sed -i s/','/'.'/g $filename.vtt
