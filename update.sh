#!/bin/bash

echo -n "Update ALL SERVICE [y/n] : "

read nginx

if [ "$nginx" = 'y' ]

then

echo "processing ..."

sudo yum update -y

sudo yum update epel-release -y

sudo yum update nginx -y

sudo yum update git -y

sudo yum update curl -y 

sudo yum update nodejs -y

sudo yum update npm -y

sudo yum update php -y

sudo yum update mariadb mariadb-server -y

echo "Update completed"

fi
