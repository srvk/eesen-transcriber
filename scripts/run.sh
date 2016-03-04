#!/bin/bash
#
# run.sh 
#
# script to restart incron daemon and watch
# a folder (presumed to be a shared folder on a 
# host computer running this VM via VirtualBox)
# and move any files placed into it into a local folder
# so that incron events will fire

# Give incron a kick, even if it thinks it's running
# this seems to be an Ubuntu bug on reboot
sudo service incron restart >& /dev/null

# Start a process to watch for shared files and copy them
# locally
./watch.sh &

# Say hello
echo "Kaldi offline transcriber ready"

# clear, then show the log
rm -f transcriber.log
touch transcriber.log
tail -f transcriber.log

