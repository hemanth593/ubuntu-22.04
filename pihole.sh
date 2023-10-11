adduser user1
usermod -aG sudo user1
su - user1
sudo ls -la /root
sudo su
curl -sSL https://install.pi-hole.net | bash
service lighttpd stop
apt-get -y install nginx php7.4-fpm php7.4-cgi php7.4-xml php7.4-sqlite3 php7.4-intl apache2-utils
systemctl disable lighttpd
systemctl enable php7.4-fpm
systemctl enable nginx
cd /etc/nginx/sites-enabled/
cp default /home/user1/
#nano pihole 
cp `find $HOME -name ubuntu-22.04  2>/dev/null`/pihole pihole
htpasswd -c /etc/nginx/.htpasswd user1
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
usermod -aG pihole www-data
service php7.4-fpm start
Start nginx web server
service nginx start
