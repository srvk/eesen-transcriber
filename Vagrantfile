# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.ssh.forward_x11 = true

  # Create a private network, which allows host-only access to the machine
  # using a specific IP. This happens to also be the IP address on which the
  # files shared by Apache server can be accessed, from the host, e.g.
  # http://192.168.33.11 will take you to the web root page (see synced folder below)
  config.vm.network "private_network", ip: "192.168.33.11"

  # we're going to share /vagrant in the VM as the default Apache2 location
  # which will be configured to share a folder called "www" resides
  # on the host in the working directory ("." here) where Vagrant is launched ("vagrant up")
  config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777", "fmode=666"]

  config.vm.provider :virtualbox do |vb|
  #    vb.customize ["modifyvm", :id, '--audio', 'pulse', '--audiocontroller', 'ac97'] # choices: hda sb16 ac97
  vb.cpus = 4
  vb.memory = 4096 # 4 GB
end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update -y
    sudo apt-get upgrade

    sudo apt-get install -y git automake libtool autoconf patch subversion fuse\
       libatlas-base-dev libatlas-dev liblapack-dev sox openjdk-6-jre libav-tools g++\
       zlib1g-dev libsox-fmt-all apache2

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

    # more misc. setup
    mkdir -p /vagrant/transcribe-in
    mkdir -p /vagrant/transcribe-out

    #rm -f /home/vagrant/tools/eesen-offline-transcriber/result #other system
    # our system
    #ln -s /vagrant/transcribe-out /home/vagrant/tools/eesen-offline-transcriber/result

    # Provisioning runs as root; we want files to be writable by 'vagrant'
    # only change might be if this is to run on Amazon AWS, where default user is 'ubuntu'
    # but the work-around is to create the vagrant user and keep all the above
    chown -R vagrant:vagrant /home/vagrant/ 

  SHELL

end
