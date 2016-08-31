## Installation 
### Installing with Vagrant

Assuming you have installed [Vagrant](http://vagrantup.com), from the shell in the `eesen-transcriber` folder type:

    vagrant up

[Lots of output](https://github.com/srvk/eesen-transcriber/wiki/expected_output) will follow, as things download and install. If you get warnings about retrying, please be patient as this can take up to 5 minutes. You should then be able to try out the transcriber with the supplied test audio file: 

    vagrant ssh -c "vids2web.sh /vagrant/test2.mp3"

If all goes well, you can check output in the file `build/output/test2.txt` which should contain this:
```
Things will change in ways that are fragile environment simply can't support.
And that leads starvation that leads to uncertainty it leads.
Yes unrest so that the climate change is will be terrible for them.
```
You can also see results in video form at the URL `http://192.168.56.101`.
This is an IP address created by VirtualBox host-only networking, viewable on your host computer,
being served out of the virtual machine.

The syntax `vagrant ssh -c ...` is a shorthand way of running commands in the virtual machine (guest) from the host computer. It accomplishes the same thing as several steps:

  * vagrant ssh (log into the virtual machine with automatic username/password pair vagrant/vagrant)
  * cd tools/eesen-offline-transcriber (this is on the search path, the home folder for transcribing)
  * ./vids2web /vagrant/test2.mp3 (transcribe audios/videos and update the web results page)
You might notice that once logged into the VM, all the files that were in your host computer working directory 
are visible in the folder /vagrant. This is a convenient way to store many large input and output files on the host
without running out of space in the guest VM. You will see several more scripts from the
[transcriber core system](https://github.com/srvk/srvk-eesen-offline-transcriber/blob/master/README.md) which
support different transcription methods.

### Installing with AWS

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

### <a name="OVA"></a> Installing with VirtualBox (stand-alone OVA)
 * It's assumed you have VirtualBox installed, including the VirtualBox extensions. Also use   `File->Preferences->Network->Host-only Networks`
    to create or make sure there exists a new host-only network (default 'vboxnet0')
 * unzip the working directory archive `eesen-transcriber.zip` (files the VM needs to find in /vagrant)
   This will create a folder on your host computer `eesen-transcriber`
  * Import the OVA using VirtualBox
    - If your system has lower RAM it is possible to still run the system
     by editing the Settings of the VM in VirtualBox. It can run with as little as 2GB,
     so please feel free to lower from the 8GB default
  * Set the shared folder to be the path of said working directory:
        - in Oracle VM VirtualBox Manager, click on the VM
        - click Settings
        - click Shared Folders
        - edit the shared folder
        - Where it says 'Folder Path' replace `/usr1/er1k/boxes/EESEN-Thumbdrive/eesen-transcriber` with
        the full path to the working directory (it will end with `eesen-transcriber`) - you can use the drop-down
        menu to navigate to it if you prefer not typing pathnames
        - make sure the "Auto-mount" checkbox is checked
        - make sure the 'Folder Name' is `vagrant`
  * Start up the VM with VirtualBox
  * log in as vagrant/vagrant
  * cd bin/
  * from here you can run things like:
```
  ./speech2text.sh /vagrant/test2.mp3
  ./vids2web.sh /vagrant/test2.mp3
```
  and then view results in a web browser at `http://localhost/192.168.56.101`
  Note that the VM runs in a terminal-only window (no desktop interface) so pay no mind to the
  warnings about 'mouse pointer integration'. If you accidentally click on the window and are
  worried you lost your mouse pointer, try pressing the right Ctrl key to get it back.
  
