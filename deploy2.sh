#!/bin/bash

yum update
sudo yum install nano -y
sudo yum install epel-release -y
sudo yum install nginx -y
sudo systemctl start nginx 
sudo systemctl enable nginx 
sudo yum install git -y
sudo yum install curl sudo
sudo curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
sudo sudo yum install nodejs -y
sudo yum install npm -y
cd /var/www/

echo -n "Do you have git project(clone)[y/n]: "
read clone
while [ "$clone" != "y" ] && [ "$clone" != "n" ]
do
echo -n "Do you have git project(clone)[y/n]: "
read clone
done

if [ "$clone" = 'y' ]
then
echo -n "Enter your repository URL : "
read URL
echo -n "change project name : "
read name
echo "cloning project..."
cd /var/www/
git clone $URL $name
cd /var/www/$name
fi

echo -n "git pull update [y/n] : "
read pull
if [ "$pull" = 'y' ]
then
git pull
echo "completed"
fi
cd /var/www/10X/
sudo npm install pdfkit -save -y
sudo npm install -y
sudo npm update -y

echo -n "deploy project[y/n] :  "
read deploy
while [ "$deploy" != "y" ] && [ "$deploy" != "n" ]
do
echo -n "deploy project[y/n] :   "
read deploy
done

if [ "$deploy" = 'y' ]
then
echo -n "installing pm2"
sudo npm install pm2 -g
sudo npm start
sudo pm2 start npm -- start
echo "pm2 process completed"
fi

echo -n "restart nginx [y/n] : "
read nginx
if [ "$nginx" = 'y' ]
then
echo "processing ..."
sudo systemctl restart nginx -y
echo "restart completed"
fi
