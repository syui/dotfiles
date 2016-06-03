#!/bin/zsh

dir=${0:a:h}/dotfiles/
url=`curl https://raw.githubusercontent.com/syui/dotfiles/master/.dotfiles`
line=`echo $url | wc -l | tr -d ' '`

for ((i = $line ; i > 0 ; i-- ))
do
  repo=`echo $url | awk "NR==$i"`
  file=`echo $repo | cut -d '/' -f 4`
  file=$dir/$file
  git clone $repo $file
done
