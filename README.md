# eesen-transcriber
uses [EESEN](https://github.com/yajiemiao/eesen) DNN-based decoding, trained on
the [TED-LIUM](http://www-lium.univ-lemans.fr/en/content/ted-lium-corpus) dataset and the Cantab-TEDLIUM [language model](http://cantabresearch.com/cantab-TEDLIUM.tar) from
Cantab Research. In addition it includes an adapted version of
Tanel Alumae's [Kaldi Offline Transcriber](https://github.com/alumae/kaldi-offline-transcriber) which accepts most any audio/
video format and produces transcriptions as subtitles, plain text, and more.
As a side effect, [LIUM speaker diarization](http://www-lium.univ-lemans.fr/diarization/doku.php/welcome) is performed.
Lastly, provides a video browser in a web page such that transcriptions appear as video subtitles, and are searchable by keyword across videos.

An earlier version of this VM (without video browser) also exists as an Amazon Machine Image (AMI) [here](https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#LaunchInstanceWizard:ami=ami-1b637e7a). and [here](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:ami=ami-5a210a30) 

If you have gotten this far, it is assumed you have thes files checked out from GitHub into this working directory:

    conf/
    scripts/
    www/
    Makefile.options
    README-quickstart.md
    README-transcriber
    README.md
    Vagrantfile
    videobrowser.tgz

Assuming you have installed [Vagrant](http://vagrantup.com), to get started, do:

    vagrant up

Lots of output will follow, including a lengthy download and install. When it finishes, you should be able to try out the transcriber with a test audio file:

    vagrant ssh -c "cd tools/eesen-offline-transcriber; ./vids2web.sh /vagrant/test2.mp3"

For the video browser to work, it is assumed you have already [created a host-only network with VirtualBox](https://www.virtualbox.org/manual/ch06.html#network_hostonly). This will get picked up with an IP address specified in the Vagrantfile, viewable at URL `http://192.168.33.11` from the host computer.

You can also log directly into the VM with `vagrant ssh` and look around. For example, change directories to /home/vagrant/tools/eesen-offline-transcriber to find README instructions there. (A copy of which is in README-transcriber) Note that the size of the VM is controlled by the Vagrantfile, and is rather small in RAM:
    vb.memory = 4096 # 4 GB
This supports transcribing of small audio/video files. But for larger audio/video files (around an hour in length) you may need to crank this to 8-12 GB, which means your host computer may need as much as 16 GB.

## Language Remodeling
This VM now supports language model building according to instructions at SpeechKitchen.org: [Kaldi Language Model Building](http://speechkitchen.org/kaldi-language-model-building/)

## Error Analysis
If you ran the full TEDLIUM EESEN experiment, it is possible to use SpeechKitchen.org's [Error Analysis Page](http://speechkitchen.org/error-analysis-instructions-for-tedlium-vm/) to produce and view graphs and charts that let you play with the scoring data and visualize it in different ways.
