#!/bin/bash


sudo apt-get update
sudo apt-get install apache2 -y

sudo systemctl start apache2
sudo systemctl enable apache2

sleep 20

sudo wget https://wordpress.org/wordpress-5.7.2.tar.gz
sudo tar -xzf wordpress-5.7.2.tar.gz
sudo cp -r wordpress/* /var/www/html/

sleep 20

# Setting correct permissions
sudo chown -R www-data:www-data /var/www/html/

# Install PHP and necessary extensions
sudo apt-get install php php-cli php-pdo php-fpm php-json php-mysql -y

# Restart Apache to load new configurations
sudo systemctl restart apache2

# Remember to configure wp-config.php with your database details
sudo apt update
sudo apt install php php-cli php-pdo php-fpm php-json php-mysql -y
sudo systemctl restart apache2

