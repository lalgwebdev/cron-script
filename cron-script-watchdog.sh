#!/bin/bash

# Runs the Lalg-Watchdog to check that Scheduled Jobs don't get disabled.
# Run at 12 hour intervals.  Reports, and tries to correct, all sites.

root=/home/lalg/www/
list="$root""*/"
result=""
user=lalgroot

# Set true to always email the result.  Else will only email if error.
#alwaysemail=false
alwaysemail=true


for dir in $list     		# loop through directories
do
	site=${dir%*/}; site="${site##*/}"	# Strip both ends to leave e.g d9ref, or www
	cd $dir
	dir=${dir%/}
	
	api=""
	if [ $site = "www" ]; then
		api=$(php73.cli ~/private/tools/cv --user=$user api LalgWatchdog.checkon)
	else
		api=$(php73.cli ~/private/tools/cv --user=$user api LalgWatchdog.checkoff)
	fi

	if echo $api | grep -qv '"is_error": 0' ; then		# Is Error, so report full message
		result+=$(pwd)'\n'; result+=${api//','/'\n'}; result+='\n'
		alwaysemail=true								# Override default
	else
		api=${api//','/'\n'}; api=${api/*[}; api=${api%]*}		# Reformat newlines, Trim ends		
		result+=$(grep "$dir" <<< $api)'\n'				# Just report relevant lines
	fi
done

if echo $result | grep -q "ERROR\|WARNING" ; then
	alwaysemail=true							# Override default if error/warning found
fi

if [ $alwaysemail ] ; then
	echo -e $result
fi


