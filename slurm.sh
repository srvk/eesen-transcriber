#!/bin/bash

#SBATCH -s
#SBATCH -n 1
#SBATCH -o /vagrant/log/%j.log
#SBATCH -D /home/vagrant/tools/eesen-offline-transcriber
#SBATCH --get-user-env
# runs speech2text.sh in mode to produce all transcription formats

filename=$(basename "$1")
basename="${filename%.*}"

echo "Starting at `date`, in `pwd`"
./speech2text.sh ${1}
# --trs build/output/`basename -s .flac ${1}`.trs ${1}
mv build/output/$basename.* /vagrant/trans-out/

echo "Done ($?) at `date`, ran on $SLURM_NODELIST ($SLURM_NNODES, $SLURM_NPROCS)"
