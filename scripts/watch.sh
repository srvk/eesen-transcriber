#!/bin/bash
#
# watch.sh
#
# script to watch a folder for new files, and process the results
#

PATH_TO_WATCH=/vagrant/transcribe_me/

BASEDIR=$(dirname $0)

echo "Watching folder (/vagrant/)transcribe_me/ for new files to transcribe..."
echo ".ctm files will appear alongside source files"
echo "logs are in (/vagrant/)log/"

cd $BASEDIR

while true
do
       sleep 10
       find $PATH_TO_WATCH -type f -not -perm -2000 -not -name "*.ctm" -exec ./batch.sh {} \; -exec chmod g+s {} \;
done
