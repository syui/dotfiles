#!/bin/zsh

d=/Users/syui/bin
url_file=$d/url.txt
icon=~/dotfiles/Pictures/phoenix/phoenix_power_48.png

if [ -f $url_file ] && [ "`cat $url_file`" != "" ];then
    line=`cat $url_file|wc -l`
    for (( i=1;i<=$line;i++ ))
    do
        url=`cat $url_file | awk "NR==$i"`
        x=`echo $url|sed 's#/#.#g'`
        if [ "$x" != "" ];then
            xtemp=${d}/${x}.tmp
            xtext=${d}/${x}.xml
            xfeed=${d}/${x}.feed.xml
            touch $xtemp
            touch $xtext
            mv $xtext $xtemp
            if ps -ax | grep -w tor | grep -v grep > /dev/null 2>&1;then
                curl -sL --socks5 127.0.0.1:9050 ${url} > $xtext
                proxy_type="tor-proxy"
            else
               curl -sL ${url} > $xtext
               proxy_type="no-proxy"
            fi
            rss=`echo "cat /rss/channel/item"|xmllint --shell $xtext | grep -e '<title>' -e '<link>' | sed -e 's#<title>##g' -e 's#</title>#,#g' -e 's#<link>##g' -e 's#</link>#;#g' | tr -d '\n' | sed 's/\;/\n/g'|tr -d ' '`
            title=`echo "cat /rss/channel/item/title" | xmllint --shell $xtext | grep -e '<title>' | sed -e 's#<title>##g' -e 's#</title>##g'`
            echo "$rss" >! $xfeed
            echo "$title" >! $xtext
        fi

        if [ "`diff $xtext $xtemp`" != "" ];then
            case $OSTYPE in
                darwin*)
                    if ps -ax | grep -w tor | grep -v grep > /dev/null 2>&1;then
                        growlnotify -m "`diff $xtext $xtemp`" --image $icon -t "$url : $proxy_type"
                    else
                        growlnotify -m "`diff $xtext $xtemp`" --image $icon -t "$url : $proxy_type"
                    fi
                    ;;
                linux*)
                    if ps -ax | grep -w tor | grep -v grep > /dev/null 2>&1;then
                        notify-send.sh -t 0 -u low -i $icon --print-id --replace=$i "$url : $proxy_type" "`diff $xtext $xtemp`"
                    else
                        notify-send.sh -t 0 -u low -i $icon --print-id --replace=$i "$url : $proxy_type" "`diff $xtext $xtemp`"
                    fi
                    if [ "$1" = "-s" ] && [ -f /usr/share/sounds/speech-dispatcher/test.wav ];then
                        mplayer -ao pulse /usr/share/sounds/speech-dispatcher/test.wav
                    fi
                    ;;
            esac
        fi
    done
fi
