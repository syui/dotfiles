#!/bin/zsh

hdir=${0:a:h:h}

echo "script update ? [y]"

read key

case $key in
    [yY]|[yY]es)
        cp -i $hdir/lib/blogstart.sh $hdir/bac/ 
        cp -i $hdir/theme.txt $hdir/bac/
    ;;
esac
