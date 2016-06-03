#!/bin/bash

case $OSTYPE in
    darwin*)
    clip=pbpaste
    copy=pbcopy
;;
    linux*)
    clip="xclip -o"
    copy="xclip -i"
;;
esac

text=`$clip`
echo -e "$text" | sed '/^$/d' | ruby -0777 -ne 'print $_.chomp("")' | tr '\n' '&' | sed 's/&/ && /g' | $copy
$clip
