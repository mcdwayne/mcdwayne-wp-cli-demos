#!/bin/bash

#The Racing Script!

# wpcliexamplesite1

# Download the WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# make it executable
chmod +x wp-cli.phar

# set file to path so we only have to type `$ wp`
sudo mv wp-cli.phar /usr/local/bin/wp

# ------CORE------

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

# OK, now fix the links with search and replace
wp search-replace 'Hello world'  'This is the first demo post'

# That was fun.  Again!  BUt this time instead of the DB let's look through PHP
wp search-replace 'Just another WordPress site'  'WCMIA ROCKS!!!!!' --precise

# ------THEME------

# List current themes
wp theme list

# Let's install a new theme and activate it
wp theme install 90s-retro --activate

# We could have also activated it seperately
# wp theme activate 90s-retro 

# We can also modify the theme settings
# Set the background color to #BADA55
wp theme mod set background_color BADA55


# ------POST------

# Generate some dummy posts
wp post generate --count=15 --post_date=2001-01-01

# Even better let's pull down some LorIpsum filler text and make dummy posts with that
curl http://baseballipsum.apphb.com/api/?paras=10 | wp post generate --post_content --count=5


#------Menu------#

# let's make that the primary menu
wp menu location assign my-menu main-menu

# Let's go ahead and make that menu link to a known address (google in this case)
wp menu item add-custom my-menu mcdwayne.com https://www.mcdwayne.com 

wp menu item add-custom my-menu twitter https://twitter.com/McDwayne

wp menu item add-custom my-menu Google https://www.google.com 

wp menu item add-custom my-menu Email mailto:1dwayne.mcdaniel@gmail.com


#------PLUGIN------#

#  Might as well get Gutenberg too :)
wp plugin install gutenberg --activate

#Update all the plugins!
wp plugin update --all 

# OK, let's make this a bit more interesting
# but first we need a plugin:
wp plugin install blackjack-lite --activate

# now create a post with the short tag for that plugin capability
wp post create --post_content=' [blackjack] ' --post_status=publish

# AGAIN but with an even different game!  
wp plugin install magic-food --activate
wp post create --post_title='Magic Food'  --post_content=' [magicfood] ' --post_status=publish

# Change the language to Hong Kong Chinese
wp language core install  zh_HK --activate

