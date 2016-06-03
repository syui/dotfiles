#!/bin/zsh

#tor

if ps -ax | grep -w tor | grep -v grep > /dev/null 2>&1;then
   unset http_proxy
   unset https_proxy
   unset HTTP_PROXY
   unset HTTPS_PROXY
   socks="--socks5 127.0.0.1:9050"
fi

filen=~/Downloads/ur_$1.txt
dirh=~/Downloads
diron=${0:a:h}
hdir=${0:a:h}
site_url=
peco=peco


if [ ! -d $dirh ];then
    mkdir -p $dirh
fi

cd $dirh

#if [ `which percol` > /dev/null 2>&1 ];then
#	peco=percol
#else
#	peco=peco
#fi

rm $filen > /dev/null 2>&1

case $1 in
	"")
		echo '$1={search word}'
		;;
	*)
url=$site_url/search/?search_id=$1

numb=`curl -sL --socks5 127.0.0.1:9050 $url | grep 'Next</a></li>' | tr '<' '\n' | grep href | cut -d '>' -f 2 | tail -n 2 | awk "NR==1"`

if [ "$numb"  = "" ]; then
	curl -sL --socks5 127.0.0.1:9050 $url | sed -n '/<div class="videoTitle">/,/<\/div>/p' | grep href | cut -d '"' -f 2 | sort
else
	curl -sL --socks5 127.0.0.1:9050 $url | sed -n '/<div class="videoTitle">/,/<\/div>/p' | grep href | cut -d '"' -f 2 | sort

	for (( i=2;i<=$numb;i++ ))
	do
		url=$site_url/search/$i/?search_id=$1
		curl -sL --socks5 127.0.0.1:9050 $url | sed -n '/<div class="videoTitle">/,/<\/div>/p' | grep href | cut -d '"' -f 2 | sort
	done
fi
;;

esac | $peco > $filen

#---
echo "Download ?"
echo "[y]es/enter, [n]o"
if [ `which gosh` > /dev/null 2>&1 ];then
    a=`$hdir/key-run.sh | cut -d ' ' -f 1 | tail -n 1`
else
	read a
fi

case $a in
	[yY]|j|""|" "|[dD])

        #tor {{{
        if ps -ax | grep -w tor | grep -v grep > /dev/null 2>&1;then
            if which proxychains > /dev/null 2>&1;then
                proxychains youtube-dl `cat $filen` && rm $filen
            elif which proxychains4 > /dev/null 2>&1;then
                proxychains4 youtube-dl `cat $filen` && rm $filen
            else
                youtube-dl -w -t -a $filen && rm $filen
            fi
        else
            youtube-dl -w -t -a $filen && rm $filen
        fi
		exit
        #}}}

		;;
	[nN]|*)
		echo " < key"
		cat $filen
		rm $filen
		exit
		;;
esac

rm $filen > /dev/null 2>&1
echo $proxy_type
