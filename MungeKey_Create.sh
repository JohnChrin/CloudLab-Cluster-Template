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
#THIS IS FOR THE HEAD NODE ONLY
#WARNING: the command below may hang, useage of -r has caused this previously.
sudo /usr/sbin/create-munge-key -f
sudo chmod 777 /etc/munge/munge.key
sudo su root -c 'dd if=/dev/urandom bs=1 count=1024 > /etc/munge/munge.key'
sudo chmod 700 /etc/munge/munge.key
sudo chown munge: /etc/munge/munge.key
sudo cp /etc/munge/munge.key /scratch/munge.key
#correct permissions
sudo chown -R munge: /etc/munge/ /var/log/munge/
sudo chmod 0700 /etc/munge/ /var/log/munge/
while [ ! -f /scratch/metakey.fin ]
do
  sleep 10
done

#ssh 192.168.1.2 sudo mkdir /etc/munge/
#ssh 192.168.1.2 sudo cp /scratch/munge.key /etc/munge/munge.key
#ssh 192.168.1.2 sudo chown 991 /etc/munge/munge.key
#ssh 192.168.1.4 sudo mkdir /etc/munge/
#ssh 192.168.1.4 sudo cp /scratch/munge.key /etc/munge/munge.key
#ssh 192.168.1.4 sudo chown 991 /etc/munge/munge.key
#ssh 192.168.1.5 sudo mkdir /etc/munge/
#ssh 192.168.1.5 sudo cp /scratch/munge.key /etc/munge/munge.key
#ssh 192.168.1.5 sudo chown 991 /etc/munge/munge.key
#ssh 192.168.1.6 sudo mkdir /etc/munge/
#ssh 192.168.1.6 sudo cp /scratch/munge.key /etc/munge/munge.key
#ssh 192.168.1.6 sudo chown 991 /etc/munge/munge.key
#ssh 192.168.1.2 sudo systemctl enable munge
#ssh 192.168.1.2 sudo systemctl start munge
#ssh 192.168.1.4 sudo systemctl enable munge
#ssh 192.168.1.4 sudo systemctl start munge
#ssh 192.168.1.5 sudo systemctl enable munge
#ssh 192.168.1.5 sudo systemctl start munge
#ssh 192.168.1.6 sudo systemctl enable munge
#ssh 192.168.1.6 sudo systemctl start munge
sudo systemctl enable munge
sudo systemctl start munge
