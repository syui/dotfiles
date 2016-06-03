#!/bin/bash

l=`bash -c "ls -A"`
n=`echo "$l" | wc -l`

for (( i=1;i<=$n;i++ ))
do
	f=`echo "$l" | awk "NR==$i"`
	f="${f%.*}"
	echo mkdir "$f"
	mkdir "$f"
	#read a
	#case $a in
	#	[yY]es|[yY])
	#		mkdir $f
	#		;;
	#	*)
	#		echo no
	#		;;
	#esac
done
