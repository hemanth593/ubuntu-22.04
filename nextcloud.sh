apt update && apt upgrade -y
apt install unzip 
apt-get install nginx mysql-server
sudo apt install apache2 libapache2-mod-php php-gd php-mysql php-curl php-mbstring php-intl php-gmp php-bcmath php-xml php-imagick php-zip php-fpm php-opcache php-json php-common -y
mysql --version
systemctl start mysql
systemctl enable mysql
systemctl status mysql
mysql -u root
CREATE DATABASE nextcloud;
CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'YOURPASSWORD';
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';
FLUSH PRIVILEGES;
exit;
nginx -v
systemctl start nginx
systemctl enable nginx
systemctl status nginx
wget https://download.nextcloud.com/server/releases/latest.zip -P /var/www/
cd /var/www/
unzip -q latest.zip
rm latest.zip
chown -R www-data:www-data nextcloud
cd /etc/nginx/sites-available/
rm default
cd /etc/nginx/sites-enabled/
rm default
cp `find $HOME -name ubuntu-22.04  2>/dev/null`/nextcloud nextcloud

systemctl restart nginx
apt-get install redis-server php-redis
systemctl start redis-server
systemctl enable redis-server
systemctl status redis-server
cd /etc/redis/
echo "unixsocket /var/run/redis/redis-server.sock" >> redis.conf
echo "unixsocketperm 770" >> redis.conf

systemctl restart redis-server
usermod -a -G redis www-data
cd /var/www/nextcloud/config/

nano config.php

'memcache.distributed' => '\OC\Memcache\Redis',
'memcache.locking' => '\OC\Memcache\Redis',
'redis' => [
        'host'      => '/run/redis/redis-server.sock',
        'port'      => 0,
],

systemctl restart php8.1-fpm 
