# eesen-transcriber

This Virtual Machine implements a system that can transcribe and/ or sub-title pretty much any audio or video file. It will separate speech from non-speech, identify individual speakers, and then convert speech to text. It supports various input and output formats. If you give it a full corpus of files to transcribe, it allows you to browse and search the results.

If the results are not good, it is easy to update and change several parts of the system, for example the segmentation parameters (not enough words in the output? too much noise?) or the language model (crappy output)?

Internally, the system
uses [EESEN](https://github.com/yajiemiao/eesen) RNN-based decoding, trained on
the [TED-LIUM](http://www-lium.univ-lemans.fr/en/content/ted-lium-corpus) dataset and the Cantab-TEDLIUM [language model](http://cantabresearch.com/cantab-TEDLIUM.tar.bz2) from
Cantab Research. In addition it includes an adapted version of
Tanel Alumae's [Kaldi Offline Transcriber](https://github.com/alumae/kaldi-offline-transcriber) which accepts most any audio/
video format and produces transcriptions as subtitles, plain text, and more.
Within transcriber, [LIUM speaker diarization](http://www-lium.univ-lemans.fr/diarization/doku.php/welcome) is performed.
Lastly, the VM provides a video browser in a web page such that transcriptions appear as video subtitles, and are searchable by keyword across videos.

This VM runs either locally with VirtualBox or remotely as an Amazon Machine Image on AWS.

If you have gotten this far, it is assumed you have cloned this repository (`git clone http://github.com/srvk/eesen-transcriber`), and have opened a shell in the `eesen-transcriber` working directory:

#### Running with VirtualBox Provider

Assuming you have installed [Vagrant](http://vagrantup.com), from the shell in the `eesen-transcriber` folder type:

    vagrant up

[Lots of output](https://github.com/srvk/eesen-transcriber/wiki/TranscribeOutput) will follow, as things download and install. If you get warnings about retrying, please be patient as this can take up to 5 minutes. You should then be able to try out the transcriber with the supplied test audio file: 

    vagrant ssh -c "vids2web.sh /vagrant/test2.mp3"

If all goes well you can see results at the URL `http://192.168.56.101`. This is a shorthand way of running commands in the virtual machine (guest) from the host computer. It accomplishes the same thing as several steps:

  * vagrant ssh (log into the virtual machine with automatic username/password pair vagrant/vagrant)
  * cd tools/eesen-offline-transcriber (this is on the search path, the home folder for transcribing)
  * ./vids2web /vagrant/test2.mp3 (transcribe audios/videos and update the web results page)
You might notice that once logged into the VM, all the files that were in your host computer working directory are visible in the folder /vagrant. This is a convenient way to store many large input and output files on the host without running out of space in the guest VM. You will see several more scripts from the [transcriber core system](https://github.com/srvk/srvk-eesen-offline-transcriber/blob/master/README.md) which support different transcription methods.

#### Running with AWS Provider

You will need to have already an [Amazon Web Services account](http://docs.aws.amazon.com/AmazonSimpleDB/latest/DeveloperGuide/AboutAWSAccounts.html). You will need to know several details about your account:

  * The name and path of an [AWS public key pair](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) used for secure login
  * Your [AWS Key and Secret Key](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSGettingStartedGuide/AWSCredentials.html)
  * An [AWS Security Group](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/authorizing-access-to-an-instance.html) configured for both SSH and HTTP

Before provisioning the VM, you need to install the two Vagrant plugins:

    vagrant plugin install vagrant-aws
    vagrant plugin install vagrant-sshfs
    
[Info about sshfs plugin](https://github.com/dustymabe/vagrant-sshfs) You will also need to fill in details from your Amazon Web Services account by editing the file `aws.sh` and then executing it as

    . aws.sh
    
You also need to enable SSH sharing of local files. On Mac OSX:

    sudo systemsetup -setremotelogin on
    
on Ubuntu Linux:

    sudo apt-get install ssh

Then you can run `vagrant up` as above, and when prompted, supply the password for your current login account. This gives it to the VM so that it can use sshfs to mount the working directory of your local filesystem as a Vagrant synced filesystem visible from the VM as `/vagrant`. This allows inputs as well as results to reside on your host. Make note of the URL given at the finish of `vagrant up` - if you transcribe the test audio as above,
(`vagrant ssh -c "vids2web.sh /vagrant/test2.mp3"`) you should be able to see results at this URL.

#### Customizing the VM

You can also log directly into the VM with `vagrant ssh` and look around. For example, change directories to `/home/vagrant/tools/eesen-offline-transcriber` to find README instructions there. You can initiate transcription from here with `speech2text.sh` and output will appear in `build/output`. You can run scripts that queue several files for transcription with `batch.sh`

Note that the size of the VM is controlled by the Vagrantfile, and asks for 2 CPUs and 8GB RAM:

    vbox.cpus = 2
    vbox.memory = 8192

This supports transcribing of audio/video files with small utterance lengths*. But for long utterances you may need to crank this to 8-12 GB, which means your host computer may need as much as 16 GB. Either you will need more RAM on the host you run locally using VirtualBox, or you will need to specify a more powerful `aws.instance.type` in Vagrantfile. [AWS Instance Types](https://aws.amazon.com/ec2/instance-types/) Similarly, if you want to transcribe several things in parallel, you'll want to crank up the number pf `Procs` at the end of `/etc/slurm-llnl/slurm.conf` as well as increasing the RAM allocated to the VM. An example, setting CPUs to 8, RAM to 30000, and Procs to 7 seems to work pretty well on a 32 GB 8 core host. 

cd /home/vagrant/tools/eesen-offline-transcriber
Initiate transcription of the test file test2.mp3 with ./speech2text.sh /vagrant/test2.mp3
Output should appear in build/output/test2.*

#### 8khz Models

We cannot give out the models trained on non-open-source data, but if you are able to obtain them, you can run the system in 8k mode, by changing the commented out lines in `Makefile.options`
```
# 8k models from switchboard
ACWT=0.6
GRAPH_DIR?=$(EESEN_ROOT)/asr_egs/swbd/v1-pitch/data/lang_phn_sw1_fsh_tgpr
#GRAPH_DIR?=$(EESEN_ROOT)/asr_egs/swbd/v1-pitch/data/lang_phn_sw1_tg
MODEL_DIR?=$(EESEN_ROOT)/asr_egs/swbd/v1-pitch/exp/train_phn_l5_c320
sample_rate=8k
fbank=make_fbank_pitch

# 16k models from tedlium
#ACWT=0.7
#GRAPH_DIR?=$(EESEN_ROOT)/asr_egs/tedlium/v1/data/lang_phn
#MODEL_DIR?=$(EESEN_ROOT)/asr_egs/tedlium/v1/exp/train_phn_l5_c320
#sample_rate=16k
#fbank=make_fbank
```

#### Watched Folder Automatic Transcription
The VM watches the shared host folder `transcribe_me`. Any files placed in this folder get queued as transcription jobs, and results appear in the same folder with extension `.ctm`. Results also automatically populate the video browser web page. Log files appear in `log/` by job number. If you want to disable this behavior, comment out the line in `Vagrantfile` that runs `watch.sh` before running `vagrant up`, or kill the watch.sh process in the VM.

##### *Segmentation and Utterance Lengths

Have a look in `Makefile` at the definition of `SEGMENTS`. 
```
# Some audio produces no results (can't be segmented), or transcribes better
# when segmented differently
# Changing SEGMENTS to one of these values gives more flexibilty;
# (see http://www-lium.univ-lemans.fr/diarization/doku.php/quick_start)
#
#    show.seg       : default - final segmentation with NCLR/CE clustering
#    show.i.seg     : initial segmentation (entire audio)
#    show.pms.seg   : sPeech/Music/Silence segmentation (don't use)
#    show.s.seg     : GLR based segmentation, make Small segments
#    show.l.seg     : linear clustering (merge only side by side segments)
#    show.h.seg     : hierarchical clustering
#    show.d.seg     : viterbi decoding
#    show.adj.h.seg : boundaries adjusted
#    show.flt1.seg  : filter spk segmentation according to pms segmentation
#    show.flt2.seg  : filter spk segmentation according to pms segmentation
#    show.spl.seg   : segments longer than 20 sec are split
#    show.spl10.seg : segments longer than 10 sec are split
#    show.g.seg     : the gender and the bandwith are detected
SEGMENTS ?= show.seg
```

The default segmentation strategy done by LIUM is `show.seg` but we override it in `Makefile.options` to produce the maximum number of small segments, with the side effect of also assuming there is only one speaker.  (no per-speaker MFCC calculations) If you want to provide your own segmentation, have a look at the `run-segmented.sh` script. Briefly, it involves creating your own `show.seg`.

##### Scoring

Standard NIST sclite scoring is supported for data in .sph and .stm format via the `run-scored.sh` and `run-scored-8k` scripts.

##### Models

Also in `Makefile.options` are paths (in the VM) to the models used for decoding. If you create a new acoustic model (see Language Remodeling below), you will want to change this to point to your new model. A recent update provides models designed for 30ms frame sizes, resulting in much faster decoding.  (3-7x real time, depending on configuration)

### Cleaning Up

Sometimes it helps to know how to shut down, as well as install and run a system. Two use cases come to mind.

Shutting down the virtual machine:

    vagrant halt

Cleaning files associated with the embedded VirtualBox virtual machine (i.e. wipe everything)

    vagrant destroy
    
This will not wipe out any local data or results, only the virtual machine (either VirtualBox locally or the AWS AMI)

### Language Remodeling

This VM now supports language model building according to instructions at SpeechKitchen.org: [Kaldi Language Model Building](http://speechkitchen.org/kaldi-language-model-building/)

### Error Analysis

If you ran the full EESEN TEDLIUM experiment (`~/eesen/asr_egs/tedlium/v1`), it is possible to use SpeechKitchen.org's [Error Analysis Page](http://speechkitchen.org/error-analysis-instructions-for-tedlium-vm/) to produce and view graphs and charts that let you play with the scoring data and visualize it in different ways. (Look near the end for EESEN specifics)

### Tips & Tricks

You might want to install another useful vagrant plugin such as [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) which automatically synchronizes the VirtualBox Guest Additions in the VM

    vagrant plugin install vagrant-vbguest

## License

The Eesen software has been released under an Apache 2.0 license, the LIUM speaker diarization is GPL, but LIUM offers to work with you if that is too strict [LIUM license](http://www-lium.univ-lemans.fr/diarization/doku.php/licence). The Eesen transcriber uses and expands the Kaldi offline transcriber, which has been released under a very liberal license at [Kaldi Offline Transcriber license](https://github.com/alumae/kaldi-offline-transcriber/blob/master/LICENSE). The transcriber uses various other tools such as Atlas, Sox, FFMPEG that are being released as Ubuntu packages. Some of these have their own licenses, if one of them poses a problem, it would not be too hard to remove them specifically.
