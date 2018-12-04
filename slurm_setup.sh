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
sudo /usr/sbin/create-munge-key -r
sudo chmod 777 /etc/munge/munge.key
sudo su root -c 'dd if=/dev/urandom bs=1 count=1024 > /etc/munge/munge.key'
sudo chmod 400 /etc/munge/munge.key
sudo chown munge: /etc/munge/munge.key
sudo scp /etc/munge/munge.key compute-1:/etc/munge
sudo scp /etc/munge/munge.key compute-2:/etc/munge
sudo scp /etc/munge/munge.key compute-3:/etc/munge
