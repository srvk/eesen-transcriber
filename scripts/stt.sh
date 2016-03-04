#!/bin/bash

BASEDIR=$(dirname $0)
LOCKFILE=$BASEDIR/LOCK

#echo "lockfile:"
#echo $LOCKFILE

if [ -e $LOCKFILE ]; then
    echo "LOCKED, exiting. This usually indicates processing is in progress. If you believe this should be working, try deleting the file LOCK then restarting."
    exit 1;
fi

touch $LOCKFILE

echo "$0 $@"  # Print the command line for logging

txt=""
trs=""
ctm=""
sbv=""
srt=""
clean=true
nthreads=""
nnet2_online=false

. $BASEDIR/utils/parse_options.sh || exit 1;

if [ $# -ne 1 ]; then
  echo "Usage: speech2text [options] <audiofile>"
  echo "Options:"
  echo "  --nthreads <n>        # Use <n> threads in parallel for decoding"
  echo "  --txt <txt-file>      # Put the result in a simple text file"
  echo "  --trs <trs-file>      # Put the result in trs file (XML file for Transcriber)"
  echo "  --ctm <ctm-file>      # Put the result in CTM file (one line pwer word with timing information)"
  echo "  --sbv <sbv-file>      # Put the result in SBV file (subtitles for e.g. YouTube)"
  echo "  --srt <srt-file>      # Put the result in SRT file (subtitles)"
  echo "  --clean (true|false)  # Delete intermediate files generated during decoding (true by default)"
  echo "  --nnet2-online (true|false) # Use one-pass decoding using online nnet2 models. 3 times faster, 10% relatively more errors (false by default)"
  exit 1;
fi

DIRNAME=$(dirname $1)

nthreads_arg=""
if [ ! -z $nthreads ]; then
  echo "Using $nthreads threads for decoding"
  nthreads_arg="nthreads=$nthreads"
fi
  
cp -u $1 $BASEDIR/src-audio

filename=$(basename "$1")
basename="${filename%.*}"

nnet2_online_arg="DO_NNET2_ONLINE=no"
if $nnet2_online; then
  nnet2_online_arg="DO_NNET2_ONLINE=yes"
fi

(cd $BASEDIR; make $nthreads_arg $nnet2_online_arg build/output/${basename%.*}.{txt,trs,ctm,sbv,srt} || exit 1; if $clean ; then make .${basename%.*}.clean; fi)

echo "Finished transcribing, result is in files $BASEDIR/build/output/${basename%.*}.{txt,trs,ctm,sbv,srt}"

if [ ! -z $txt ]; then
  cp $BASEDIR/build/output/${basename%.*}.txt $txt
  echo $txt
fi

if [ ! -z $trs ]; then                                                                                                                
  cp $BASEDIR/build/output/${basename%.*}.trs $trs                                                                                    
fi                                                                                                                                    
                                                                                                                                      
if [ ! -z $ctm ]; then                                                                                                                
  cp $BASEDIR/build/output/${basename%.*}.ctm $ctm                                                                                    
fi                                                                                                                                    
                                                                                                                                      
if [ ! -z $sbv ]; then                                                                                                                
  cp $BASEDIR/build/output/${basename%.*}.sbv $sbv                                                                                    
fi    

if [ ! -z $srt ]; then                                                                                                                
  cp $BASEDIR/build/output/${basename%.*}.srt $srt
fi    

rm $1
rm -f $LOCKFILE
# this should trigger incron to attempt to (re-) process remaining files
if [ "$(ls -A $DIRNAME)" ]; then
    for fn in `ls $DIRNAME`; do
	touch $fn
	sleep 1
    done
fi

