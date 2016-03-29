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

This VM runs either locally with VirtualBox or remotely as an Amazon Machine Image on AWS.

If you have gotten this far, it is assumed you have , check out this repository (`git clone http://github.com/srvk/eesen-transcriber`),
and have opened a shell the `eesen-transcriber` working directory:

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

#### Running with VirtualBox Provider

Assuming you have installed [Vagrant](http://vagrantup.com), from a shell in the eesen-transcriber folder type:

    vagrant up

[Lots of output](https://github.com/srvk/eesen-transcriber/wiki/TranscribeOutput) will follow, as things download and install. When it finishes, make note of the URL where you can view results. You should then be able to try out the transcriber with the supplied test audio file (note that the file in the working directory `test2.mp3` is visible from inside the VM as `/vagrant/test2.mp3`):

    vagrant ssh -c "vids2web.sh /vagrant/test2.mp3"

For the video browser to work, it is assumed you have already [created a host-only network with VirtualBox](https://www.virtualbox.org/manual/ch06.html#network_hostonly). This will get picked up with an IP address specified in the Vagrantfile, viewable at URL `http://192.168.33.11` from the host computer.

#### Running with AWS Provider

Before provisioning the VM, you need to install the two Vagrant plugins:

    vagrant plugin install vagrant-aws
    vagrant plugin install vagrant-sshfs
    
You will also need to fill in details from your [Amazon Web Services] account by editing the file `env.sh` and then executing it as

    . env.sh
    
Then you can run `vagrant up` as above, and when prompted, supply your login password to the machine on which you are currently running. This gives it to the VM so that it can use sshfs to mount your local filesystem as a Vagrant synced filesystem visible to the VM as `/vagrant`. Inputs as well as results reside here, on your host.

#### Customizing the VM

You can also log directly into the VM with `vagrant ssh` and look around. For example, change directories to /home/vagrant/tools/eesen-offline-transcriber to find README instructions there. (A copy of which is in README-transcriber) Note that the size of the VM is controlled by the Vagrantfile, and asks for 8GB RAM:

    vbox.memory = 8192

This supports transcribing of small audio/video files. But for larger audio/video files (around an hour in length) you may need to crank this to 8-12 GB, which means your host computer may need as much as 16 GB.

## Cleaning Up

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
