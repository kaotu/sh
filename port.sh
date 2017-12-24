#./bin/bash

sudo systemctl start firewalld
echo " Openning port 80(http) "
sudo firewall-cmd --add-port=80/tcp --permanent
echo " Openning port 3000 "
sudo firewall-cmd --add-port=3000/tcp --permanent
echo " Reloading port "
sudo firewall-cmd --reload
echo " Port is opened "
sudo firewall-cmd --list-port

