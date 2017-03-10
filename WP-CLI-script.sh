#!/bin/bash

# wpcliexamplesite1

# install mysql (specific step for to C9, most of time this will already be installed)
mysql-ctl install

# Download the WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#check to make sure it worked
php wp-cli.phar --info

# make it executable
chmod +x wp-cli.phar

# set file to path :$wp
sudo mv wp-cli.phar /usr/local/bin/wp


#  download WordPress
wp core download

# build the wp-config.php file
wp core config --dbname=c9 --dbuser=mcdwayne

# run install 
wp core install --url=wpcliexamplesite1.c9users.io --title=WP-CLI_DEMO_Test --admin_user=dwayne --admin_password=Password1 --admin_email=dwayne@pantheon.io

# fix the links with search and replace
wp search-replace 'wpcliexamplesite1'  'wpcliexamplesite1-mcdwayne' 

# Turn off the widgets.  All of them
wp widget reset --all

# generate some dummy posts
wp post generate --count=15 --post_date=2001-01-01

# even better let's pull down some LorIpsum filler text and make dummy posts with that
curl loripsum.net/api/5/short/headers/ul/bq | wp post generate --post_content --count=5

# create users with different roles
wp user create bob bob@example.com --role=author
wp user create jane jane@example.com --user_pass=“password” --role=administrator

# Install a new theme
wp theme install https://downloads.wordpress.org/theme/primer.1.3.0.zip 

# Activate it
wp theme activate primer

# Let's install a new theme and go ahead and activate it
wp theme install universal --activate

# Let's install WooCommerce and activate it
wp plugin install woocommerce
wp plugin activate woocommerce

# Let's install Jetpack and activate it
wp plugin install jetpack --activate

# wp plugin install wordfence duplicator

# wp plugin install WHAT ARE YOUR FAVES?

# What menus exist and are active?
wp menu list

# let's make a new menu
wp menu create "my-menu"

# let's make that the primary menu
wp menu location assign my-menu primary

# Let's go ahead and make that menu link to a known address (google in this case)
wp menu item add-custom my-menu Google http://google.com 

# Terminus commands 
# terminus remote:wp wpclidemosite22.dev -- plugin update --all --dry-run
# terminus remote:wp wpclidemosite22.dev -- theme update --all --dry-run

# Kalabox commands
# kbox in front of anything

