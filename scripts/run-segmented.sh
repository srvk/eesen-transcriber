#!/bin/bash
#
# Shell script to set up folder structure in preparation
# for running kaldi offline transcriber with segmentation already performed
#
# Takes base name of files with extensions in folder src-audio, e.g. 
# ./run-segmented.sh HVC000037
#
# src-audio/HVC000037.mp4
# src-audio/HVC000037.seg

if [ $# -ne 1 ]; then
  echo "Usage: run-segmented.sh <basename>"
  echo "where <basename> is the basename of files in folder src-audio with"
  echo "extensions .mp4 and .seg"
  echo "For example, if inputs are in src-audio/HVC000037.mp4 and src-audio/HVC000037.seg"
  echo
  echo "./run-segmented.sh HVC000037"
  exit 1;
fi

make build/audio/base/$1.wav

mkdir -p build/diarization/$1

cp src-audio/$1.seg build/diarization/$1/show.seg

make build/output/$1.srt
