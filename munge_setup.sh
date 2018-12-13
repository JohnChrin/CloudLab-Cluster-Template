#THIS IS FOR ALL NODES
sudo yum install mariadb-server mariadb-devel -y
export MUNGEUSER=991
sudo groupadd -g $MUNGEUSER munge
sudo useradd -m -c "Munge Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge -s /sbin/nologin munge
export SLURMUSER=992
sudo groupadd -g $SLURMUSER slurm
sudo useradd -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm -s /bin/bash slurm
sudo yum install epel-release -y
sudo yum install munge munge-libs munge-devel -y
sudo yum install rng-tools -y
sudo mkdir /etc/munge/
#wait until head creates secret key and pass to etc/munge
while [ ! -f /scratch/munge.key ]
do
  sleep 10
done
sudo cp /scratch/munge.key /etc/munge/munge.key
sudo chown 991 /etc/munge/munge.key
sudo chmod 400 /etc/munge/munge.key
#correct permissions
sudo chown -R munge: /etc/munge/ /var/log/munge/
sudo chmod 0700 /etc/munge/ /var/log/munge/
while [ ! -f /scratch/metakey.fin ]
do
  sleep 10
done
#start munge service
sudo systemctl enable munge
sudo systemctl start munge
