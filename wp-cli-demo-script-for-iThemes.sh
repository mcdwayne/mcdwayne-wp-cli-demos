#!/bin/bash

# For C9 users, enable mysql
# mysql-ctl install


# Download the WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#check to make sure it worked
php wp-cli.phar --info

# make it executable
chmod +x wp-cli.phar

# set file to path :$wp
sudo mv wp-cli.phar /usr/local/bin/wp


# ------CORE------

#  download WordPress
wp core download

# Build the wp-config.php file
# OK, but how do we do that?  Let's ask the WP-CLI to guide us via --prompt
# wp core config --prompt

# Since I am using C9 all I need are the following
wp core config --dbname=c9 --dbuser=mcdwayne

# Run install 
wp core install --url=wpcliexamplesite1.c9users.io --title=WP-CLI_DEMO_Test --admin_user=dwayne --admin_password=Password1 --admin_email=dwayne@pantheon.io

# ------SEARCH-AND-REPLACE------

# Fix the links with search and replace, well not yet
wp search-replace 'wpcliexamplesite1'  'wpcliexamplesite1-mcdwayne' --dry-run

# OK, now fix the links with search and replace
wp search-replace 'wpcliexamplesite1' 'wpcliexamplesite1-mcdwayne'

# ------POSTS------

# Generate some dummy posts
wp post generate --count=15 --post_date=2001-01-01

# List out the current posts
wp post list

# Better yet, let’s export to a CSV with --format=CSV
wp post list --format=csv > postlist.csv

# Let's delete some posts using the post IDs (which we know from the list)
wp post delete 1 2 3


# ------USERS------

# Create users with different roles
# First let's have WP generate the password
wp user create bob bob@example.com --role=author
# Now let's set the password manually (not the safest option)
wp user create jane jane@example.com --user_pass=“password” --role=administrator

# I want to get all user info about a particular user, and I know the user_login
wp user get bob

# Add a new role to an existing user
# For reference: https://codex.wordpress.org/Roles_and_Capabilities
wp use add role bob editor

# let's go ahead and delete a user based on user_login
wp user delete jane 
# you can keep or delete all posts, there will be a prompt


# ------THEMES------

# List current themes
wp theme list

# Let's install a new theme
wp theme install twentyten

# Now let's activate it
wp theme activate twentyten

# Let's delete all unused themes (best practice)
wp theme delete twentyfifteen twentysixteen twentyseventeen

# We can create our own child themes pretty quickly (best practice before modifying)
wp scaffold child-theme twentyten_child_theme --parent_theme=twentyten --activate


#------PLUGINS------#

# Install a plugin, specifying a specific version, and activate it all in one step.
wp plugin install jetpack --version=4.7 --activate

# Update the out of date plugins.  For this demo I am just updating --all
# this would be a great time to use --dry-run
wp plugin update --all

# We can again use 'scaffold' to create a template plugin like we made a child theme.  This includes testing folders already set up.  See: https://developer.wordpress.org/cli/commands/scaffold/plugin/
wp scaffold plugin mynewplugin	

# -----Database-------

# What DB dables are in my DB?  Theres a command for that.
wp db tables 

# Make an export of my whole DB
# Using the flag --porcelain to make it spit out the file name it wrote
wp db export --porcelain

# Let's access the MySQL-CLI through WP-CLI
wp db cli


#DANGER: Resetting the DB!
# wp db reset

## Other CLIs that use WP-CLI

# Kalabox commands
# kbox in front of anything

# Terminus commands 
# terminus remote:wp sitename.env -- plugin list
# terminus remote:wp sitename.env -- theme list



