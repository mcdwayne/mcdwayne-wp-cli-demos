#!/bin/bash

#The Racing Script!

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

sudo mv wp-cli.phar /usr/local/bin/wp

wp core download

wp core config --dbname=mysql --dbuser=root

wp core install --url=http://wp-cli-1dwaynemcdaniel657003.codeanyapp.com/ --title=WP-CLI --admin_user=dwayne --admin_password=Password1 --admin_email=1dwayne.mcdaniel@gmail.com

wp search-replace 'Hello world'  'What is your favorite talk so far?'

wp search-replace 'Just another WordPress site'  'WCSTL ROCKS!!!!!' --precise

wp theme install 90s-retro --activate

wp theme mod set background_color BADA55

curl http://baseballipsum.apphb.com/api/?paras=10 | wp post generate --post_content --count=5

wp menu create "my-menu"

wp menu location assign my-menu main-menu

wp menu item add-custom my-menu mcdwayne.com https://www.mcdwayne.com 

wp menu item add-custom my-menu twitter https://twitter.com/McDwayne

wp menu item add-custom my-menu Google https://www.google.com 

wp menu item add-custom my-menu Email mailto:1dwayne.mcdaniel@gmail.com

wp plugin install gutenberg magic-food blackjack-lite --activate

wp post create --post_title='Magic Food'  --post_content=' [magicfood] ' --post_status=publish

wp post create --post_title='Blackjack' --post_content=' [blackjack] ' --post_status=publish

wp language core install  zh_HK --activate

wp plugin update --all 
