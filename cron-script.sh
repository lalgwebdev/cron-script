#!/bin/bash

# Run at 15 minutes intervals for Live system.
# Edit these ...
dir1=~/www/www

user=admin

cd $dir1
a=`php7.cli ~/private/tools/cv --user=$user api Job.execute`
if echo $a | grep -qv '"is_error": 0'; then echo $a; echo $dir1; fi

