sudo yum install rpm-build gcc openssl openssl-devel libssh2-devel pam-devel numactl numactl-devel hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel gtk2-devel man2html libibmad libibumad perl-Switch perl-ExtUtils-MakeMaker -y
#cd ~ && sudo mkdir slurm
#cd ~/slurm && sudo wget http://www.schedmd.com/download/latest/slurm-18.08.4.tar.bz2
#cd ~/slurm && sudo yum install rpm-build
#cd ~/slurm && sudo rpmbuild -ta /local/repository/slurm-18.08.4.tar.bz2
#sudo mkdir /scratch/slurm-rpms
#sudo cp /root/rpmbuild/RPMS/x86_64/* /scratch/slurm-rpms
#install slurm
while [ ! -f /scratch/rpm.fin ]
do
  sleep 10
done
sudo yum --nogpgcheck localinstall /scratch/slurm-rpms/* -y
sudo mkdir /etc/slurm
sudo cp /local/repository/Becca_Slurm_Conf /etc/slurm/slurm.conf
sudo mkdir /var/spool/slurmd
sudo chown slurm: /var/spool/slurmd
sudo chmod 755 /var/spool/slurmd
sudo touch /var/log/slurmd.log
sudo chown slurm: /var/log/slurmd.log
sudo yum install ntp -y
sudo chkconfig ntpd on
sudo ntpdate pool.ntp.org
sudo systemctl start ntpd
#enable slurm daemon while credit to GJBarretta
while [ ! -f /scratch/dbd.fin ]
do
  sleep 5
done
sudo systemctl enable slurmd
sudo systemctl start slurmd
sudo touch /scratch/d.fin
