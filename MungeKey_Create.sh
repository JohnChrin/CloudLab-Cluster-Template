#THIS IS FOR THE HEAD NODE ONLY
sudo /usr/sbin/create-munge-key -r
sudo chmod 777 /etc/munge/munge.key
sudo su root -c 'dd if=/dev/urandom bs=1 count=1024 > /etc/munge/munge.key'
sudo chmod 700 /etc/munge/munge.key
sudo chown munge: /etc/munge/munge.key
sudo cp /etc/munge/munge.key /scratch/munge.key
ssh 192.168.1.4 sudo cp /scratch/munge.key /etc/munge/munge.key
ssh 192.168.1.4 sudo chown 991 /etc/munge/munge.key
ssh 192.168.1.5 sudo cp /scratch/munge.key /etc/munge/munge.key
ssh 192.168.1.5 sudo chown 991 /etc/munge/munge.key
ssh 192.168.1.6 sudo cp /scratch/munge.key /etc/munge/munge.key
ssh 192.168.1.6 sudo chown 991 /etc/munge/munge.key
sudo ssh 192.168.1.4 sudo systemctl enable munge
sudo ssh 192.168.1.4 sudo systemctl start munge
sudo ssh 192.168.1.5 sudo systemctl enable munge
sudo ssh 192.168.1.5 sudo systemctl start munge
sudo ssh 192.168.1.6 sudo systemctl enable munge
sudo ssh 192.168.1.6 sudo systemctl start munge
