#!/bin/sh
#
# mkpages.sh - script to create web pages from a folder (beneath the /vagrant/www directory)
#              containing videos named "public" with subfolders "video" and subtitles "sub"

# Format of videos folder:  has name 

www=/vagrant/www 

cat $www/snips/head.snip > $www/index.html

# iterate over videos

for f in `ls ${www}/video/*.mp4`; do

  filename=$(basename $f)
  extension="${filename##*.}"
  fn="${filename%.*}"

  echo "processing " $fn

  # create thumbnail - grab frame at the 1 minute mark
  avconv -i $www/video/$fn.mp4 -ss 00:00:57.000 -vframes 1 $www/thumbs/$fn.png 2>/dev/null
  if [ ! -f $www/thumbs/$fn.png ] # try 1 second mark
     then 
     avconv -i $www/video/$fn.mp4 -ss 00:00:01.000 -vframes 1 $www/thumbs/$fn.png 2>/dev/null
  fi
  # final try - give up, use dummy thumbnail image
  if [ ! -f $www/thumbs/$fn.png ] # try 1 second mark
     then 
     cp $www/img/video-generic.png $www/thumbs/$fn.png
  fi


  # 
  # create VTT subtitle files from SRT (transcribed) format
  echo -e "WEBVTT\n" >$www/sub/$fn.vtt
  cat $www/sub/$fn.srt >>$www/sub/$fn.vtt
  sed -i s/','/'.'/g $www/sub/$fn.vtt


  # create video page
  sed s/__VIDEONAME__/$fn/g $www/snips/play-template.html > $www/play$fn.html

  # Add video links to list in public/index.html
  cat >> $www/index.html <<EOF

            <div class="col-sm-4">
                <div class="video-post v-col-3 wr-video">
                <img src="thumbs/$fn.png" alt="" class="img-responsive"/>
                <a href="play$fn.html"><span class="vd-button"></span></a>
                <h2>Video: $filename </h2>
                </div>
            </div>
EOF


done

cat $www/snips/foot.snip >> $www/index.html
