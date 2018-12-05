sudo /usr/sbin/create-munge-key -r
sudo chmod 777 /etc/munge/munge.key
sudo su root -c 'dd if=/dev/urandom bs=1 count=1024 > /etc/munge/munge.key'
sudo chmod 700 /etc/munge/munge.key
sudo chown munge: /etc/munge/munge.key
sudo su BW840606 -c "sudo scp /etc/munge/munge.key 192.168.1.4:/etc/munge"
ssh 192.168.1.4 sudo chown 991 /etc/munge/mung.key
sudo su BW840606 -c "sudo scp /etc/munge/munge.key 192.168.1.5:/etc/munge"
ssh 192.168.1.5 sudo chown 991 /etc/munge/mung.key
sudo su BW840606 -c "sudo scp /etc/munge/munge.key 192.168.1.6:/etc/munge"
ssh 192.168.1.6 sudo chown 991 /etc/munge/mung.key
