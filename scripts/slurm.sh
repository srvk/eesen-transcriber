#!/bin/bash

#SBATCH -s
#SBATCH -n 1
#SBATCH -o /vagrant/log/%j.log
#SBATCH -D /home/vagrant/tools/eesen-offline-transcriber
#SBATCH --get-user-env
# runs vids2web.sh as a SLURM batch job

filename=$(basename "$1")
basename="${filename%.*}"

echo "Starting at `date`, in `pwd`"
./vids2web.sh ${1}

echo "Done ($?) at `date`, ran on $SLURM_NODELIST ($SLURM_NNODES, $SLURM_NPROCS)"
