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

if grep --quiet vagrant /etc/passwd
then
  provider="virtualbox"
else
  provider="aws"
fi


if [ $provider=="virtualbox" ]; then

    # use timestamps to compare processed files (won't work in AWS sshfs-ed folders)
    TIMESTAMP=$PATH_TO_WATCH/.lastwatch
    while true
    do
       touch -m $TIMESTAMP
       sleep 10
       find $PATH_TO_WATCH -type f -cnewer $TIMESTAMP -not -name "*.ctm" -not -name ".lastwatch" -exec ./batch.sh {} \;
    done

else
    # use Setuid bit to flag processed files (wont' work in Virtualbox shared folders)
    echo "expecting aws Provider: " $provider

    while true
    do
	sleep 10
	find $PATH_TO_WATCH -type f -not -perm -2000 -not -name "*.ctm" -exec ./batch.sh {} \; -exec chmod g+s {} \;
    done
fi
