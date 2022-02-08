#!/bin/bash

# Run at 12 hour intervals for development systems
# Edit these ...
dir1=~/www/tmp
#dir2=~/www/dev2

user=admin

cd $dir1
a=`php7.cli ~/private/tools/cv --user=$user api Job.execute`
if echo $a | grep -qv '"is_error": 0'; then echo $a; echo $dir1; fi

#cd $dir2
#a=`php7.cli ~/private/tools/cv --user=$user api Job.execute`
#if echo $a | grep -qv '"is_error": 0'; then echo $a; echo $dir2; fi
