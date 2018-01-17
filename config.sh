#!/bin/bash

cd /etc/nginx/conf.d

echo -n "Create new .conf[y/n] :"
read new
while [ "$new" != "y" ] && [ "$new" != "n" ]
do
echo -n "Create new .conf[y/n] :"
read new
done

if [ "$new" = 'y' ]
then 
echo -n "What name file config :"
read file
nano $file.conf
echo -n $vhost >> /etc/nginx/conf.d/$file/ 
else
echo -n "What file's name already config ? :"
read name
nano $name
fi


