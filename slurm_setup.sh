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
