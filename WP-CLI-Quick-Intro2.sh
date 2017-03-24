#!/bin/bash

# wpcliexamplesite2

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
wp core install --url=wpcliexamplesite2.c9users.io --title=WP-CLI_DEMO_Test --admin_user=dwayne --admin_password=Password1 --admin_email=dwayne@pantheon.io

# fix the links with search and replace
wp search-replace 'wpcliexamplesite2'  'wpcliexamplesite2-mcdwayne' 


# generate some dummy posts
wp post generate --count=15 --post_date=2001-01-01

# even better let's pull down some LorIpsum filler text and make dummy posts with that
curl loripsum.net/api/5/short/headers/ul/bq | wp post generate --post_content --count=5


# Install a new theme
wp theme install universe --activate

# let's make a new menu
wp menu create "my-menu"

# let's make that the primary menu
wp menu location assign my-menu primary

# Let's go ahead and make that menu link to a known address (google in this case)
wp menu item add-custom my-menu Google http://google.com 

#Install the CIA Emoji widget
wp plugin install https://github.com/1dwaynemcdaniel/CIA-Emoji-WP-Plugin/archive/master.zip --activate
 
# Set the CIA Emoji widget into the Home Sidebar
wp widget add cia_emoji ps2

# Set the background color to #BADA55
wp theme mod set background_color BADA55

# set the tagline to something else
wp option update blogdescription "Thanks for watching my demo of WP-CLI!"
