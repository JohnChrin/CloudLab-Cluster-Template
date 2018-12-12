#!/bin/bash

sudo yum install mariadb-server mariadb-devel -y

#create global users
export MUNGEUSER=991
sudo groupadd -g $MUNGEUSER munge
sudo useradd  -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge  -s /sbin/nologin munge
export SLURMUSER=992
sudo groupadd -g $SLURMUSER slurm
sudo useradd  -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm  -s /bin/bash slurm

#install munge
sudo yum install epel-release -y
sudo yum install munge munge-libs munge-devel -y

#install slurm dependencies
cd ~ && sudo yum install rpm-build gcc openssl openssl-devel libssh2-devel pam-devel numactl numactl-devel hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel gtk2-devel man2html libibmad libibumad perl-Switch perl-ExtUtils-MakeMaker -y
cd ~ && sudo mkdir slurm
#cd ~/slurm && sudo wget http://www.schedmd.com/download/latest/slurm-18.08.4.tar.bz2
cd ~/slurm && sudo yum install rpm-build
cd ~/slurm && sudo rpmbuild -ta /local/repository/slurm-18.08.4.tar.bz2
#sudo mkdir /scratch/slurm-rpms
#sudo cp /root/rpmbuild/RPMS/x86_64/* /scratch/slurm-rpms
sudo yum --nogpgcheck localinstall /root/rpmbuild/RPMS/x86_64/* -y

#metadata configuration
sudo cp /local/repository/slurm.conf /etc/slurm/slurm.conf
sudo cp /local/repository/slurmdbd.conf /etc/slurm/slurmdbd.conf
sudo mkdir /var/spool/slurmdbd
sudo chown slurm: /var/spool/slurmdbd
sudo chmod 755 /var/spool/slurmdbd
sudo touch /var/log/slurmdbd.log
sudo chown slurm: /var/log/slurmdbd.log
sudo chmod 755 /var/log/slurmdbd.log
sudo touch /var/run/slurmdbd.pid
sudo chown slurm: /var/run/slurmdbd.pid
sudo chmod 777 /var/run/slurmdbd.pid
sudo cp /local/repository/innodb.cnf /etc/my.cnf.d/innodb.cnf
sudo chown slurm: /etc/my.cnf.d/innodb.cnf
sudo chmod 777 /etc/my.cnf.d/innodb.cnf

#setup mariedb
sudo systemctl start mariadb 
sudo systemctl enable mariadb 

sudo mysql  -sfu root < "/local/repository/setup.sql"
sudo mysql "-psecret" < "/local/repository/dbd.sql"

#setup clock
sudo yum install ntp -y
sudo chkconfig ntpd on
sudo ntpdate pool.ntp.org
sudo systemctl start ntpd

#enable slurm daemon
sudo systemctl enable slurmdbd
sudo systemctl start slurmdbd

#notify all other nodes that slurmdbd daemon is up
sudo touch /scratch/dbd.fin

#wait for callback from head node
#while [ ! -f /scratch/head.fin ]
#do
#  sleep 5
#done

#add cluster
yes | sudo sacctmgr add cluster cluster

#notify head node cluster has been added
#sudo touch /scratch/cluster.fin
