# eesen-transcriber
uses [EESEN](https://github.com/yajiemiao/eesen) DNN-based decoding, trained on
the [TED-LIUM](http://www-lium.univ-lemans.fr/en/content/ted-lium-corpus) dataset and the Cantab-TEDLIUM [language model](http://cantabresearch.com/cantab-TEDLIUM.tar) from
Cantab Research. In addition it includes an adapted version of
Tanel Alumae's [Kaldi Offline Transcriber](https://github.com/alumae/kaldi-offline-transcriber) which accepts most any audio/
video format and produces transcriptions as subtitles, plain text, and more.
As a side effect, [LIUM speaker diarization](http://www-lium.univ-lemans.fr/diarization/doku.php/welcome) is performed

Right now the VM exists as an Amazon Machine Image (AMI) [here](https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#LaunchInstanceWizard:ami=ami-1020c723).

If you have gotten this far, it is assumed you have thes files checked out into this working directory:

  README.md
  Vagrantfile

Assuming you have installed [Vagrant](http://vagrantup.com), to get started, do:

    vagrant up

Lots of output will follow, including a lengthy download and install. When it finishes, you will be able to log into the IVW machine with:

    vagrant ssh
