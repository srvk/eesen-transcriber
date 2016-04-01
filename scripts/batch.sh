#!/bin/bash
#
# queues a slurm.sh job for each file listed in arguments

BASEDIR=$(dirname $0)

cd $BASEDIR

for f in $*; do
    sbatch slurm.sh $f
    sleep 1
done
