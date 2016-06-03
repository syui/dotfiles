#!/bin/zsh

dir=${0:a:h:h}
if [ -d $dir/.git ];then
    cd $dir
    git pull > /dev/null 2>&1
fi
