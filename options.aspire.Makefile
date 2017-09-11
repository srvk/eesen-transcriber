KALDI_ROOT=~/kaldi
EESEN_ROOT=~/kaldi
SEGMENTS=show.s.seg

#EESEN_MODELS_ROOT=$(CLUSTER_USER_WORK)/eesen-models
EESEN_MODELS_ROOT=$(KALDI_ROOT)

# Aspire models
MODELS=aspire.kaldi
BEAM=15.0
ACWT=1.0
GRAPH_DIR?=$(EESEN_MODELS_ROOT)/egs/aspire/s5/exp/tdnn_7b_chain_online/graph_pp
MODEL_DIR?=$(EESEN_MODELS_ROOT)/egs/aspire/s5/exp/tdnn_7b_chain_online
sample_rate=8k
fbank=make_fbank_pitch


# Models from Yenda's online3 + aspire setup
# Best WER:
#  acwt 0.7
#  wip  3.5
#ACWT=0.7
#WIP=3.5
#GRAPH_DIR?=$(EESEN_ROOT)/egs/talkbank/s5/aspire/exp/tdnn_7b_chain_online/graph_pp
#MODEL_DIR?=$(EESEN_ROOT)/egs/talkbank/s5/aspire/exp/tdnn_7b_chain_online
#sample_rate=8k
#fbank=make_fbank
