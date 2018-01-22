#!/bin/sh
#patIT23&InfrastructureWIPCamp10

clear
TEMP=/tmp/answer$$
Danger='\033[1;31m'
Warn='\033[1;33m'
Complete='\033[1;32m'
End='\033[0m'

whiptail --title "Install System Infrastructure WIP Camp#10"  --menu  "Select option :" 20 60 0 1 "Install LEMP for LARAVEL API" 2 "Install Monitor Zabbix" 3 "Install Jenkins Automatic" 4 "Install PhpMyAdmin" 5 "Install Node.js & pm2" 6 "Config Nginx for React project" 7 "Config Nginx for LARAVEL API" 8 "Allow port" 9 "Deploy React project" 10 "Install.sh" 2>$TEMP
choice=`cat $TEMP`

case $choice in
	1) echo "
 	#################################
                Install LEMP stack
        #################################
	"
    sudo yum install epel-release wget -y
    sudo yum -y install net-tools
    sudo yum -y update
    sudo yum install nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
    sudo sh port.sh
    sudo echo 
    sudo echo -e "${Complete}Network status${End}"
    sudo netstat -plntu
    sudo echo
sleep 5
    sudo wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
    sudo rpm -Uvh remi-release-7.rpm
    sudo yum install yum-utils -y
    sudo echo 
    sudo echo -e "${Complete}Installing PHP...${End}"
    sudo yum-config-manager --enable remi-php72
    sudo yum --enablerepo=remi,remi-php72 install php-fpm php-common
    sudo yum --enablerepo=remi,remi-php72 install php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php$
    sudo echo
    sudo echo -e "${Complete}PHP version${End}"
    sudo php --version
    sudo echo

    #Config
    sudo rm -v /etc/php.ini
    sudo cp /config/php.ini /etc 
    sudo rm -v /etc/php-fpm.d/www.conf
    sudo cp /config/www.conf /etc/php-fpm.d/
    sudo systemctl start php-fpm
    sudo systemctl enable php-fpm
    sudo echo
    sudo echo -e "${Complete}Check php-fpm${End}"
    sudo netstat -pl | grep php-fpm.sock
    sudo echo
    sudo echo -e "${Complete}MariaDB Installation${End}"
    sudo yum install mariadb-server mariadb -y
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
    sudo echo -e ">>>>>${Warn}Please configure the root password for MariaDB later${End}<<<<<"
    sudo echo "Command : mysql_secure_installation"
    sudo echo
    sudo echo -e ">>>>>${Complete}PHP Composer${End}<<<<<"
    sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/bin --filename=composer
    sudo composer
    sudo echo 
    sudo echo -e ">>>>>${Complete}Complete install LEMP stack${End}<<<<<"
    sudo echo  
;;
	2) 	echo "
	#################################
	         Install Zabbix
	#################################
	"
    yum install epel-release wget -y
    yum -y update
    wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
    rpm -Uvh remi-release-7.rpm
    yum install yum-utils -y
    yum-config-manager --enable remi-php72
    yum --enablerepo=remi,remi-php72 install php-fpm php-common
    yum --enablerepo=remi,remi-php72 install php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml 
    yum install mariadb-server mariadb -y
    systemctl start mariadb 
    systemctl enable mariadb 
    
    mysql_secure_installation
    firewall-cmd --permanent --add-port=10050/tcp
    firewall-cmd --permanent --add-port=10051/tcp
    firewall-cmd --permanent --add-port=80/tcp
    firewall-cmd --reload
    systemctl restart firewalld
    rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
    yum install -y zabbix-server-mysql zabbix-web-mysql mariadb-server
    setsebool -P httpd_can_connect_zabbix on
    cusers=$(whiptail --title "Create User DB "  --inputbox "Enter Usersr" 10 50 3>&1 1>&2 2>&3)
        PASS=`pwgen -s 15 1`
        passdb=$(whiptail --title "MySQL Root Password"  --inputbox "Enter root Password" 10 50 3>&1 1>&2 2>&3)

mysql -uroot -p$passdb<<MYSQL_SCRIPT
CREATE DATABASE $cusers;
CREATE USER '$cusers'@'localhost' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON $cusers.* TO '$cusers'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT
	echo "
	#################################
		  Config Zabbix
	#################################
	"
