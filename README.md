# eesen-transcriber
uses [EESEN](https://github.com/yajiemiao/eesen) DNN-based decoding, trained on
the [TED-LIUM](http://www-lium.univ-lemans.fr/en/content/ted-lium-corpus) dataset and the Cantab-TEDLIUM [language model](http://cantabresearch.com/cantab-TEDLIUM.tar) from
Cantab Research. In addition it includes an adapted version of
Tanel Alumae's [Kaldi Offline Transcriber](https://github.com/alumae/kaldi-offline-transcriber) which accepts most any audio/
video format and produces transcriptions as subtitles, plain text, and more.
As a side effect, [LIUM speaker diarization](http://www-lium.univ-lemans.fr/diarization/doku.php/welcome) is performed

The VM also exists as an Amazon Machine Image (AMI) [here](https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#LaunchInstanceWizard:ami=ami-1020c723).

If you have gotten this far, it is assumed you have thes files checked out into this working directory:

  README.md
  Vagrantfile

Assuming you have installed [Vagrant](http://vagrantup.com), to get started, do:

    vagrant up

Lots of output will follow, including a lengthy download and install. When it finishes, you will be able to log into the IVW machine with:

    vagrant ssh

Once logged in, change directories to /home/vagrant/tools/eesen-offline-transcriber to find README instructions there. Note that the size of the VM is controlled by the Vagrantfile, and is rather small in RAM:
    vb.memory = 4096 # 4 GB
This supports transcribing of small audio/video files. But for larger audio/video files (around an hour in length) you may need to crank this to more like 12 GB, which means your host computer will need around 16 GB.

