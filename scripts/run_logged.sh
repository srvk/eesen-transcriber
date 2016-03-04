#!/bin/bash -x
#
# executes the stt.sh command and logs results

BASEDIR=$(dirname $0)

cd $BASEDIR

./stt.sh $1 $2 $3 >> transcriber.log 2>&1