echo "MySQL user created."
echo "Username:   $cusers"
echo "DBName:   $cusers"
echo "Password:   $PASS"


    ;;	
	3) 	echo "
	#################################
		  Update System
	#################################
	"
	sleep 5 
		sudo yum install -y epel-release
		sudo yum update
		yum  install -y wget
		echo "
	#################################
		  Install JAVA
	#################################
	"
	sleep 5 	
		sudo yum install java-1.8.0-openjdk.x86_64
		java -version
		sleep 5
		sudo cp /etc/profile /etc/profile_backup
		echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
		echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
		source /etc/profile
		echo $JAVA_HOME
		echo $JRE_HOME
		cd ~ 
		echo "
	#################################
		  Install jenkins
	#################################
	"
	sleep 5 
		sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
		sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
		yum install -y jenkins
		sudo systemctl start jenkins.service
		sudo systemctl enable jenkins.service
		sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
		sudo firewall-cmd --reload
		echo "
	#################################
		  Install NGINX
	#################################
	"
	sleep 5 
	sudo yum install -y nginx
	sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
	sudo firewall-cmd --reload	
	echo "
	#################################
		  Config NGINX
	#################################
	"
	sleep 5 
	sudo mkdir /etc/nginx/sites-available
	sudo mkdir /etc/nginx/sites-enabled
	
	
	rm -r /etc/nginx/nginx.conf
	cat > /etc/nginx/nginx.conf <<EOF
	
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    include /etc/nginx/conf.d/*.conf;

    include /etc/nginx/sites-enabled/*.conf;
    server_names_hash_bucket_size 64;	

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

}
EOF
    	sudo rm -r /etc/nginx/conf.d/jenkins.conf
        cat > /etc/nginx/conf.d/jenkins.conf <<EOF


upstream jenkins{
    server _:8080;
}

server{
    listen      80;
    server_name _;

    access_log  /var/log/nginx/jenkins.access.log;
    error_log   /var/log/nginx/jenkins.error.log;

    proxy_buffers 16 64k;
    proxy_buffer_size 128k;

    location / {
        proxy_pass  http://jenkins;
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        proxy_redirect off;

        proxy_set_header    Host            $host;
        proxy_set_header    X-Real-IP       $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Proto http;
    }

}
EOF
    sudo echo
    sudo echo -e "${Complete}Edit server and server_name of Jenkins at /etc/nginx/conf.d${End}"

cat /var/lib/jenkins/secrets/initialAdminPassword
	;;
	
	4) echo "phpMyAdmin ท่านต้องโหลดเองแล้ว ท่านวิปโป้" ;;
	5) 
	echo "	
	###############################
              Install node.js pm2
        ###############################
        "
	sleep 5

        sudo yum install curl -y
        sudo curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
        sudo sudo yum install nodejs -y
        sudo yum install npm -y

        sudo npm install
        sudo npm update
        sudo npm install pm2 -g
	;;

	6)  echo
            echo "
        ##################################
          Config nginx for react project
        ##################################
        "
        echo
	sudo rm -v /etc/nginx/conf.d/react.conf
        sudo cp config/react.conf /etc/nginx/conf.d
	sudo echo -e "${Complete}Complete${End}"
	sudo echo
	;;
	7)  echo
            echo "
        ##################################
         Config nginx for Laravel project
        ##################################
        "
        echo
        sudo rm -v /etc/nginx/conf.d/api.conf
        sudo cp config/api.conf /etc/nginx/conf.d
        sudo echo -e "${Complete}Complete${End}"
        sudo echo
        ;;

	8)
	port=$(whiptail --title "Add Firewall Port"  --inputbox "Enter your port number" 10 50 3>&1 1>&2 2>&3)
	echo
	echo "
        #################################
                  Allow Port
        #################################
        "
        echo
	echo  "Open port : " $port
	sudo firewall-cmd --add-port=$port/tcp --permanent
	echo
	echo -e "${Warn}Reloading port...${End}"
	sudo firewall-cmd --reload
	echo
	echo -e "${Complete}Port is opened${End}"
	sudo firewall-cmd --list-port
	echo
	;;

	9) sudo sh deploy.sh
	;;

	10)sudo echo "
        #################################
                  Install.sh
        #################################
        "
        sudo echo       
	sudo sh install.sh
	;;
esac

