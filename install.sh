#!/bin/bash

sudo yum update
sudo yum install nano -y
sudo yum install epel-release -y
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo yum install git -y
sudo yum install curl -y
sudo curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
sudo sudo yum install nodejs -y
sudo yum install npm -y
sudo npm install pdfkit -save
sudo npm install
sudo npm update
sudo npm install pm2 -g
sudo yum install firewalld
systemctl start firewalld
systemctl enable firewalld
sudo yum -y install net-tools


echo -n "Create directory www [y/n] : "
read www
if [ "$www" = 'y' ]
then
sudo mkdir -p /var/www
echo -n "Create success!"
echo
fi

