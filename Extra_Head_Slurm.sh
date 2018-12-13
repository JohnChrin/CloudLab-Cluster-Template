sudo yum install rpm-build gcc openssl openssl-devel libssh2-devel pam-devel numactl numactl-devel hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel gtk2-devel man2html libibmad libibumad perl-Switch perl-ExtUtils-MakeMaker -y
#cd ~ && sudo mkdir slurm
#cd ~/slurm && sudo wget http://www.schedmd.com/download/latest/slurm-18.08.4.tar.bz2
cd ~/slurm && sudo yum install rpm-build
#cd ~/slurm
sudo rpmbuild -ta /local/repository/slurm-18.08.4.tar.bz2
sudo mkdir /scratch/slurm-rpms
sudo cp /root/rpmbuild/RPMS/x86_64/* /scratch/slurm-rpms
sudo touch /scratch/rpm.fin
sudo yum --nogpgcheck localinstall /scratch/slurm-rpms/* -y
sudo cp /local/repository/Becca_Slurm_Conf /scratch/slurm.conf
sudo mkdir /etc/slurm/ 
sudo cp /scratch/slurm.conf /etc/slurm/slurm.conf
sudo firewall-cmd --add-port=6817-6818/tcp
#ssh 192.168.1.4 sudo mkdir /etc/slurm/
#ssh 192.168.1.4 sudo cp /local/repository/Becca_Slurm_Conf /etc/slurm/slurm.conf
#ssh 192.168.1.5 sudo mkdir /etc/slurm/
#ssh 192.168.1.5 sudo cp /local/repository/Becca_Slurm_Conf /etc/slurm/slurm.conf
#ssh 192.168.1.6 sudo mkdir /etc/slurm/
#ssh 192.168.1.6 sudo cp /local/repository/Becca_Slurm_Conf /etc/slurm/slurm.conf
#MAKE SURE THE TIMING ON THIS IS GOOD, slumd MUST BE THERE FIRST
sudo mkdir /var/spool/slurmctld
sudo chown slurm: /var/spool/slurmctld
sudo chmod 755 /var/spool/slurmctld
sudo touch /var/log/slurmctld.log
sudo chown slurm: /var/log/slurmctld.log
sudo touch /var/log/slurm_jobacct.log /var/log/slurm_jobcomp.log
sudo chown slurm: /var/log/slurm_jobacct.log /var/log/slurm_jobcomp.log
sudo touch /var/run/slurmctld
sudo chmod 777 /var/run/slurmctld
sudo yum install ntp -y
sudo chkconfig ntpd on
sudo ntpdate pool.ntp.org
sudo systemctl start ntpd
#enable slurm daemon
while [ ! -f /scratch/d.fin ]
do
  sleep 5
done
sudo systemctl enable slurmctld.service
sudo systemctl start slurmctld.service
#notify metadata slurmctld daemon is up
sudo touch /scratch/head.fin

##wait for callback from metadata
#while [ ! -f /scratch/cluster.fin ]
#do
#  sleep 5
#done
#
##restart slurmctld daemon
#sudo systemctl restart slurmctld
#
##remove setup files
#cd /scratch
#sudo rm d.fin dbd.fin dbd.sql innodb.cnf metakey.fin munge.key rpm.fin setup.sql slurm.conf slurmdbd.conf

