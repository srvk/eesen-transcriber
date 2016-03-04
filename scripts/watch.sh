#!/bin/bash
#
# watch.sh
#
# Watch the folder specified for
# new files. If there are any, move them into audio/
# where incrond will see them

#watchfolder=/media/sf_db/transcribe-in
watchfolder=/vagrant/transcribe-in

while true; do
    if [ "$(ls -A $watchfolder)" ]; then
	mv $watchfolder/* audio
    fi
  sleep 10;
done
