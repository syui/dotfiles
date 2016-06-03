#!/bin/zsh

cat /var/log/pacman.log | cut -d ' ' -f 1 | uniq
echo -e "\n"
read ans

if [ -n $ans ];then
	list=`cat /var/log/pacman.log | grep $ans | grep upgraded | cut -d ' ' -f 5`
	numb=`echo $list | wc -l | tr -d ' '`
	for (( i=1; i<=$numb; i++ ))
	do
		pack=`echo $list | awk "NR==$i"`
        ${0:a:h}/downgrade.sh $pack
	done
fi
