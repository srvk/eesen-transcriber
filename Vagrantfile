# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "http://speechkitchen.org/boxes/mario-kaldi.box"
  config.ssh.forward_x11 = true

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #

  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, '--audio', 'pulse', '--audiocontroller', 'ac97'] # choices: hda sb16 ac97
    vb.cpus = 4
    vb.memory = 4096 # 4 GB
end

  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
     sudo apt-get update -y
     sudo apt-get upgrade

sudo apt-get install -y curl incron sox libsox-fmt-all libav-tools openjdk-6-jre 

     # Add user to audio group. Otherwise aplay -l finds no hardware(!)
     sudo usermod -a -G audio vagrant

# Vagrant user owns everything!
ln -fs /home/vagrant/kaldi-trunk /kaldi-trunk
chown vagrant:vagrant /kaldi-trunk

# CUDA
# first need to get nvidia deb (not yet available for Ubuntu > 12.04)           
cd /home/vagrant                                                                
wget -nv http://speechkitchen.org/vms/Data/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
dpkg -i cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
rm cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
apt-get update                                                                  
                                                                                
apt-get remove --purge xserver-xorg-video-nouveau                           
                                                                                
apt-get install -y cuda

# do not do the below.  copy it verbatim or get older version
# using cryptic git commands that make no sense
# install EESEN from github
      cd /home/vagrant
      git clone https://github.com/yajiemiao/eesen.git
      cd eesen
      git reset --hard bb0260eaebacd20d5121fbbbb0342678e3b058e1
      ln -s /kaldi-trunk/tools .
      cd src
      ./configure --use-cuda=yes
      make depend
      make


# get models
cd /home/vagrant/eesen/asr_egs
wget -nv http://speechkitchen.org/vms/Data/tedlium-fbank.tgz
tar zxvf tedlium-fbank.tgz
rm tedlium-fbank.tgz

# get eesen-offline-transcriber
mkdir -p /home/vagrant/tools
cd /home/vagrant/tools
wget -nv http://speechkitchen.org/vms/Data/eesen-offline-transcriber.tgz
tar zxvf eesen-offline-transcriber.tgz
rm eesen-offline-transcriber.tgz


#fixups
cd eesen-offline-transcriber
rm -f steps_eesen
ln -s /home/vagrant/eesen/asr_egs/tedlium-fbank/steps steps_eesen
sed -i s/er1k/vagrant/ Makefile.options

# get XFCE, xterm
sudo apt-get install -y xfce4-panel xterm

# get SLURM stuff
apt-get install -y --no-install-recommends slurm-llnl
/usr/sbin/create-munge-key
mkdir /var/run/munge /var/run/slurm-llnl
#mkdir /home/vagrant/tools/kaldi-offline-transcriber/Log
cp /vagrant/slurm.conf /etc/slurm-llnl/slurm.conf
#cp /vagrant/slurm.sh /home/vagrant/tools/kaldi-offline-transcriber/
# gets overwritten when /home/vagrant/tools/kaldi-offline-transcriber-english.tgz unzips
cp /vagrant/reconf-slurm.sh /root/

# This tricks the Vagrant shared folder default "/vagrant" into working
# like the VirtualBox shared folder default "/media/sf_transcriber", which is hard coded
# into scripts slurm-watched.sh and watch.sh in the transcriber root
ln -s /vagrant /media/sf_transcriber

# Supervisor stuff
#
# copy config first so it gets picked up
cp /vagrant/supervisor.conf /etc/supervisor.conf
mkdir -p /etc/supervisor/conf.d
cp /vagrant/slurm.sv.conf /etc/supervisor/conf.d/
# Now start service
apt-get install -y supervisor

# more misc. setup
mkdir -p /vagrant/transcribe-in
mkdir -p /vagrant/transcribe-out
rm -f /home/vagrant/tools/eesen-offline-transcriber/result #other system
# our system
ln -s /vagrant/transcribe-out /home/vagrant/tools/eesen-offline-transcriber/result

# Provisioning runs as root; we want files to be writable by 'vagrant'
# only change might be if this is to run on Amazon AWS, where default user is 'ubuntu'
# but the work-around is to create the vagrant user and keep all the above
chown -R vagrant:vagrant /home/vagrant/ 

  SHELL

end
