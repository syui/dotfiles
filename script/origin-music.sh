#!/bin/bash

dir=~/Music/syui
fil=url.txt
tmp=$dir/$fil
mkdir -p $dir

if [ ! -f $tmp ];then
    cd $dir
    curl -s https://raw.githubusercontent.com/syui/vocaloid/master/url.txt -O
fi

if ! diff <(curl -s https://raw.githubusercontent.com/syui/vocaloid/master/url.txt) <(cat $tmp) ;then
    cd $dir
    rm $tmp
    curl -s https://raw.githubusercontent.com/syui/vocaloid/master/url.txt -O
    youtube-dl -w -a $fil
fi
