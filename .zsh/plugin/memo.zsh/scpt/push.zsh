#!/bin/zsh

dir=${0:a:h:h}

if [ -d $dir/.git ];then
    cd $dir
    git add -A
    git add *
    git commit -m "update"
    git push
fi
