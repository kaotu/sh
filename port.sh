#./bin/bash
#Text Colour
Green='\033[1;32m'
Red='\033[0;31m'
Yellow='\033[0;33m'
NC='\033[0m'


sudo systemctl start firewalld
echo
echo -e "${Yellow}Openning port 80(http)${NC}"
sudo firewall-cmd --add-port=80/tcp --permanent
echo
echo -e "${Yellow}Openning port 3000${NC}"
sudo firewall-cmd --add-port=3000/tcp --permanent
echo
echo -e "${Green}Reloading port${NC}"
sudo firewall-cmd --reload
echo
echo -e "${Green}Port is opened${NC}"
sudo firewall-cmd --list-port

