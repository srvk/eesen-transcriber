# eesen-transcriber

This Virtual Machine implements a system that can transcribe and/ or sub-title pretty much any audio or video file. It will separate speech from non-speech, identify individual speakers, and then convert speech to text. It supports various input and output formats. If you give it a full corpus of files to transcribe, it allows you to browse and search the results.

If the results are not good, it is easy to update and change several parts of the system, for example the segmentation parameters (not enough words in the output? too much noise?) or the language model (crappy output)?

Internally, the system
uses [EESEN](https://github.com/yajiemiao/eesen) RNN-based decoding, trained on
the [TED-LIUM](http://www-lium.univ-lemans.fr/en/content/ted-lium-corpus) dataset and the Cantab-TEDLIUM [language model](http://cantabresearch.com/cantab-TEDLIUM.tar) from
Cantab Research. In addition it includes an adapted version of
Tanel Alumae's [Kaldi Offline Transcriber](https://github.com/alumae/kaldi-offline-transcriber) which accepts most any audio/
video format and produces transcriptions as subtitles, plain text, and more.
Within transcriber, [LIUM speaker diarization](http://www-lium.univ-lemans.fr/diarization/doku.php/welcome) is performed.
Lastly, the VM provides a video browser in a web page such that transcriptions appear as video subtitles, and are searchable by keyword across videos.

An earlier version of this VM (without video browser) also exists as an Amazon Machine Image (AMI) [here](https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#LaunchInstanceWizard:ami=ami-1b637e7a). and [here](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:ami=ami-5a210a30) 

If you have gotten this far, it is assumed you have these files checked out from GitHub into this working directory:

    conf/
    scripts/
    www/
    Makefile.options
    README-quickstart.md
    README-transcriber
    README.md
    Vagrantfile
    test2.mp3
    videobrowser.tgz

Assuming you have installed [Vagrant](http://vagrantup.com), check out this repository, open a shell in the eesen-transcriber folder and type:

    vagrant up

Lots of output will follow, including a lengthy download and install. When it finishes, you should be able to try out the transcriber with a test audio file (note that the file `./test2.mp3` is visible from inside the VM as `/vagrant/test2.mp3`):

    vagrant ssh -c "cd tools/eesen-offline-transcriber; ./vids2web.sh /vagrant/test2.mp3"

For the video browser to work, it is assumed you have already [created a host-only network with VirtualBox](https://www.virtualbox.org/manual/ch06.html#network_hostonly). This will get picked up with an IP address specified in the Vagrantfile, viewable at URL `http://192.168.33.11` from the host computer.

You can also log directly into the VM with `vagrant ssh` and look around. For example, change directories to /home/vagrant/tools/eesen-offline-transcriber to find README instructions there. (A copy of which is in README-transcriber) Note that the size of the VM is controlled by the Vagrantfile, and is rather small in RAM:

    vb.memory = 4096 # 4 GB

This supports transcribing of small audio/video files. But for larger audio/video files (around an hour in length) you may need to crank this to 8-12 GB, which means your host computer may need as much as 16 GB.

## Cleaning Up

Sometimes it helps to know how to shut down, as well as install and run a system. Two use cases come to mind.
  1. Shutting down the virtual machine

    vagrant halt

  2. Cleaning files associated with the embedded VirtualBox virtual machine (i.e. wipe everything)

    vagrant destroy

## Language Remodeling

This VM now supports language model building according to instructions at SpeechKitchen.org: [Kaldi Language Model Building](http://speechkitchen.org/kaldi-language-model-building/)

## Error Analysis

If you ran the full TEDLIUM EESEN experiment, it is possible to use SpeechKitchen.org's [Error Analysis Page](http://speechkitchen.org/error-analysis-instructions-for-tedlium-vm/) to produce and view graphs and charts that let you play with the scoring data and visualize it in different ways.

## Tips & Tricks

You might want to install useful vagrant plugins such as [vagrant-aws](https://github.com/mitchellh/vagrant-aws) or [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) using

    vagrant plugin install vagrant-vbguest

