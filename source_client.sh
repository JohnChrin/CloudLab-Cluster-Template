echo "export PATH='$PATH:/software/openmpi/3.1.2/bin'" >> /users/BW840606/.bashrc
echo "export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/software/openmpi/3.1.2/lib/'" >> /users/BW840606/.bashrc
source /users/BW840606/.bashrc
sudo su root -c 'echo 'PATH="/software/openmpi/3.1.2/bin:$PATH"' >> /etc/environment'
