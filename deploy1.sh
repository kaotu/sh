#!/bin/bash

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
echo -n "Change project name : "
read name
echo "cloning project..."
cd /var/www/
git clone $URL $name
cd /var/www/$name
else 
echo -n "What your project name already install? : "
read name
fi

echo -n "git pull update [y/n] : "
read pull
if [ "$pull" = 'y' ]
then
git pull
echo "completed"
fi
cd /var/www/$name/
#sudo npm install pdfkit -save
#sudo npm install
#sudo npm update

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
sudo npm install pdfkit -save
sudo npm install
sudo npm update
sudo npm install pm2 -g

sudo pm2 start npm -- start
sudo pm2 list
echo "pm2 process completed"
fi

echo -n "restart nginx [y/n] : "
read nginx
if [ "$nginx" = 'y' ]
then
echo "processing ..."
sudo systemctl restart nginx
echo "restart completed"
fi

#setsebool
setsebool -P httpd_can_network_connect 1


#sudo yum install policycoreutils-python
#sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/Hobbyforfun(/.*)?"
#sudo restorecon -vR /var/www/Hobbyforfun
