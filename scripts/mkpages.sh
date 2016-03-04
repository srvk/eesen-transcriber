#!/bin/sh
#
# mkpages.sh - script to create web pages from a folder (beneath the /vagrant/www directory)
#              containing videos named "public" with subfolders "video" and subtitles "sub"

# Format of videos folder:  has name 

cat /vagrant/www/snips/head.snip > /vagrant/www/index.html

# iterate over videos

for f in `ls /vagrant/www/video/*.mp4`; do

  filename=$(basename $f)
  extension="${filename##*.}"
  fn="${filename%.*}"

  echo "processing video" $fn

  # create thumbnail - grab frame at the 1 minute mark
  avconv -i /vagrant/www/video/$fn.mp4 -ss 00:00:57.000 -vframes 1 /vagrant/www/thumbs/$fn.png 2>/dev/null
  if [ ! -f /vagrant/www/thumbs/$fn.png ] # try 1 second mark
     then 
     avconv -i /vagrant/www/video/$fn.mp4 -ss 00:00:01.000 -vframes 1 /vagrant/www/thumbs/$fn.png 2>/dev/null
  fi
  # final try - give up, use dummy thumbnail image
  if [ ! -f /vagrant/www/thumbs/$fn.png ] # try 1 second mark
     then 
     cp /vagrant/www/img/video-generic.png /vagrant/www/thumbs/$fn.png
  fi


  # 
  # create VTT subtitle files from SRT (transcribed) format
  echo -e "WEBVTT\n" >/vagrant/www/sub/$fn.vtt
  cat /vagrant/www/sub/$fn.srt >>/vagrant/www/sub/$fn.vtt
  sed -i s/','/'.'/g /vagrant/www/sub/$fn.vtt


  # create video page
  sed s/__VIDEONAME__/$fn/g /vagrant/www/snips/play-template.html > /vagrant/www/play$fn.html

  # Add video links to list in public/index.html
  cat >> /vagrant/www/index.html <<EOF

            <div class="col-sm-4">
                <div class="video-post v-col-3 wr-video">
                <img src="thumbs/$fn.png" alt="" class="img-responsive"/>
                <a href="play$fn.html"><span class="vd-button"></span></a>
                <h2>Video: $filename </h2>
                </div>
            </div>
EOF


done

cat /vagrant/www/snips/foot.snip >> /vagrant/www/index.html
