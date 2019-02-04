# Cluster-Template-2
This will handle creating a cluster on cloudlab of up to 12 nodes, with a shared file system, using a central MPI installation.


### ALL NODES

sudo yum install mariadb-server mariadb-devel -y
export MUNGEUSER=991
sudo groupadd -g $MUNGEUSER munge
sudo useradd -m -c "Munge Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge -s /sbin/nologin munge
export SLURMUSER=992
sudo groupadd -g $SLURMUSER slurm
sudo useradd -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm -s /bin/bash slurm
sudo yum install epel-release
sudo yum install munge munge-libs munge-devel -y
sudo yum install rng-tools -y

### Head NODE

sudo /usr/sbin/create-munge-key -r
sudo chmod 777 /etc/munge/munge.key
sudo su root -c 'dd if=/dev/urandom bs=1 count=1024 > /etc/munge/munge.key'
sudo chmod 700 /etc/munge/munge.key
sudo chown munge: /etc/munge/munge.key
sudo su BW840606 -c "sudo scp /etc/munge/munge.key 192.168.1.4:/etc/munge"
ssh 192.168.1.4 sudo chown 991 /etc/munge/munge.key
sudo su BW840606 -c "sudo scp /etc/munge/munge.key 192.168.1.5:/etc/munge"
ssh 192.168.1.5 sudo chown 991 /etc/munge/munge.key
sudo su BW840606 -c "sudo scp /etc/munge/munge.key 192.168.1.6:/etc/munge"
ssh 192.168.1.6 sudo chown 991 /etc/munge/munge.key


### Start Munge on ALL NODES

sudo ssh 192.168.1.4 sudo systemctl enable munge
sudo ssh 192.168.1.4 sudo systemctl start munge

sudo ssh 192.168.1.5 sudo systemctl enable munge
sudo ssh 192.168.1.5 sudo systemctl start munge

sudo ssh 192.168.1.6 sudo systemctl enable munge
sudo ssh 192.168.1.6 sudo systemctl start munge

### ALL NODES

cd ~
sudo yum install rpm-build gcc openssl openssl-devel libssh2-devel pam-devel numactl numactl-devel hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel gtk2-devel man2html libibmad libibumad perl-Switch perl-ExtUtils-MakeMaker -y
sudo mkdir slurm
cd slurm
sudo wget http://www.schedmd.com/download/latest/slurm-18.08.3.tar.bz2
sudo yum install rpm-build
sudo rpmbuild -ta slurm-18.08.3.tar.bz2
sudo mkdir /scratch/slurm-rpms
sudo cp /root/rpmbuild/RPMS/x86_64/* /scratch/slurm-rpms
sudo touch /scratch/rpm.fin
sudo yum --nogpgcheck localinstall /software/slurm-rpms/* -y

# HEAD
#sudo cp /scratch/slurm.conf /etc/slurm/slurm.conf
# OR THIS
#sudo scp slurm.conf root@192.168.1.4/etc/slurm.conf
#sudo scp slurm.conf root@192.168.1.5/etc/slurm.conf
#sudo scp slurm.conf root@192.168.1.6/etc/slurm.conf
# STILL HEAD
sudo mkdir /var/spool/slurmctld
sudo chown slurm: /var/spool/slurmctld
sudo chmod 755 /var/spool/slurmctld
sudo touch /var/log/slurmctld.log
sudo chown slurm: /var/log/slurmctld.log
sudo touch /var/log/slurm_jobacct.log /var/log/slurm_jobcomp.log
sudo chown slurm: /var/log/slurm_jobacct.log /var/log/slurm_jobcomp.log
sudo touch /var/run/slurmctld
sudo chmod 777 /var/run/slurmctld


### ALL OTHER NODES 1-3

sudo mkdir /var/spool/slurmd
sudo chown slurm: /var/spool/slurmd
sudo chmod 755 /var/spool/slurmd
sudo touch /var/log/slurmd.log
sudo chown slurm: /var/log/slurmd.log


### ALL NODES with 1-3 FIRST then HEAD NODE

sudo yum install ntp -y
sudo chkconfig ntpd on
sudo ntpdate pool.ntp.org
sudo systemctl start ntpd

sudo systemctl enable slurmd.service
sudo systemctl start slurmd.service
sudo systemctl status slurmd.service
