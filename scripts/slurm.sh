#!/bin/bash

#SBATCH -s
#SBATCH -n 1
#SBATCH -o /media/sf_transcriber/log/%j.log
#SBATCH -D /home/vagrant/tools/kaldi-offline-transcriber
#SBATCH --get-user-env
# runs speech2text.sh in mode to produce all transcription formats

filename=$(basename "$1")
basename="${filename%.*}"

echo "Starting at `date`, in `pwd`"
./speech2text.sh ${1}
# --trs build/output/`basename -s .flac ${1}`.trs ${1} 
mv build/output/$basename.* /media/sf_transcriber/transcribe-out/

echo "Done ($?) at `date`, ran on $SLURM_NODELIST ($SLURM_NNODES, $SLURM_NPROCS)"
