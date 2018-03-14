#!/bin/bash

# wpcliexamplesite1

#  (Almost) Everything is from http://wp-cli.org/

# Download the WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#check to make sure it worked  (This step is 100% optional)
php wp-cli.phar --info

# make it executable
chmod +x wp-cli.phar

# set file to path so we only have to type `$ wp`
sudo mv wp-cli.phar /usr/local/bin/wp

# WP-CLI is now installed!!!!
# Now, what do we do with it?

# ------CORE------

# https://developer.wordpress.org/cli/commands/core/

#  download WordPress
wp core download

# build the wp-config.php file
# OK, but how do we do that?  Let's ask the WP-CLI to guide us via --prompt
# wp core config --prompt

# Well actually, since I am using C9 all I need are the following
wp core config --dbname=mysql --dbuser=root

# Run install 
wp core install --url=http://wp-cli-1dwaynemcdaniel657003.codeanyapp.com/ --title=WP-CLI --admin_user=dwayne --admin_password=Password1 --admin_email=1dwayne.mcdaniel@gmail.com


# ------SEARCH-REPLACE------

# https://developer.wordpress.org/cli/commands/search-replace/

# Fix the links with search and replace, well not yet
wp search-replace 'Hello world'  'This is the first demo post' --dry-run

# OK, now fix the links with search and replace
wp search-replace 'Hello world'  'This is the first demo post'

# That was fun.  Again!  BUt this time instead of the DB let's look through PHP
wp search-replace 'Just another WordPress site'  'WCMIA ROCKS!!!!!' --precise

# Let's not make changes to our live DB, instead pipe those changes to a new DB copy
wp search-replace 'http://wp-cli-demo-box-1dwaynemcdaniel657003.codeanyapp.com/'  'https://testsite.com' --export > mysqldump.sql

# ------THEME------

# https://developer.wordpress.org/cli/commands/theme/

# List current themes
wp theme list

# Let's install a new theme and activate it
wp theme install 90s-retro --activate

# We could have also activated it seperately
# wp theme activate 90s-retro 

# We can also modify the theme settings
# Set the background color to #BADA55
wp theme mod set background_color BADA55

# Let's delete everything I am not using (just the parent and child themes left alone)
wp theme delete twentyseventeen twentyfifteen


# ------POST------

# https://developer.wordpress.org/cli/commands/post/

# Generate some dummy posts
wp post generate --count=15 --post_date=2001-01-01

# Even better let's pull down some LorIpsum filler text and make dummy posts with that
curl http://baseballipsum.apphb.com/api/?paras=10 | wp post generate --post_content --count=5

# Let's see what posts exists, and what metadata is exposed
wp post list 

# Let's pipe that into a CSV file
wp post list --format=csv > postlist.csv

# and of course we can delete posts, just need the post ID which we know from our list
wp post delete 2

# Let's delete these in one easy pass:
# wp site empty




#------Menu------#

# https://developer.wordpress.org/cli/commands/menu/


# What menus exist and are active?
wp menu list

# let's make a new menu
wp menu create "my-menu"

# let's make that the primary menu
wp menu location assign my-menu main-menu

# Let's go ahead and make that menu link to a known address (google in this case)
wp menu item add-custom my-menu mcdwayne.com https://www.mcdwayne.com 

wp menu item add-custom my-menu twitter https://twitter.com/McDwayne

wp menu item add-custom my-menu Google https://www.google.com 

wp menu item add-custom my-menu Email mailto:1dwayne.mcdaniel@gmail.com


#------PLUGIN------#

# https://developer.wordpress.org/cli/commands/plugin/

# Let's install wp-cfm and activate it
wp plugin install wp-cfm --activate

#  Might as well get Gutenberg too :)
wp plugin install gutenberg --activate

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

# OK, let's make this a bit more interesting
# but first we need a plugin:
wp plugin install magic-food --activate

# now create a post with the short tag for that plugin capability
wp post create --post_title='Magic Food'  --post_content=' [magicfood] ' --post_status=publish

# AGAIN but with an even different game!  
wp plugin install blackjack-lite --activate
wp post create --post_content=' [blackjack] ' --post_status=publish



# ------USER------

# https://developer.wordpress.org/cli/commands/user/

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


# -----Database--------

# https://developer.wordpress.org/cli/commands/db/

# What tables de we got here?
wp db tables

# Let's export the current DB
wp db export newbackup.sql

# I really want to get into my MySQL command line for some reason
# wp db cli


#DANGER: Resetting the DB!
# wp db reset

# Importing works too
# wp db import newbackup.sql


#----OTHER COOL Stuff------


# ------SCAFFOLD----
# https://developer.wordpress.org/cli/commands/scaffold/


# We can create our own child themes pretty quickly
wp scaffold child-theme 2016-child --parent_theme=twentysixteen


# Want to make your own plugin the right way?  
wp scaffold plugin newplugin

# Want to get your plugin Gutenberg ready?  Scaffold the Block folders
wp scaffold block blackjack-lite-block --title="blackjack-lite-block" --plugin=blackjack-lite



#------Language------#



# What languages can we install?
wp language core list

# Let's flip the site's language over to Dutch
wp language core install  zh_HK --activate

# Let's check to see what languages we have installed
wp language core list --status=installed



# ------OPTION------

# set the tagline to something that is not "Just another WordPress website"
wp option update blogdescription "Thanks for watching my demo of WP-CLI!"
