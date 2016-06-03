#!/bin/zsh

dir=$HOME/Music
cha=`cat $dir/info.txt | grep FILE | tail -n 1 | cut -d '/' -f 6 | sed "s/\.[^.]*$//"`
# cha=`cat $dir/info.txt | grep FILE | tail -n 1 | xargs basename`
sum=`echo $cha | wc -c | tr -d ' '`
fil=$dir/info.txt
inf=$dir/info.s

if [ -e $fil ]; then
    if [ -e $inf ];then
        i=`cat $inf | tail -n 1`
        if [ $i -le $sum ]; then
            a=`expr $i + 4`
            b=$i"-"$a
            c=`cat $fil | grep FILE | tail -n 1 | cut -d '/' -f 6 | sed "s/\.[^.]*$//" | cut -c $b | tr -d '\n'` > /dev/null
            echo -ne "| ♫ $c"
            echo `expr $i + 1` >> $inf
        else
            rm $inf
        fi
    else
        echo 1 > $inf
    fi
else
    if [ -e $inf ];then
        rm $inf
    fi
fi
