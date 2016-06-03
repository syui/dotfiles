#!/bin/zsh

d=~/bin
cd $d
file=`cat ./url.txt| sed 's#/#.#g'|peco`.feed.xml
url=`cat $file |tr -d ' ' | tr -d '\t' | peco | cut -d , -f 2-`

case $OSTYPE in
    darwin*)
        if ps -ax | grep -w tor | grep -v grep > /dev/null 2>&1;then
            curl -sL --socks5 127.0.0.1:9050 $url | html2text |sed -e :loop -e 'N; $!b loop' -e 's/\n//g' |tr '[' '\n' | tr ']' '\n' | tr '(' '\n' | tr ')' '\n'| peco
        else
            curl -sL $url | html2text|sed -e :loop -e 'N; $!b loop' -e 's/\n//g' |tr '[' '\n' | tr ']' '\n' | tr '(' '\n' | tr ')' '\n'| peco
        fi
        ;;
    linux*)
        if ps -ax | grep -w tor | grep -v grep > /dev/null 2>&1;then
            curl -sL --socks5 127.0.0.1:9050 $url | html2text |sed -e ':loop; N; $!b loop; s/\n//g' |tr '[' '\n' | tr ']' '\n' | tr '(' '\n' | tr ')' '\n'| peco
        else
            curl -sL $url | html2text|sed -e ':loop; N; $!b loop; s/\n//g' |tr '[' '\n' | tr ']' '\n' | tr '(' '\n' | tr ')' '\n'| peco
        fi
        ;;
esac
