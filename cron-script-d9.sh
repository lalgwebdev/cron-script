#!/bin/bash

# Run at 12 hour intervals for development systems
# Edit these ...

dir1=~/www/d9ref/web
dir2=~/www/d9dev1/web
dir3=~/www/d9dev2/web

user=lalgroot

cd $dir1
a=`php73.cli ~/private/tools/cv --user=$user api Job.execute`
if echo $a | grep -qv '"is_error": 0'; then echo $a; echo $dir1; fi

cd $dir2
a=`php73.cli ~/private/tools/cv --user=$user api Job.execute`
if echo $a | grep -qv '"is_error": 0'; then echo $a; echo $dir2; fi

cd $dir3
a=`php73.cli ~/private/tools/cv --user=$user api Job.execute`
if echo $a | grep -qv '"is_error": 0'; then echo $a; echo $dir3; fi

