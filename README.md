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

This VM runs either locally with Vagrant/VirtualBox or remotely as an Amazon Machine Image on AWS.

### [Installation Guide](https://github.com/srvk/eesen-transcriber/blob/master/INSTALL.md)

### [User Guide](https://github.com/srvk/eesen-transcriber/blob/master/USERGUIDE.md)

## License

The Eesen software has been released under an Apache 2.0 license, the LIUM speaker diarization is GPL, but LIUM offers to work with you if that is too strict [LIUM license](http://www-lium.univ-lemans.fr/diarization/doku.php/licence). The Eesen transcriber uses and expands the Kaldi offline transcriber, which has been released under a very liberal license at [Kaldi Offline Transcriber license](https://github.com/alumae/kaldi-offline-transcriber/blob/master/LICENSE). The transcriber uses various other tools such as Atlas, Sox, FFMPEG that are being released as Ubuntu packages. Some of these have their own licenses, if one of them poses a problem, it would not be too hard to remove them specifically.
