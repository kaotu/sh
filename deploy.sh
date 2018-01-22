#!/bin/bash
#Text Colour
Green='\033[1;32m'
Red='\033[0;31m'
Yellow='\033[0;33m'
NC='\033[0m'

	sudo clear
	printf "
				####################################
				##                                ##
				##         Deploy Project         ##
				##                                ##
				##   Infrastructure Wip Camp#10   ##
				##                                ##
				##           version 1.0          ##   
				##                                ##
				##                                ##
				####################################
	"
	echo
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
		
		echo
		echo -n -e "${Green}Cloning project...${NC}"
		echo

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
		echo
		echo -e "${Green}completed${NC}"
		echo
	   fi

	cd /var/www/$name/
	echo -n "deploy project[y/n] : "
	   read deploy
	   while [ "$deploy" != "y" ] && [ "$deploy" != "n" ]
	   do
		echo -n "deploy project[y/n] :   "
		read deploy
	   done

		echo -n "deploy react(node.js)[y/n] : "
		read deploy
		   if [ "$deploy" = 'y' ]
		      then
		      echo
		      echo -n -e "${Green}installing pm2${NC}"
		      echo
		      sudo npm install pdfkit -save
		      sudo npm install
 		      sudo npm update
		      sudo npm install pm2 -g
		      sudo pm2 start npm -- start
		      sudo pm2 list
		echo
		echo -e "${Green}start pm2 completed${NC}"
		echo
		   elif [ "$deploy" = 'n' ]
	 	      then
		     echo
		     echo -n -e "${Green}Not use node.js${NC}"
		     echo
		     fi

		echo -n "deploy react(nextjs)[y/n] : "
		   read deploy
			if [ "$deploy" = 'y' ]
			   then
			      sudo npm install
			      sudo npm run build
			      sudo npm install pm2 -g
		              sudo pm2 delete WIPCamp
		              sudo pm2 start npm --name "WIPCamp" -- run start
			elif [ "$deploy" = 'n' ]
			   then
			   echo
			   echo -n -e "${Green}Not use next.js${NC}"
			   echo
			fi


		echo -n "restart nginx [y/n] : "
		   read nginx
		      if [ "$nginx" = 'y' ]
			then
			   echo
		           echo -e "${Green}processing ...${NC}"
			   echo
			   sudo systemctl restart nginx
			   echo "restart completed"
		      fi

#setsebool
#setsebool -P httpd_can_network_connect 1

#sudo yum install policycoreutils-python
#sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/_(/.*)?"
#sudo restorecon -vR /var/www/
