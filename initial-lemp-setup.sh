#!/bin/bash

DLPATH='https://github.com/kostin/initial-lemp-setup/raw/master'

yum -y install epel-release
sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
yum update

rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
yum install -y php55w-common php55w-opcache php55w-cli php55w-fpm php55w-gd php55w-mbstring php55w-mcrypt php55w-mysql php55w-pdo php55w-xml

rpm -Uvh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
yum install -y nginx

cd /etc
  wget -N $DLPATH/php-cli.ini
	echo "#!/bin/bash" > /etc/profile.d/php-cli.sh
	echo 'alias php="php -c /etc/php-cli.ini"' >> /etc/profile.d/php-cli.sh
	
cd /etc/php-fpm.d	
  cp www.conf www.conf.dist
	wget -N $DLPATH/www.conf

cd /etc/nginx
  cp nginx.conf nginx.conf.dist
	wget -N $DLPATH/nginx.conf
	mkdir -p /var/www/html
	chown nginx:nginx /var/www/html
	rename .conf .conf.dist /etc/nginx/conf.d/*.conf
	#HOST=`hostname`
	#sed -i "s/HOSTNAME/$HOST/" /etc/nginx/nginx.conf

service php-fpm restart
chkconfig php-fpm on
service nginx restart
chkconfig nginx on
