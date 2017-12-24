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
