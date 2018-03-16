#!/bin/bash
# Author: 1dwayne.mcdaniel@gmail.com
# version 1.0

#Name the target CSV for this document
INPUT=data1.csv

# Whatever the Internal File Sperator token to whatever it is before we run the script
OLDIFS=$IFS
# the Internal File Sperator token to a comma for our CSV
IFS=,

# Check if the input file exists and kill the script if not
[[ ! -f $INPUT ]] && { echo "$INPUT file not found"; exit 99; }

# while in this loop, parce the columns in the CSV as these variables
#	firstname is the new site owner's first name
# 	sitename is the name of the site on Pantheon 
# 	wp_email is the email you want to use for wp-admin
# 	pantheon_email is the email for the end users' Pantheon account
# 	lastname is not actually used but is fille data to safeguard against nasty EOL funkiness
while read  timestamp firstname email otherdata
do
	# Note: only reason I am echoing this is to build another script to do this at scale.  
	# If run as just Terminus commands in loop, it stops after first row for some reason.

wp user create ${firstname} ${email} --role=administrator --quiet

wp comment create --comment_post_ID=22 --comment_content=${otherdata} --comment_author=${firstname} --quiet


# if we are not at the end of the file, we are not done, loop again
done < $INPUT

# after the loop, reset the Internal File Sperator to whatever it was before
IFS=$OLDIFS