# -*- mode: ruby -*-
# vi: set ft=ruby

Vagrant.configure("2") do |config|

  # Default provider is virtualbox
  # if you want aws, you need to first
  # from the shell do . env.sh
    config.vm.box = "ubuntu/trusty64"
    config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777", "fmode=666"]

    config.vm.provider "virtualbox" do |vbox|
      config.ssh.forward_x11 = true

      # host-only network on which web browser serves files
      config.vm.network "private_network", ip: "192.168.56.101"

      vbox.cpus = 4
      vbox.memory = 8192
    end

    config.vm.provider "aws" do |aws, override|

      aws.tags["Name"] = "Eesen Transcriber"
      aws.ami = "ami-663a6e0c" # Ubuntu ("Trusty") Server 14.04 LTS AMI - US-East region
      aws.instance_type = "m3.xlarge"

      override.vm.synced_folder ".", "/vagrant", type: "sshfs", ssh_username: ENV['USER'], ssh_port: "22", prompt_for_password: "true"

      override.vm.box = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

      # it is assumed these environment variables were set by ". env.sh"
      aws.access_key_id = ENV['AWS_KEY']
      aws.secret_access_key = ENV['AWS_SECRETKEY']
      aws.keypair_name = ENV['AWS_KEYPAIR']
      override.ssh.username = "ubuntu"
      override.ssh.private_key_path = ENV['AWS_PEM']

      aws.terminate_on_shutdown = "true"
      aws.region = ENV['AWS_REGION']

      # https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#SecurityGroups
      # Edit the security group on AWS Console; Inbound tab, add the HTTP rule
      aws.security_groups = "launch-wizard-1"

      #aws.subnet_id = "vpc-666c9a02"
      aws.region_config "us-east-1" do |region|
        #region.spot_instance = true
        region.spot_max_price = "0.1"
      end

      # this works around the error from AWS AMI vm on 'vagrant up':
      #   No host IP was given to the Vagrant core NFS helper. This is
      #   an internal error that should be reported as a bug.
      #override.nfs.functional = false
    end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update -y
    sudo apt-get upgrade

    if grep --quiet vagrant /etc/passwd
    then
      user="vagrant"
    else
      user="ubuntu"
    fi

    sudo apt-get install -y git make automake libtool autoconf patch subversion fuse\
       libatlas-base-dev libatlas-dev liblapack-dev sox openjdk-6-jre libav-tools g++\
       zlib1g-dev libsox-fmt-all apache2 sshfs

    # If you wish to train EESEN with a GPU machine, uncomment this section to install CUDA
    # also uncomment the line that mentions cudatk-dir in the EESEN install section below
    #cd /home/${user}
    #wget -nv http://speechkitchen.org/vms/Data/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
    #dpkg -i cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
    #rm cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
    #apt-get update                                                                  
    #apt-get remove --purge xserver-xorg-video-nouveau                           
    #apt-get install -y cuda

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
    cd /home/${user}/eesen/asr_egs/tedlium
    wget -nv http://speechkitchen.org/vms/Data/v1.tgz
    tar zxvf v1.tgz
    rm v1.tgz

    # get eesen-offline-transcriber
    mkdir -p /home/${user}/tools
    cd /home/${user}/tools
    git clone https://github.com/riebling/srvk-eesen-offline-transcriber
    mv srvk-eesen-offline-transcriber eesen-offline-transcriber
    # make links to EESEN
    cd eesen-offline-transcriber
    ln -s /home/${user}/eesen/asr_egs/tedlium/v1/steps .
    ln -s /home/${user}/eesen/asr_egs/tedlium/v1/utils .

    # Results (and intermediate files) are placed on the shared host folder
    mkdir -p /vagrant/{build,log,transcribe_me}

    ln -s /vagrant/build /home/${user}/tools/eesen-offline-transcriber/build

    # get XFCE, xterm if we want guest VM to open windows /menus on host
    #sudo apt-get install -y xfce4-panel xterm

    # Apache setup
    # unzip web root template
    cd /vagrant
    tar --no-same-owner -zxvf /vagrant/videobrowser.tgz 

    # set the shared folder to be (mounted as a shared folder in the VM) "www"
    sed -i 's|/var/www/html|/vagrant/www|g' /etc/apache2/sites-enabled/000-default.conf
    sed -i 's|/var/www/|/vagrant/www/|g' /etc/apache2/apache2.conf
    service apache2 restart

    cp /vagrant/scripts/{vids2web.sh,mkpages.sh,batch.sh,slurm.sh,watch.sh} /home/${user}/tools/eesen-offline-transcriber
    chmod +x /home/${user}/tools/eesen-offline-transcriber/*.sh
    # shorten paths used by vagrant ssh -c <command> commands
    # by symlinking ~/bin to here
    ln -s /home/${user}/tools/eesen-offline-transcriber /home/${user}/bin

    # get SLURM stuff
    apt-get install -y --no-install-recommends slurm-llnl < /usr/bin/yes
    /usr/sbin/create-munge-key -f
    mkdir -p /var/run/munge /var/run/slurm-llnl
    chown munge:root /var/run/munge
    chown slurm:slurm /var/run/slurm-llnl
    echo 'OPTIONS="--syslog"' >> /etc/default/munge
    cp /vagrant/conf/slurm.conf /etc/slurm-llnl/slurm.conf
    cp /vagrant/conf/reconf-slurm.sh /root/
    # 
    # Supervisor stuff needed by slurm
    # copy config first so it gets picked up
    cp /vagrant/conf/supervisor.conf /etc/supervisor.conf
    mkdir -p /etc/supervisor/conf.d
    cp /vagrant/conf/slurm.sv.conf /etc/supervisor/conf.d/
    # Now start service
    apt-get install -y supervisor

    # Provisioning runs as root; we want files to belong to '${user}'
    chown -R ${user}:${user} /home/${user}

    # start monitoring watched folder
    su ${user} -c "cd /home/${user}/tools/eesen-offline-transcriber && ./watch.sh >& /vagrant/log/watched.log &"

    # Handy info
    echo "\n\n\nWatching folder (/vagrant/)transcribe_me/ for new files to transcribe...
.ctm files will appear alongside source files
logs are in (/vagrant/)log/"
    if [ ${user} == vagrant ] 
    then
      echo "Point your Chrome or Safari browser to http://192.168.56.101 to view transcription result videos"
    else
      publicIP=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`
      echo "Point your Chrome or Safari browser to http://${publicIP} to view transcription result videos"
    fi

  SHELL
end
