#!/bin/bash

if ps -ax | grep -w tor | grep -v grep > /dev/null 2>&1;then
   unset http_proxy
   unset https_proxy
   unset HTTP_PROXY
   unset HTTPS_PROXY
   socks="--socks5 127.0.0.1:9050"
fi

url=

case $1 in
	"")
	url=
	;;
	*)
	url=
	;;
esac

# t
a=`curl -sL --socks5 127.0.0.1:9050 $url | sed -n '/<div class="videoTitle">/,/<\/div>/p' | grep href | cut -d '"' -f 2`
v=`curl -sL --socks5 127.0.0.1:9050 $url | sed -n '/<div class="videoInfo">/,/<\/div>/p' | grep Views | cut -d '>' -f 2 | cut -d '<' -f 1 | tr -d ' '`
l=`echo $a | tr ' ' '\n' | wc -l`

echo "--noun"
for (( i=1;i<=$l;i++ ))
do
	urls=`echo $a | tr ' ' '\n' | awk "NR==$i"`
	title=`echo $urls | cut -d / -f 6`
	views=`echo $v | tr ' ' '\n' | awk "NR==$i"`
	echo $views, $title, $urls 
done

