#!/bin/bash

# vids2web.sh
#  Script to run speech2text.sh on a video, then copy the results to
# the output folder /var/www/public/video (and /sub) so they appear in
# the video browser (run as an Apache2 service in the VM)
#
# for now only works for .mp4 video file format due to web video player

# Best practice: place videos in shared host folder /vagrant/www/video
# then run this script which will transcribe and produce subtitles and
# update video browser page
#
# Then view in Chrome browser on the IP found in Vagrantfile (nominally 192.168.33.11)

if [ $# -ne 1 ]; then
  echo "usage: ./vids2web.sh <video filename>"
  exit
fi

home=~/tools/eesen-offline-transcriber
filename=$(basename "$1")
extension="${filename##*.}"
basename="${filename%.*}"

echo extension
echo $extension

# fake video from audio
if [ $extension == ".mp4" -o $extension == ".MP4" ]; then
    if [ ! -f /vagrant/www/video/$1 ]; then
        cp $1 /vagrant/www/video
    fi
else
    avconv -y -i $1 -f image2 -loop 1 -r 2 -i /vagrant/www/img/video-generic.png \
	-shortest -acodec aac -vcodec libx264 -b:a 96k -preset veryfast \
	-strict experimental /vagrant/www/video/$basename.mp4
fi

$home/speech2text.sh $1
mkdir -p /vagrant/www/sub
mkdir -p /vagrant/www/video

cp $home/build/output/$basename.srt /vagrant/www/sub
bash $home/mkpages.sh
