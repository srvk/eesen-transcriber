export TOOLS_ROOT=/data/ASR1/tools
export CLUSTER_USER_WORK=/home/${USER}/kaldi/
export EESEN_ROOT=/home/${USER}/kaldi
export KALDI_ROOT=/home/${USER}/kaldi

# paths to sox, lame
#export SOX=$TOOLS_ROOT/sox-14.4.2/
#export LD_LIBRARY_PATH=$SOX/install/lib:$LD_LIBRARY_PATH
#export PATH=$SOX/install/bin:$TOOLS_ROOT/lame-3.99.5/frontend:$PATH

export PATH=$KALDI_ROOT/src/online2bin:$EESEN_ROOT/src/bin:$EESEN_ROOT/tools/sctk/bin:$EESEN_ROOT/tools/sph2pipe_v2.5:$EESEN_ROOT/tools/openfst/bin:$EESEN_ROOT/src/fstbin/:$EESEN_ROOT/src/featbin/:$EESEN_ROOT/src/lm/:$EESEN_ROOT/src/decoderbin:$EESEN_ROOT/src/netbin:$PWD:$PATH

export LC_ALL=C

# ROCKS
#module load gcc-4.9.2
#module load python27

# PSC Bridges
#module load atlas
#module load gcc

