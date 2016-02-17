# eesen-transcriber
uses [EESEN](https://github.com/yajiemiao/eesen) DNN-based decoding, trained on
the [TED-LIUM](http://www-lium.univ-lemans.fr/en/content/ted-lium-corpus) dataset and the Cantab-TEDLIUM [language model](http://cantabresearch.com/cantab-TEDLIUM.tar) from
Cantab Research. In addition it includes an adapted version of
Tanel Alumae's [Kaldi Offline Transcriber](https://github.com/alumae/kaldi-offline-transcriber) which accepts most any audio/
video format and produces transcriptions as subtitles, plain text, and more.
As a side effect, [LIUM speaker diarization](http://www-lium.univ-lemans.fr/diarization/doku.php/welcome) is performed

The VM also exists as an Amazon Machine Image (AMI) [here](https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#LaunchInstanceWizard:ami=ami-1b637e7a). and [here](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:ami=ami-5a210a30) 

If you have gotten this far, it is assumed you have thes files checked out from GitHub into this working directory:

    README.md
    README-transcriber
    Vagrantfile
    reconf-slurm.sh
    slurm.conf
    slurm.sv.conf
    supervisor.conf

Assuming you have installed [Vagrant](http://vagrantup.com), to get started, do:

    vagrant up

Lots of output will follow, including a lengthy download and install. When it finishes, you will be able to log into the VM with:

    vagrant ssh

Once logged in, change directories to /home/vagrant/tools/eesen-offline-transcriber to find README instructions there. (A copy of which is in README-transcriber) Note that the size of the VM is controlled by the Vagrantfile, and is rather small in RAM:
    vb.memory = 4096 # 4 GB
This supports transcribing of small audio/video files. But for larger audio/video files (around an hour in length) you may need to crank this to 8-12 GB, which means your host computer may need as much as 16 GB.

## Language Remodeling
This VM now supports language model building according to instructions at SpeechKitchen.org: [Kaldi Language Model Building](http://speechkitchen.org/kaldi-language-model-building/)

## Error Analysis
If you ran the full TEDLIUM EESEN experiment, it is possible to use SpeechKitchen.org's [Error Analysis Page](http://speechkitchen.org/error-analysis-instructions-for-tedlium-vm/) to produce and view graphs and charts that let you play with the scoring data and visualize it in different ways.
