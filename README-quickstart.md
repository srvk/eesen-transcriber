EESEN Offline Transcriber Quickstart guide

The fastest way to get started with this system presumes you have already installed Vagrant,
and have downloaded / cloned / unzipped this repistory to a local drive.

From here the steps towards producing a test transcription are as follows:

1. `vagrant up` in the current working directory that contains this file, (and especially, the Vagrantfile)
2. After much output and processing, the Vagrant VM should be provisioned and ready
3. `vagrant ssh` to log into the VM
4. `cd /home/vagrant/tools/eesen-offline-transcriber`
5. Initiate transcription of the test file test1.wav with `./speech2text.sh test1.wav`
6. Output should appear in `build/trans/test1.*`

Here is what a successful run of the command should look like:
```
./speech2text.sh test1.wav
mkdir -p `dirname build/audio/base/test1.wav`
sox src-audio/test1.wav -c 1 -2 build/audio/base/test1.wav rate -v 16k
sox WARN sox: Option `-2' is deprecated, use `-b 16' instead.
rm -rf `dirname build/diarization/test1/show.seg`
mkdir -p `dirname build/diarization/test1/show.seg`
echo "test1 1 0 1000000000 U U U 1" >  `dirname build/diarization/test1/show.seg`/show.uem.seg;
./scripts/diarization.sh build/audio/base/test1.wav `dirname build/diarization/test1/show.seg`/show.uem.seg;
#####################################################
#   show
#####################################################
***none=none
***none=add
***none=remplace
show = show
info[info] 	 ====================================================== 
info[program] 	 name = MSegInit
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterFeature-Input] 	 --fInputMask 	 Features input mask = build/audio/base/test1.wav
info[ParameterFeature-Input] 	 --fInputDesc 	 Features info (type[,s:e:ds:de:dds:dde,dim,c:r:wSize:method]) = audio2sphinx,1:1:0:0:0:0,13,0
:0:0:0
info[ParameterFeature-Input] 	 	 type [sphinx,spro4,htk,gztxt,audio2sphinx] = audio2sphinx (4)
info[ParameterFeature-Input] 	 	 static [0=not present,1=present ,3=to be removed] = 1
info[ParameterFeature-Input] 	 	 energy [0,1,3] = 1
info[ParameterFeature-Input] 	 	 delta [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta energy [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta delta [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 delta delta energy [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 file dim = 13
info[ParameterFeature-Input] 	 	 normalization, center [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, reduce [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, window size = 0
info[ParameterFeature-Input] 	 	 normalization, method [0 (segment), 1 (cluster), 2 (sliding), 3 (warping)] =0
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = build/diarization/test1/show.uem.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation 
format = seg,ISO-8859-1
info[ParameterSegmentationFile-Output] 	 --sOutputMask 	 segmentation mask = ./build/diarization/test1/show.i.seg
info[ParameterSegmentationFile-Output ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sOutputFormat 	 segmentation 
format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
[FeatureSet] read : compute data test1 // % mem free=0.012232554737910146 used=11 max=910
WARNING[mSegInit] 	 segment end after features end
***none=none
***none=add
***none=remplace
show = show
info[info] 	 ====================================================== 
info[program] 	 name = MDecode
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterFeature-Input] 	 --fInputMask 	 Features input mask = build/audio/base/test1.wav
info[ParameterFeature-Input] 	 --fInputDesc 	 Features info (type[,s:e:ds:de:dds:dde,dim,c:r:wSize:method]) = audio2sphinx,1:3:2:0:0:0,13,0
:0:0:0
info[ParameterFeature-Input] 	 	 type [sphinx,spro4,htk,gztxt,audio2sphinx] = audio2sphinx (4)
info[ParameterFeature-Input] 	 	 static [0=not present,1=present ,3=to be removed] = 1
info[ParameterFeature-Input] 	 	 energy [0,1,3] = 3
info[ParameterFeature-Input] 	 	 delta [0,1,2=computed on the fly,3] = 2
[FeatureSet] read : compute data test1 // % mem free=0.013286709981852348 used=12 max=910
***none=none
***none=add
***none=remplace
[FeatureSet] read : compute data test1 // % mem free=0.012266876539118272 used=11 max=910
***none=none
***none=add
***none=remplace
[FeatureSet] read : compute data test1 // % mem free=0.012249698879822213 used=11 max=910
***none=none
***none=add
***none=remplace
[FeatureSet] read : compute data test1 // % mem free=0.012249698879822213 used=11 max=910
***none=none
***none=add
***none=remplace
[FeatureSet] read : compute data test1 // % mem free=0.012266876539118272 used=11 max=910
***none=none
***none=add
***none=remplace
[FeatureSet] read : compute data test1 // % mem free=0.01225001729497014 used=11 max=910
***none=none
***none=add
***none=remplace
[FeatureSet] read : compute data test1 // % mem free=0.01223588971761738 used=11 max=910
***none=none
***none=add
***none=remplace
***none=none
***none=add
***none=remplace
***none=none
***none=add
***none=remplace
***none=none
***none=add
***none=remplace
testprog: unrecognized option '--sSegMaxLenModel=2000'
[FeatureSet] read : compute data test1 // % mem free=0.013269532322556288 used=12 max=910
***none=none
***none=add
***none=remplace
[FeatureSet] read : compute data test1 // % mem free=0.013338175924972542 used=12 max=910
***none=none
***none=add
***none=remplace
[FeatureSet] read : compute data test1 // % mem free=0.005329934402457441 used=4 max=910
info[ParameterFeature-Input] 	 	 delta energy [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta delta [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 delta delta energy [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 file dim = 13
info[ParameterFeature-Input] 	 	 normalization, center [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, reduce [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, window size = 0
info[ParameterFeature-Input] 	 	 normalization, method [0 (segment), 1 (cluster), 2 (sliding), 3 (warping)] =0
info[ParameterFeature-Input] 	 --fInputMemoryOccupationRate 	 memory occupation rate of the feature in the java virtual machine = 0.8
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.i.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation 
format = seg,ISO-8859-1
info[ParameterSegmentationFile-Output] 	 --sOutputMask 	 segmentation mask = ./build/diarization/test1/show.pms.seg
info[ParameterSegmentationFile-Output ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sOutputFormat 	 segmentation 
format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
info[ParameterModelSet] 	 --tInputMask 	 model mask = models/sms.gmms
info[ParameterTopGaussian] 	 --sTop 	 use top Gaussians (ntop,modelMask) = -1,
info[ParameterTopGaussian] 		 nb = -1
info[ParameterTopGaussian] 		 model = 
info[info] 	 ------------------------------------------------------ 
info[ParameterDecoder] 	 --dPenalty 	 model penalties = 500.0:0.0, 500.0:0.0, 10.0
info[ParameterDecoder] 	 --dDurationConstraints 	 duration constraints during decoding [none|(minimal|periodic|fixed,value)] = none
info[ParameterDecoder] 	 --dComputeLLhR 	 score is Log Likelihood Ratio = false
info[ParameterDecoder] 	 --dShift 	 size of a step = 1
show = show
info[info] 	 ====================================================== 
info[program] 	 name = MSeg
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterFeature-Input] 	 --fInputMask 	 Features input mask = build/audio/base/test1.wav
info[ParameterFeature-Input] 	 --fInputDesc 	 Features info (type[,s:e:ds:de:dds:dde,dim,c:r:wSize:method]) = audio2sphinx,1:1:0:0:0:0,13,0
:0:0:0
info[ParameterFeature-Input] 	 	 type [sphinx,spro4,htk,gztxt,audio2sphinx] = audio2sphinx (4)
info[ParameterFeature-Input] 	 	 static [0=not present,1=present ,3=to be removed] = 1
info[ParameterFeature-Input] 	 	 energy [0,1,3] = 1
info[ParameterFeature-Input] 	 	 delta [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta energy [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta delta [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 delta delta energy [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 file dim = 13
info[ParameterFeature-Input] 	 	 normalization, center [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, reduce [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, window size = 0
info[ParameterFeature-Input] 	 	 normalization, method [0 (segment), 1 (cluster), 2 (sliding), 3 (warping)] =0
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.i.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation 
format = seg,ISO-8859-1
info[ParameterSegmentationFile-Output] 	 --sOutputMask 	 segmentation mask = ./build/diarization/test1/show.s.seg
info[ParameterSegmentationFile-Output ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sOutputFormat 	 segmentation 
format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
info[ParameterModel] 	 --kind 	 kind of Gaussians [FULL,DIAG] = FULL(0)
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentation] 	 --sMethod 	 seg similarity [BIC,GLR,KL2,GD,H2] = GLR(1)
info[ParameterSegmentation] 	 --sThr 	 seg threshold = -2.147483648E9
info[ParameterSegmentation] 	 --sModelWindowSize 	 seg 1/2 window size (in features) = 250
info[ParameterSegmentation] 	 --sMinimumWindowSize 	 seg min size segment (in features) = 250
info[ParameterSegmentation] 	 --sRecursion 	 segmentation make by a recursion fonction = false
show = show

info[info] 	 ====================================================== 
info[program] 	 name = MClust
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterFeature-Input] 	 --fInputMask 	 Features input mask = build/audio/base/test1.wav
info[ParameterFeature-Input] 	 --fInputDesc 	 Features info (type[,s:e:ds:de:dds:dde,dim,c:r:wSize:method]) = audio2sphinx,1:1:0:0:0:0,13,0:0:0:0
info[ParameterFeature-Input] 	 	 type [sphinx,spro4,htk,gztxt,audio2sphinx] = audio2sphinx (4)
info[ParameterFeature-Input] 	 	 static [0=not present,1=present ,3=to be removed] = 1
info[ParameterFeature-Input] 	 	 energy [0,1,3] = 1
info[ParameterFeature-Input] 	 	 delta [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta energy [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta delta [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 delta delta energy [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 file dim = 13
info[ParameterFeature-Input] 	 	 normalization, center [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, reduce [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, window size = 0
info[ParameterFeature-Input] 	 	 normalization, method [0 (segment), 1 (cluster), 2 (sliding), 3 (warping)] =0
info[ParameterFeature-Input] 	 --fInputMemoryOccupationRate 	 memory occupation rate of the feature in the java virtual machine = 0.8
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.s.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterSegmentationFile-Output] 	 --sOutputMask 	 segmentation mask = ./build/diarization/test1/show.l.seg
info[ParameterSegmentationFile-Output ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sOutputFormat 	 segmentation format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
info[ParameterSystem] 	 --saveAllStep = false
info[info] 	 ------------------------------------------------------ 
info[clust] 	 --cMethod 	 clustering method [l, r, h, c, ce, kl2, h2, gd, gdgmm, icr, t, glr] = l(0)
info[ParameterClustering] 	 --cThr 	 clustering threshold = 2.5
info[ParameterClustering] 	 --cMaximumMerge 	 maximum number of merges = 2147483647
info[ParameterClustering] 	 --cMinimumOfCluster 	 minum number of speakers = 0
info[ParameterClustering] 	 --cMinimumLength 	 minum length of cluster = 2147483647
info[info] 	 ------------------------------------------------------ 
info[ParameterModelSet] 	 --tOutputMask 	 model mask = %s.out.gmms
info[info] 	 ------------------------------------------------------ 
info[ParameterModel] 	 --kind 	 kind of Gaussians [FULL,DIAG] = FULL(0)
info[ParameterModel] 	 --nbComp 	 number of Gaussians = 1
[FeatureSet] read : compute data test1 // % mem free=0.012249698879822213 used=11 max=910
***none=none
***none=add
***none=remplace
show = show
info[info] 	 ====================================================== 
info[program] 	 name = MClust
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterFeature-Input] 	 --fInputMask 	 Features input mask = build/audio/base/test1.wav
info[ParameterFeature-Input] 	 --fInputDesc 	 Features info (type[,s:e:ds:de:dds:dde,dim,c:r:wSize:method]) = audio2sphinx,1:1:0:0:0:0,13,0:0:0:0
info[ParameterFeature-Input] 	 	 type [sphinx,spro4,htk,gztxt,audio2sphinx] = audio2sphinx (4)
info[ParameterFeature-Input] 	 	 static [0=not present,1=present ,3=to be removed] = 1
info[ParameterFeature-Input] 	 	 energy [0,1,3] = 1
info[ParameterFeature-Input] 	 	 delta [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta energy [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta delta [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 delta delta energy [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 file dim = 13
info[ParameterFeature-Input] 	 	 normalization, center [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, reduce [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, window size = 0
info[ParameterFeature-Input] 	 	 normalization, method [0 (segment), 1 (cluster), 2 (sliding), 3 (warping)] =0
info[ParameterFeature-Input] 	 --fInputMemoryOccupationRate 	 memory occupation rate of the feature in the java virtual machine = 0.8
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.l.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterSegmentationFile-Output] 	 --sOutputMask 	 segmentation mask = ./build/diarization/test1/show.h.seg
info[ParameterSegmentationFile-Output ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sOutputFormat 	 segmentation format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
info[ParameterSystem] 	 --saveAllStep = false
info[info] 	 ------------------------------------------------------ 
info[clust] 	 --cMethod 	 clustering method [l, r, h, c, ce, kl2, h2, gd, gdgmm, icr, t, glr] = h(1)
info[ParameterClustering] 	 --cThr 	 clustering threshold = 6.0
info[ParameterClustering] 	 --cMaximumMerge 	 maximum number of merges = 2147483647
info[ParameterClustering] 	 --cMinimumOfCluster 	 minum number of speakers = 0
info[ParameterClustering] 	 --cMinimumLength 	 minum length of cluster = 2147483647
info[info] 	 ------------------------------------------------------ 
info[ParameterModelSet] 	 --tOutputMask 	 model mask = %s.out.gmms
info[info] 	 ------------------------------------------------------ 
info[ParameterModel] 	 --kind 	 kind of Gaussians [FULL,DIAG] = FULL(0)
info[ParameterModel] 	 --nbComp 	 number of Gaussians = 1
[FeatureSet] read : compute data test1 // % mem free=0.012249698879822213 used=11 max=910
***none=none
***none=add
***none=remplace
show = show
info[info] 	 ====================================================== 
info[program] 	 name = MTrainInit
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterFeature-Input] 	 --fInputMask 	 Features input mask = build/audio/base/test1.wav
info[ParameterFeature-Input] 	 --fInputDesc 	 Features info (type[,s:e:ds:de:dds:dde,dim,c:r:wSize:method]) = audio2sphinx,1:1:0:0:0:0,13,0:0:0:0
info[ParameterFeature-Input] 	 	 type [sphinx,spro4,htk,gztxt,audio2sphinx] = audio2sphinx (4)
info[ParameterFeature-Input] 	 	 static [0=not present,1=present ,3=to be removed] = 1
info[ParameterFeature-Input] 	 	 energy [0,1,3] = 1
info[ParameterFeature-Input] 	 	 delta [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta energy [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta delta [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 delta delta energy [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 file dim = 13
info[ParameterFeature-Input] 	 	 normalization, center [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, reduce [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, window size = 0
info[ParameterFeature-Input] 	 	 normalization, method [0 (segment), 1 (cluster), 2 (sliding), 3 (warping)] =0
info[ParameterFeature-Input] 	 --fInputMemoryOccupationRate 	 memory occupation rate of the feature in the java virtual machine = 0.8
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.h.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterModel] 	 --kind 	 kind of Gaussians [FULL,DIAG] = DIAG(1)
info[ParameterModel] 	 --nbComp 	 number of Gaussians = 8
info[ParameterModelSet] 	 --tOutputMask 	 model mask = ./build/diarization/test1/show.init.gmms
info[info] 	 ------------------------------------------------------ 
info[ParameterEM] 	 --emCtrl 	 EM control (minIt,maxIt,minGain) = 1,5,0.01 (1,5,0.01)
info[ParameterEM] 	 	 minIt = 1
info[ParameterEM] 	 	 maxIt = 5
info[ParameterEM] 	 	 minGain = 0.01
info[ParameterInitializationEM]  --emInitMethod	em initialization method [split_all, split, uniform, copy] = uniform(2)
info[info] 	 ------------------------------------------------------ 
[FeatureSet] read : compute data test1 // % mem free=0.012284020681030341 used=11 max=910
***none=none
***none=add
***none=remplace
show = show
info[info] 	 ====================================================== 
info[program] 	 name = MTrainEM
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterFeature-Input] 	 --fInputMask 	 Features input mask = build/audio/base/test1.wav
info[ParameterFeature-Input] 	 --fInputDesc 	 Features info (type[,s:e:ds:de:dds:dde,dim,c:r:wSize:method]) = audio2sphinx,1:1:0:0:0:0,13,0:0:0:0
info[ParameterFeature-Input] 	 	 type [sphinx,spro4,htk,gztxt,audio2sphinx] = audio2sphinx (4)
info[ParameterFeature-Input] 	 	 static [0=not present,1=present ,3=to be removed] = 1
info[ParameterFeature-Input] 	 	 energy [0,1,3] = 1
info[ParameterFeature-Input] 	 	 delta [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta energy [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta delta [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 delta delta energy [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 file dim = 13
info[ParameterFeature-Input] 	 	 normalization, center [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, reduce [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, window size = 0
info[ParameterFeature-Input] 	 	 normalization, method [0 (segment), 1 (cluster), 2 (sliding), 3 (warping)] =0
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.h.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
info[ParameterModelSet] 	 --tInputMask 	 model mask = ./build/diarization/test1/show.init.gmms
info[ParameterModelSet] 	 --tOutputMask 	 model mask = ./build/diarization/test1/show.gmms
info[info] 	 ------------------------------------------------------ 
info[ParameterEM] 	 --emCtrl 	 EM control (minIt,maxIt,minGain) = 3,10,0.01 (3,10,0.01)
info[ParameterEM] 	 	 minIt = 3
info[ParameterEM] 	 	 maxIt = 10
info[ParameterEM] 	 	 minGain = 0.01
info[ParameterVarianceControl] 	 --varCtrl 	 covariance control (floor[,ceil]) = 0.0,10.0
info[ParameterVarianceControl] 	 	 flooring = 0.0
info[ParameterVarianceControl] 	 	 ceilling = 10.0
info[info] 	 ------------------------------------------------------ 
[FeatureSet] read : compute data test1 // % mem free=0.012249698879822213 used=11 max=910
***none=none
***none=add
***none=remplace
show = show
info[info] 	 ====================================================== 
info[program] 	 name = MDecode
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterFeature-Input] 	 --fInputMask 	 Features input mask = build/audio/base/test1.wav
info[ParameterFeature-Input] 	 --fInputDesc 	 Features info (type[,s:e:ds:de:dds:dde,dim,c:r:wSize:method]) = audio2sphinx,1:1:0:0:0:0,13,0:0:0:0
info[ParameterFeature-Input] 	 	 type [sphinx,spro4,htk,gztxt,audio2sphinx] = audio2sphinx (4)
info[ParameterFeature-Input] 	 	 static [0=not present,1=present ,3=to be removed] = 1
info[ParameterFeature-Input] 	 	 energy [0,1,3] = 1
info[ParameterFeature-Input] 	 	 delta [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta energy [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta delta [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 delta delta energy [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 file dim = 13
info[ParameterFeature-Input] 	 	 normalization, center [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, reduce [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, window size = 0
info[ParameterFeature-Input] 	 	 normalization, method [0 (segment), 1 (cluster), 2 (sliding), 3 (warping)] =0
info[ParameterFeature-Input] 	 --fInputMemoryOccupationRate 	 memory occupation rate of the feature in the java virtual machine = 0.8
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.h.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterSegmentationFile-Output] 	 --sOutputMask 	 segmentation mask = ./build/diarization/test1/show.d.seg
info[ParameterSegmentationFile-Output ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sOutputFormat 	 segmentation format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
info[ParameterModelSet] 	 --tInputMask 	 model mask = build/diarization/test1/show.gmms
info[ParameterTopGaussian] 	 --sTop 	 use top Gaussians (ntop,modelMask) = -1,
info[ParameterTopGaussian] 		 nb = -1
info[ParameterTopGaussian] 		 model = 
info[info] 	 ------------------------------------------------------ 
info[ParameterDecoder] 	 --dPenalty 	 model penalties = 250.0
info[ParameterDecoder] 	 --dDurationConstraints 	 duration constraints during decoding [none|(minimal|periodic|fixed,value)] = none
info[ParameterDecoder] 	 --dComputeLLhR 	 score is Log Likelihood Ratio = false
info[ParameterDecoder] 	 --dShift 	 size of a step = 1
[FeatureSet] read : compute data test1 // % mem free=0.012270211518825508 used=11 max=910
***none=none
***none=add
***none=remplace
show = show
info[info] 	 ====================================================== 
info[program] 	 name = SAdjSeg
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterFeature-Input] 	 --fInputMask 	 Features input mask = build/audio/base/test1.wav
info[ParameterFeature-Input] 	 --fInputDesc 	 Features info (type[,s:e:ds:de:dds:dde,dim,c:r:wSize:method]) = audio2sphinx,1:1:0:0:0:0,13,0:0:0:0
info[ParameterFeature-Input] 	 	 type [sphinx,spro4,htk,gztxt,audio2sphinx] = audio2sphinx (4)
info[ParameterFeature-Input] 	 	 static [0=not present,1=present ,3=to be removed] = 1
info[ParameterFeature-Input] 	 	 energy [0,1,3] = 1
info[ParameterFeature-Input] 	 	 delta [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta energy [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta delta [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 delta delta energy [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 file dim = 13
info[ParameterFeature-Input] 	 	 normalization, center [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, reduce [0,1] = 0
info[ParameterFeature-Input] 	 	 normalization, window size = 0
info[ParameterFeature-Input] 	 	 normalization, method [0 (segment), 1 (cluster), 2 (sliding), 3 (warping)] =0
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.d.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterSegmentationFile-Output] 	 --sOutputMask 	 segmentation mask = ./build/diarization/test1/show.adj.h.seg
info[ParameterSegmentationFile-Output ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sOutputFormat 	 segmentation format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
info[ParameterAdjustSegmentation] 	 --sSeachDecay = 25
info[ParameterAdjustSegmentation] 	 --sHalfWindowSizeForEnergie = 5
***none=none
***none=add
***none=remplace
show = show
info[info] 	 ====================================================== 
info[program] 	 name = SFilter
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.adj.h.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterSegmentationFile-Filter] 	 --sFilterMask 	 segmentation mask = ./build/diarization/test1/show.pms.seg
info[ParameterSegmentationFile-Filter ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sFilterFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterSegmentationFile-Output] 	 --sOutputMask 	 segmentation mask = ./build/diarization/test1/show.flt1.seg
info[ParameterSegmentationFile-Output ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sOutputFormat 	 segmentation format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
info[ParameterFilterClusterName] 	 --sFilterClusterName 	 name of the filterCluster = music
info[info] 	 ------------------------------------------------------ 
info[ParameterFilter] 	 --fltSegMinLenSil = 25
info[ParameterFilter] 	 --fltSegMinLenSpeech = 150
info[ParameterFilter] 	 --fltSegPadding = 25
***none=none
***none=add
***none=remplace
show = show
info[info] 	 ====================================================== 
info[program] 	 name = SFilter
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.flt1.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterSegmentationFile-Filter] 	 --sFilterMask 	 segmentation mask = ./build/diarization/test1/show.pms.seg
info[ParameterSegmentationFile-Filter ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sFilterFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterSegmentationFile-Output] 	 --sOutputMask 	 segmentation mask = ./build/diarization/test1/show.flt2.seg
info[ParameterSegmentationFile-Output ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sOutputFormat 	 segmentation format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
info[ParameterFilterClusterName] 	 --sFilterClusterName 	 name of the filterCluster = jingle
info[info] 	 ------------------------------------------------------ 
info[ParameterFilter] 	 --fltSegMinLenSil = 25
info[ParameterFilter] 	 --fltSegMinLenSpeech = 150
info[ParameterFilter] 	 --fltSegPadding = 25
***none=none
***none=add
***none=remplace
testprog: unrecognized option '--sSegMaxLenModel=2000'
show = show
info[info] 	 ====================================================== 
info[program] 	 name = SSplitSeg
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.flt2.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterSegmentationFile-Filter] 	 --sFilterMask 	 segmentation mask = ./build/diarization/test1/show.pms.seg
info[ParameterSegmentationFile-Filter ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sFilterFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterSegmentationFile-Output] 	 --sOutputMask 	 segmentation mask = ./build/diarization/test1/show.spl.seg
info[ParameterSegmentationFile-Output ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sOutputFormat 	 segmentation format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
info[ParameterFilterClusterName] 	 --sFilterClusterName 	 name of the filterCluster = iS,iT,j
info[ParameterModelSet] 	 --tInputMask 	 model mask = models/s.gmms
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentationSplit] 	 --sSegMaxLen = 2000
info[ParameterSegmentationSplit] 	 --sSegMinLen = 200
[FeatureSet] read : compute data test1 // % mem free=0.013286994879616282 used=12 max=910
***none=none
***none=add
***none=remplace
show = show
info[info] 	 ====================================================== 
info[program] 	 name = MScore
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterFeature-Input] 	 --fInputMask 	 Features input mask = build/audio/base/test1.wav
info[ParameterFeature-Input] 	 --fInputDesc 	 Features info (type[,s:e:ds:de:dds:dde,dim,c:r:wSize:method]) = audio2sphinx,1:3:2:0:0:0,13,1:1:0:0
info[ParameterFeature-Input] 	 	 type [sphinx,spro4,htk,gztxt,audio2sphinx] = audio2sphinx (4)
info[ParameterFeature-Input] 	 	 static [0=not present,1=present ,3=to be removed] = 1
info[ParameterFeature-Input] 	 	 energy [0,1,3] = 3
info[ParameterFeature-Input] 	 	 delta [0,1,2=computed on the fly,3] = 2
info[ParameterFeature-Input] 	 	 delta energy [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta delta [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 delta delta energy [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 file dim = 13
info[ParameterFeature-Input] 	 	 normalization, center [0,1] = 1
info[ParameterFeature-Input] 	 	 normalization, reduce [0,1] = 1
info[ParameterFeature-Input] 	 	 normalization, window size = 0
info[ParameterFeature-Input] 	 	 normalization, method [0 (segment), 1 (cluster), 2 (sliding), 3 (warping)] =0
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.spl.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterSegmentationFile-Output] 	 --sOutputMask 	 segmentation mask = ./build/diarization/test1/show.g.seg
info[ParameterSegmentationFile-Output ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sOutputFormat 	 segmentation format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
info[ParameterModelSet] 	 --tInputMask 	 model mask = models/gender.gmms
info[ParameterTopGaussian] 	 --sTop 	 use top Gaussians (ntop,modelMask) = -1,
info[ParameterTopGaussian] 		 nb = -1
info[ParameterTopGaussian] 		 model = 
info[ParameterScore] 	 --sGender = true
info[ParameterScore] 	 --sByCluster = true
info[ParameterScore] 	 --sBySegment = false
info[ParameterScore] 	 --sSetLabel [none, add, remplace] = none
info[ParameterScore] 	 --sTNorm = false
info[ParameterSegmentation] 	 --sThr 	 seg threshold = -2.147483648E9
info[info] 	 ------------------------------------------------------ 
[FeatureSet] read : compute data test1 // % mem free=0.01328334148476112 used=12 max=910
***none=none
***none=add
***none=remplace
show = show
info[info] 	 ====================================================== 
info[program] 	 name = MClust
info[info] 	 ------------------------------------------------------ 
info[show] 	 [options] show
info[show] 	 show = show
info[ParameterFeature-Input] 	 --fInputMask 	 Features input mask = build/audio/base/test1.wav
info[ParameterFeature-Input] 	 --fInputDesc 	 Features info (type[,s:e:ds:de:dds:dde,dim,c:r:wSize:method]) = audio2sphinx,1:3:2:0:0:0,13,1:1:300:4
info[ParameterFeature-Input] 	 	 type [sphinx,spro4,htk,gztxt,audio2sphinx] = audio2sphinx (4)
info[ParameterFeature-Input] 	 	 static [0=not present,1=present ,3=to be removed] = 1
info[ParameterFeature-Input] 	 	 energy [0,1,3] = 3
info[ParameterFeature-Input] 	 	 delta [0,1,2=computed on the fly,3] = 2
info[ParameterFeature-Input] 	 	 delta energy [0,1,2=computed on the fly,3] = 0
info[ParameterFeature-Input] 	 	 delta delta [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 delta delta energy [0,1,2,3] = 0
info[ParameterFeature-Input] 	 	 file dim = 13
info[ParameterFeature-Input] 	 	 normalization, center [0,1] = 1
info[ParameterFeature-Input] 	 	 normalization, reduce [0,1] = 1
info[ParameterFeature-Input] 	 	 normalization, window size = 300
info[ParameterFeature-Input] 	 	 normalization, method [0 (segment), 1 (cluster), 2 (sliding), 3 (warping)] =4
info[ParameterFeature-Input] 	 --fInputMemoryOccupationRate 	 memory occupation rate of the feature in the java virtual machine = 0.8
info[info] 	 ------------------------------------------------------ 
info[ParameterSegmentationFile-Input] 	 --sInputMask 	 segmentation mask = ./build/diarization/test1/show.g.seg
info[ParameterSegmentationFile-Input ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sInputFormat 	 segmentation format = seg,ISO-8859-1
info[ParameterSegmentationFile-Output] 	 --sOutputMask 	 segmentation mask = ./build/diarization/test1/show.seg
info[ParameterSegmentationFile-Output ([seg,bck,ctl,saus.seg,seg.xml,media.xml],[ISO-8859-1,UTF8])] 	 --sOutputFormat 	 segmentation format = seg,ISO-8859-1
info[info] 	 ------------------------------------------------------ 
info[ParameterSystem] 	 --saveAllStep = false
info[info] 	 ------------------------------------------------------ 
info[clust] 	 --cMethod 	 clustering method [l, r, h, c, ce, kl2, h2, gd, gdgmm, icr, t, glr] = ce(3)
info[ParameterClustering] 	 --cThr 	 clustering threshold = 1.7
info[ParameterClustering] 	 --cMaximumMerge 	 maximum number of merges = 2147483647
info[ParameterClustering] 	 --cMinimumOfCluster 	 minum number of speakers = 0
info[ParameterClustering] 	 --cMinimumLength 	 minum length of cluster = 2147483647
info[info] 	 ------------------------------------------------------ 
info[ParameterModelSet] 	 --tOutputMask 	 model mask = ./build/diarization/test1/show.c.gmm
info[info] 	 ------------------------------------------------------ 
info[ParameterModelSet] 	 --tInputMask 	 model mask = models/ubm.gmm
info[ParameterTopGaussian] 	 --sTop 	 use top Gaussians (ntop,modelMask) = 5,models/ubm.gmm
info[ParameterTopGaussian] 		 nb = 5
info[ParameterTopGaussian] 		 model = models/ubm.gmm
info[ParameterEM] 	 --emCtrl 	 EM control (minIt,maxIt,minGain) = 1,5,0.01 (1,5,0.01)
info[ParameterEM] 	 	 minIt = 1
info[ParameterEM] 	 	 maxIt = 5
info[ParameterEM] 	 	 minGain = 0.01
info[ParameterMAP] 	 --mapCtrl 	 MAP control (method,prior,w:m:c) = std,15,0:1:0
info[ParameterMAP] 	 	 Method = 0
info[ParameterMAP] 	 	 prior = 15.0
info[ParameterMAP] 	 	 weight adaptation [0,1] = false
info[ParameterMAP] 	 	 mean adaptation [0,1] = true
info[ParameterMAP] 	 	 covariance adaptation [0,1] = false
info[ParameterVarianceControl] 	 --varCtrl 	 covariance control (floor[,ceil]) = 0.0,10.0
info[ParameterVarianceControl] 	 	 flooring = 0.0
info[ParameterVarianceControl] 	 	 ceilling = 10.0
[FeatureSet] read : compute data test1 // % mem free=0.005343517322320326 used=4 max=910
echo "diarization complete"
diarization complete
date +%s%N | cut -b1-13
1449670837984
touch build/diarization/test1/show.h.seg
rm -rf build/audio/segmented/test1
mkdir -p build/audio/segmented/test1
cat build/diarization/test1/show.h.seg | cut -f 3,4,8 -d " " | \
	while read LINE ; do \
		start=`echo $LINE | cut -f 1 -d " " | perl -npe '$_=$_/100.0'`; \
		len=`echo $LINE | cut -f 2 -d " " | perl -npe '$_=$_/100.0'`; \
		sp_id=`echo $LINE | cut -f 3 -d " "`; \
		timeformatted=`echo "$start $len" | perl -ne '@t=split(); $start=$t[0]; $len=$t[1]; $end=$start+$len; printf("%08.3f-%08.3f\n", $start,$end);'` ; \
		sox build/audio/base/test1.wav --norm build/audio/segmented/test1/test1_${timeformatted}_${sp_id}.wav trim $start $len ; \
	done
mkdir -p `dirname build/trans/test1/wav.scp`
/bin/ls build/audio/segmented/test1/*.wav  | \
		perl -npe 'chomp; $orig=$_; s/.*\/(.*)_(\d+\.\d+-\d+\.\d+)_(S\d+)\.wav/\1-\3---\2/; $_=$_ .  " $orig\n";' | LC_ALL=C sort > build/trans/test1/wav.scp
cat build/trans/test1/wav.scp | perl -npe 's/\s+.*//; s/((.*)---.*)/\1 \2/' > build/trans/test1/utt2spk
utils/utt2spk_to_spk2utt.pl build/trans/test1/utt2spk > build/trans/test1/spk2utt
rm -rf build/trans/test1/fbank
steps/make_fbank.sh --fbank-config conf/fbank.conf --cmd "$train_cmd" --nj 1 \
		build/trans/test1 build/trans/test1/exp/make_fbank build/trans/test1/fbank || exit 1
steps/make_fbank.sh --fbank-config conf/fbank.conf --cmd run.pl --nj 1 build/trans/test1 build/trans/test1/exp/make_fbank build/trans/test1/fbank
utils/validate_data_dir.sh: WARNING: you have only one speaker.  This probably a bad idea.
   Search for the word 'bold' in http://kaldi.sourceforge.net/data_prep.html
   for more information.
utils/validate_data_dir.sh: Successfully validated data-directory build/trans/test1
steps/make_fbank.sh: [info]: no segments file exists: assuming wav.scp indexed by utterance.
Succeeded creating filterbank features for test1
steps/compute_cmvn_stats.sh build/trans/test1 build/trans/test1/exp/make_fbank build/trans/test1/fbank || exit 1
steps/compute_cmvn_stats.sh build/trans/test1 build/trans/test1/exp/make_fbank build/trans/test1/fbank
Succeeded creating CMVN stats for test1
echo "feature generation done"
feature generation done
date +%s%N | cut -b1-13
1449670838991
rm -rf build/trans/test1/eesen && mkdir -p build/trans/test1/eesen
(cd build/trans/test1/eesen; for f in /home/vagrant/eesen-master/asr_egs/tedlium/v1/exp/train_phn_l5_c320/*; do ln -s $f; done)
ln -s /home/vagrant/eesen-master/asr_egs/tedlium/v1/data/lang_phn_test `pwd`/build/trans/test1/eesen/graph
steps/decode_ctc_lat.sh --cmd "$decode_cmd" --nj 1 --beam 17.0 \
	--lattice_beam 8.0 --max-active 5000 --skip_scoring true \
	--acwt 0.6 /home/vagrant/eesen-master/asr_egs/tedlium/v1/data/lang_phn_test build/trans/test1 `dirname build/trans/test1/eesen/decode/log` || exit 1;
steps/decode_ctc_lat.sh --cmd run.pl --nj 1 --beam 17.0 --lattice_beam 8.0 --max-active 5000 --skip_scoring true --acwt 0.6 /home/vagrant/eesen-master/asr_egs/tedlium/v1/data/lang_phn_test build/trans/test1 build/trans/test1/eesen/decode
steps/decode_ctc_lat.sh: feature: norm_vars(true) add_deltas(true)
local/get_ctm.sh `dirname build/trans/test1/eesen` build/trans/test1/eesen/graph build/trans/test1/eesen/decode
local/get_ctm.sh build/trans/test1 build/trans/test1/eesen/graph build/trans/test1/eesen/decode
touch -m build/trans/test1/eesen/decode/.ctm
cat build/trans/test1/eesen/decode/score_8/`dirname test1/eesen`.ctm | perl -npe 's/(.*)-(S\d+)---(\S+)/\1_\3_\2/' > build/trans/test1/eesen.segmented.splitw2.ctm
cat build/trans/test1/eesen.segmented.splitw2.ctm > build/trans/test1/eesen.segmented.with-compounds.ctm
cat build/trans/test1/eesen.segmented.with-compounds.ctm > build/trans/test1/eesen.segmented.ctm
cat build/trans/test1/eesen.segmented.ctm | python scripts/segmented-ctm-to-hyp.py > build/trans/test1/eesen.hyp
cat build/trans/test1/eesen.hyp  | perl -npe 'use locale; s/ \(\S+\)/\./; $_= ucfirst();' > build/trans/test1/eesen.txt
mkdir -p `dirname build/output/test1.txt`
cp build/trans/test1/eesen.txt build/output/test1.txt
cat build/trans/test1/eesen.hyp | python scripts/hyp2trs.py > build/trans/test1/eesen.trs
mkdir -p `dirname build/output/test1.trs`
cp build/trans/test1/eesen.trs build/output/test1.trs
echo "final output done"
final output done
date +%s%N | cut -b1-13
1449670947168
cat build/trans/test1/eesen.segmented.ctm | python scripts/unsegment-ctm.py | LC_ALL=C sort -k 1,1 -k 3,3n -k 4,4n > build/trans/test1/eesen.ctm
mkdir -p `dirname build/output/test1.ctm`
cp build/trans/test1/eesen.ctm build/output/test1.ctm
cat build/trans/test1/eesen.hyp | python scripts/hyp2sbv.py > build/trans/test1/eesen.sbv
mkdir -p `dirname build/output/test1.sbv`
cp build/trans/test1/eesen.sbv build/output/test1.sbv
cat build/output/test1.ctm | python scripts/ctm2srt.py > build/output/test1.srt
rm -rf build/audio/base/test1.wav build/audio/segmented/test1 build/diarization/test1 build/trans/test1
Finished transcribing, result is in files ./build/output/test1.{txt,trs,ctm,sbv,srt}
```
