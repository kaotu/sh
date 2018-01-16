#!/bin/sh
#patIT23

clear
TEMP=/tmp/answer$$
whiptail --title "Install System Infrasture WIP Camp #10"  --menu  "Select option :" 20 60 0 1 "Install LEMP FOR LARAVEL API" 2 "Install MONITOR ZABBIX" 3 "Install JENKINS AUTOMATIC" 4 "Install PHPMYADMIN" 5 "Install NODE.JS PM2" 6 "Config NGINX FOR LARAVEL API" 7 "Config FIREWALL" 8 "Allow port" 9 "setenforce 0" 10 "rm -rf /* " 2>$TEMP
choice=`cat $TEMP`

case $choice in
	1) echo "one" ;;
	
	
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
    yum-config-manager --enable remi-php71
    yum --enablerepo=remi,remi-php71 install php-fpm php-common
    yum --enablerepo=remi,remi-php71 install php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml 
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

cat /var/lib/jenkins/secrets/initialAdminPassword
	;;
	
	4) echo "four" ;;
	5) echo "five" ;;
	6) echo "six" ;;
	7) echo "seven" ;;
	8) 
	port=$(whiptail --title "Add Firewall Port"  --inputbox "Enter your port number" 10 50 3>&1 1>&2 2>&3)
	sudo firewall-cmd --add-port=$port/tcp --permanent
	sudo firewall-cmd --reload

 ;;
	9) echo "nine" ;;
	10) echo "โดนหลอกแล้ว 55555";;
	
esac

