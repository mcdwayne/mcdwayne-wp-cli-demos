#!/bin/bash

# Name the site: wpcliexamplesite2


# Install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp


# Install MySQL
mysql-ctl install

# Install WP
wp core download

wp core config --dbname=c9 --dbuser=mcdwayne

wp core install --url=wpcliexamplesite1.c9users.io --title=WP-CLI_Kalabox_Pantheon_Test --admin_user=dwayne --admin_password=Password1 --admin_email=dwayne@pantheon.io

#fix the links
wp search-replace 'wpcliexamplesite2'  'wpcliexamplesite2-mcdwayne' 
 
 
# Let's pull down some LorIpsum filler text and make dummy posts with that
curl loripsum.net/api/5/short/headers/ul/bq | wp post generate --post_content --count=5
