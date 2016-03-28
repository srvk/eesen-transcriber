# -*- mode: ruby -*-
# vi: set ft=ruby

Vagrant.configure("2") do |config|

    config.vm.provider "aws" do |aws, override|
      # Non-GPU AMI: Ubuntu ("Trusty") Server 14.04 LTS US-West region
      aws.ami = "ami-663a6e0c"
      aws.instance_type = "m2.medium"
      config.vm.synced_folder ".", "/vagrant", type: "rsync"
      #config.vm.synced_folder ".", "/vagrant", type: "nfs" #, nfs_version: 4, nfs_udp: false
      override.vm.box = "dummy"

      # it is assumed these environment variables are set in "env.sh"
      aws.access_key_id = ENV['AWS_KEY']
      aws.secret_access_key = ENV['AWS_SECRETKEY']
      # your AWS access keys
      aws.keypair_name = ENV['AWS_KEYPAIR']
      # something like "ec2user" (ssh key pair)
      override.ssh.username = "ec2-user"
      override.ssh.private_key_path = ENV['AWS_PEM']
      # something like "~/.ssh/ec2.pem"

      aws.terminate_on_shutdown = "true"
      aws.region = "us-east-1"

      # Not sure which of these we want
      # but we want to create a security group on AWS console that forwards
      # HTTP if this VM is going to serve files as a video browser
      #aws.security_groups = [ "CMU Addresses", "default" ]
      #aws.subnet_id = "vpc-666c9a02"
      aws.security_groups = "launch-wizard-1"

      aws.region_config "us-east-1" do |region|
        #region.spot_instance = true
        region.spot_max_price = "0.1"
      end

      # this works around the error from AWS AMI vm on 'vagrant up':
      #   No host IP was given to the Vagrant core NFS helper. This is
      #   an internal error that should be reported as a bug.
      override.nfs.functional = false

    end

    config.vm.provider "virtualbox" do |vbox, override|
      # OSX audio
      #vbox.customize ["modifyvm", :id, '--audio', 'coreaudio', '--audiocontroller', 'hda']
      # linux audio
      #vbox.customize ["modifyvm", :id, '--audio', 'pulse', '--audiocontroller', 'ac97']
      config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777", "fmode=666"]

      override.vm.box = "ubuntu/trusty64"
      override.ssh.forward_x11 = true

      # host-only network on which web browser serves files
      config.vm.network "private_network", ip: "192.168.56.101"

      vbox.cpus = 2
      vbox.memory = 8192
    end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update -y
    sudo apt-get upgrade

    sudo apt-get install -y git automake libtool autoconf patch subversion fuse\
       libatlas-base-dev libatlas-dev liblapack-dev sox openjdk-6-jre libav-tools g++\
       zlib1g-dev libsox-fmt-all apache2 sshfs

    # Add user to audio group. Otherwise aplay -l finds no hardware(!)
    sudo usermod -a -G audio vagrant

    # install srvk EESEN (does not require CUDA)
    git clone https://github.com/riebling/eesen.git
    cd eesen/tools
    make -j `lscpu -p|grep -v "#"|wc -l`
    # remove a parameter from scoring script
    sed -i 's/\ lur//g' sctk/bin/hubscr.pl
    cd ../src
    ./configure --shared #--cudatk-dir=/opt/nvidia/cuda
    make -j `lscpu -p|grep -v "#"|wc -l`


    # get models
    cd /home/vagrant/eesen/asr_egs/tedlium
    wget -nv http://speechkitchen.org/vms/Data/v1.tgz
    tar zxvf v1.tgz
    rm v1.tgz

    # get eesen-offline-transcriber
    mkdir -p /home/vagrant/tools
    cd /home/vagrant/tools
    git clone https://github.com/riebling/srvk-eesen-offline-transcriber
    mv srvk-eesen-offline-transcriber eesen-offline-transcriber

    mkdir -p /vagrant/build
    ln -s /vagrant/build /home/vagrant/tools/eesen-offline-transcriber/build
    
    mkdir -p eesen-offline-transcriber/build

    # get XFCE, xterm if we want guest VM to open windows /menus on host
    #sudo apt-get install -y xfce4-panel xterm

    # Apache setup
    # unzip web root template
    cd /vagrant
    tar zxvf /vagrant/videobrowser.tgz

    # set the shared folder to be (mounted as a shared folder in the VM) "www"
    sed -i 's|/var/www/html|/vagrant/www|g' /etc/apache2/sites-enabled/000-default.conf
    sed -i 's|/var/www/|/vagrant/www/|g' /etc/apache2/apache2.conf
    service apache2 restart

    cp /vagrant/scripts/vids2web.sh /home/vagrant/tools/eesen-offline-transcriber
    cp /vagrant/scripts/mkpages.sh /home/vagrant/tools/eesen-offline-transcriber
    chmod +x /home/vagrant/tools/eesen-offline-transcriber/*.sh

    # get SLURM stuff
    apt-get install -y --no-install-recommends slurm-llnl < /usr/bin/yes
    /usr/sbin/create-munge-key -f
    mkdir -p /var/run/munge /var/run/slurm-llnl
    chown munge:root /var/run/munge
    chown slurm:slurm /var/run/slurm-llnl
    echo 'OPTIONS="--syslog"' >> /etc/default/munge
    cp /vagrant/conf/slurm.conf /etc/slurm-llnl/slurm.conf
    cp /vagrant/conf/reconf-slurm.sh /root/

    # This tricks the Vagrant shared folder default "/vagrant" into working
    # like the VirtualBox shared folder default "/media/sf_transcriber", which is hard coded
    # into scripts slurm-watched.sh and watch.sh in the transcriber root
    ln -s /vagrant /media/sf_transcriber

    # Supervisor stuff
    #
    # copy config first so it gets picked up
    cp /vagrant/conf/supervisor.conf /etc/supervisor.conf
    mkdir -p /etc/supervisor/conf.d
    cp /vagrant/conf/slurm.sv.conf /etc/supervisor/conf.d/
    # Now start service
    apt-get install -y supervisor

    # Do we still want transcriber to use these?
    #mkdir -p /vagrant/transcribe-in
    #mkdir -p /vagrant/transcribe-out

    #rm -f /home/vagrant/tools/eesen-offline-transcriber/result #other system
    # our system
    #ln -s /vagrant/transcribe-out /home/vagrant/tools/eesen-offline-transcriber/result

    # configure sshfs here

    # Provisioning runs as root; we want files to be writable by 'vagrant'
    # only change might be if this is to run on Amazon AWS, where default user is 'ubuntu'
    # but the work-around is to create the vagrant user and keep all the above
    chown -R vagrant:vagrant /home/vagrant/ 

  SHELL
end
