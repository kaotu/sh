#./bin/bash

sudo systemctl start firewalld
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --add-port=3000/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-port

