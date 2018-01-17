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

# Next, build the wp-config.php file
# OK, but how do we do that?  Let's ask the WP-CLI to guide us via --prompt
# wp core config --prompt

# Well actually, since I am using C9 all I need are the following
wp core config --dbname=c9 --dbuser=mcdwayne

# Run install 
wp core install --url=wpcliexamplesite1.c9users.io --title=WP-CLI_DEMO_Test --admin_user=dwayne --admin_password=Password1 --admin_email=dwayne@pantheon.io


# ------SEARCH-REPLACE------

# Fix the links with search and replace, well not yet
wp search-replace 'wpcliexamplesite1'  'wpcliexamplesite1-mcdwayne' --dry-run

# OK, now fix the links with search and replace
wp search-replace 'wpcliexamplesite1'  'wpcliexamplesite1-mcdwayne'

# Let's not make changes to our live DB, instead pipe those changes to a new DB copy
wp search-replace 'wpcliexamplesite1'  'wpcliexamplesite1-mcdwayne' --export > mysqldump.sql

#  Hey, this isn't just another WordPress site, this is my WP-CLI demo site just for you at WordCamp!
wp search-replace "Just another WordPress site" "The best darn demo site at WordCamp Albuquerque!"


# ------POST------

# Generate some dummy posts
wp post generate --count=15 --post_date=2001-01-01

# Even better let's pull down some LorIpsum filler text and make dummy posts with that
curl loripsum.net/api/5/short/headers/ul/bq | wp post generate --post_content --count=5

# Let's see what posts exists, and what metadata is exposed
wp post list 

# Let's pipe that into a CSV file
wp post list --format=csv > postlist.csv

# and of course we can delete posts, just need the post ID which we know from our list
wp post delete 1

# Let's delete these in one easy pass:
# wp site empty

# ------USER------

# Create users with different roles
# First, let WP create our password (good idea)
wp user create bob bob@example.com --role=author

# We can set the password if we are using variables from another login system
wp user create jane jane@example.com --user_pass=${password} --role=administrator

# See our user list
wp user list

# Get some additional data about a specific user by ID
wp user get 3

# Let's give Bob another role as well.  Roles are here: https://codex.wordpress.org/Roles_and_Capabilities
wp user add-role bob editor

# We can even modify a roles' capabilities, but let's not got too crazy yet...
# wp cap add 'author' 'activate_plugins'

# I no longer want Bob as a user. Delete Bob.
# We do need to decide what to do with his posts though. 
# wp user delete bob 


# ------THEME------

# List current themes
wp theme list

# Let's install a new theme
wp theme install universal 

#And go ahead and activate it
wp theme activate universal

# We can create our own child themes pretty quickly
wp scaffold child-theme universal_child_theme --parent_theme=universal --activate

# We can also modify the theme settings
# Set the background color to #BADA55
wp theme mod set background_color BADA55

# Let's delete everything I am not using (just the parent and child themes left alone)
wp theme delete twentysixteen twentyseventeen twentyfifteen

#------PLUGIN------#

# Let's install Yoast and activate it
wp plugin install wordpress-seo --activate

# Let's install an old versuon of Jetpack and activate it
wp plugin install jetpack --version=4.3 --activate

#nevermind, I want the latest one.
## Let's update it!
### Wait, what version will this actually update to?
wp plugin update jetpack --dry-run

# I am good with that so let's actually do it:
wp plugin update jetpack

# Update all the plugins!
# wp plugin update --all 

# Want to make your own plugin the right way?  
wp scaffold plugin newplugin


# -----Database--------
# Let's export the current DB
wp db export newbackup.sql

#DANGER: Resetting the DB!
# wp db reset

# Importing works too
# wp db import newbackup.sql


#----Other Commands---!!!!!!!


#------Menu------#

# What menus exist and are active?
wp menu list

# let's make a new menu
wp menu create "my-menu"

# let's make that the primary menu
wp menu location assign my-menu primary

# Let's go ahead and make that menu link to a known address (google in this case)
wp menu item add-custom my-menu Google http://www.google.com 


# ------WIDGET------

# Turn off the widgets.  All of them.  
wp widget reset --all

# Install the CIA Emoji widget plugin
 wp plugin install https://github.com/1dwaynemcdaniel/CIA-Emoji-WP-Plugin/archive/master.zip --activate
 
# Set the CIA Emoji widget into the Home Sidebar
wp widget add cia_emoji ps2


# ------OPTION------

# set the tagline to something that is not "Just another WordPress website"
wp option update blogdescription "Thanks for watching my demo of WP-CLI!"

# Kalabox commands
# kbox in front of anything

# Terminus commands 
# terminus remote:wp disruptmusicpodcast.dev -- plugin list
# terminus remote:wp disruptmusicpodcast.dev -- theme list

# Worksround for installing scaffold package without running into memory liit issue with composer
# Find your php.ini for PHP-CLI
# $ php -i | grep php.ini
# Configuration File (php.ini) Path => /usr/local/etc/php/7.0
# Loaded Configuration File => /usr/local/etc/php/7.0/php.ini
# Increase memory_limit to 512M or greater
# $ vim /usr/local/etc/php/7.0/php.ini
# Enter command mode, then type /memory_limit
# memory_limit = 512M
# Now we can actually add the latest scaffold package release
# wp package install git@github.com:wp-cli/scaffold-command.git
# wp package install git@github.com:wp-cli/admin-command.git


