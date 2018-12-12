#THIS IS FOR THE HEAD NODE ONLY
#WARNING: the command below may hang, useage of -r has caused this previously.
sudo /usr/sbin/create-munge-key -f
sudo chmod 777 /etc/munge/munge.key
sudo su root -c 'dd if=/dev/urandom bs=1 count=1024 > /etc/munge/munge.key'
sudo chmod 700 /etc/munge/munge.key
sudo chown munge: /etc/munge/munge.key
sudo cp /etc/munge/munge.key /scratch/munge.key
ssh 192.168.1.2 sudo cp /scratch/munge.key /etc/munge/munge.key
ssh 192.168.1.2 sudo chown 991 /etc/munge/munge.key
ssh 192.168.1.4 sudo cp /scratch/munge.key /etc/munge/munge.key
ssh 192.168.1.4 sudo chown 991 /etc/munge/munge.key
ssh 192.168.1.5 sudo cp /scratch/munge.key /etc/munge/munge.key
ssh 192.168.1.5 sudo chown 991 /etc/munge/munge.key
ssh 192.168.1.6 sudo cp /scratch/munge.key /etc/munge/munge.key
ssh 192.168.1.6 sudo chown 991 /etc/munge/munge.key
ssh 192.168.1.2 sudo systemctl enable munge
ssh 192.168.1.2 sudo systemctl start munge
ssh 192.168.1.4 sudo systemctl enable munge
ssh 192.168.1.4 sudo systemctl start munge
ssh 192.168.1.5 sudo systemctl enable munge
ssh 192.168.1.5 sudo systemctl start munge
ssh 192.168.1.6 sudo systemctl enable munge
ssh 192.168.1.6 sudo systemctl start munge
sudo systemctl enable munge
sudo systemctl start munge
