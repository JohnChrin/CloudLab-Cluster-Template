#THIS IS FOR ALL NODES
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
cd ~ && sudo yum install rpm-build gcc openssl openssl-devel libssh2-devel pam-devel numactl numactl-devel hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel gtk2-devel man2html libibmad libibumad perl-Switch perl-ExtUtils-MakeMaker -y
cd ~ && sudo mkdir slurm
cd slurm
cd slurm && sudo wget http://www.schedmd.com/download/latest/slurm-18.08.3.tar.bz2
cd slurm && sudo yum install rpm-build
cd slurm && sudo rpmbuild -ta slurm-18.08.3.tar.bz2
sudo mkdir /scratch/slurm-rpms
sudo cp /root/rpmbuild/RPMS/x86_64/* /scratch/slurm-rpms
sudo touch /scratch/rpm.fin
sudo yum --nogpgcheck localinstall /software/slurm-rpms/* -y
#MAKE SURE THE TIMING ON THIS IS GOOD, slumd MUST BE THERE FIRST
sudo mkdir /var/spool/slurmd
sudo chown slurm: /var/spool/slurmd
sudo chmod 755 /var/spool/slurmd
sudo touch /var/log/slurmd.log
sudo chown slurm: /var/log/slurmd.log
