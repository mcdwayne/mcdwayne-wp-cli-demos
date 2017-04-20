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

# WP-CLI is now installed!!!!
# Now, what do we do with it?

# ------CORE------

#  download WordPress
wp core download

# build the wp-config.php file
wp core config --dbname=c9 --dbuser=mcdwayne

# run install 
wp core install --url=wpcliexamplesite1.c9users.io --title=WP-CLI_DEMO_Test --admin_user=dwayne --admin_password=Password1 --admin_email=dwayne@pantheon.io


# ------SEARCH-AND-REPLACE------

# fix the links with search and replace
wp search-replace 'wpcliexamplesite1'  'wpcliexamplesite1-mcdwayne' 


# ------POSTS------

# generate some dummy posts
wp post generate --count=15 --post_date=2001-01-01

# even better let's pull down some LorIpsum filler text and make dummy posts with that
curl loripsum.net/api/5/short/headers/ul/bq | wp post generate --post_content --count=5


# ------USERS------

# create users with different roles
wp user create bob bob@example.com --role=author
wp user create jane jane@example.com --user_pass=“password” --role=administrator

# Delete Bob
wp user delete bob 


# ------THEMES------

# List current themes
wp theme list

# Install a new theme
wp theme install https://downloads.wordpress.org/theme/primer.1.3.0.zip 

# Activate it
wp theme activate primer

# Let's install a new theme and go ahead and activate it
wp theme install universal --activate

# We can create our own child themes pretty quickly
wp scaffold child-theme universal_child_theme --parent_theme=universal --activate

# We can also modify the theme settings
# Set the background color to #BADA55
wp theme mod set background_color BADA55

# set the tagline to something else
wp option update blogdescription "Thanks for watching my demo of WP-CLI!"



#------PLUGINS------#

# Let's install WooCommerce and activate it
wp plugin install wordpress-seo
wp plugin activate wordpress-seo

wp plugin install wordfence duplicator --activate

# Let's install an old versuon of Jetpack and activate it
wp plugin install jetpack --version=4.3 --activate

#nevermind, let's update it!
wp plugin update jetpack

# wp plugin install WHAT ARE YOUR FAVES?




#------Menus------#

# What menus exist and are active?
wp menu list

# let's make a new menu
wp menu create "my-menu"

# let's make that the primary menu
wp menu location assign my-menu primary

# Let's go ahead and make that menu link to a known address (google in this case)
wp menu item add-custom my-menu Google http://www.google.com 


# ------WIDGETS------

# Turn off the widgets.  All of them.  
wp widget reset --all

# Install the CIA Emoji widget plugin
 wp plugin install https://github.com/1dwaynemcdaniel/CIA-Emoji-WP-Plugin/archive/master.zip --activate
 
# Set the CIA Emoji widget into the Home Sidebar
wp widget add cia_emoji ps2

# -----Database-------
# Let's export the current DB
wp db export

#DANGER: Resetting the DB!
# wp db reset

# Kalabox commands
# kbox in front of anything

# Terminus commands 
# terminus remote:wp disruptmusicpodcast.dev -- plugin list
# terminus remote:wp disruptmusicpodcast.dev -- theme list


