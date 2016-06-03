#!/bin/zsh

icon=~/dotfiles/Pictures/phoenix/phoenix_power.png
user=
pass=
room_id=
app=

dir=~/bin
file=$dir/lingr.txt
back=$dir/lingr.txt.back
tmp=$dir/lingr.txt.tmp
cd $dir
touch $file
touch $back
touch $tmp
mv $file $back
rm -rf $tmp > /dev/null 2>&1

if ps -ax | grep -w tor | grep -v grep > /dev/null 2>&1;then
    if [ "`curl -sL --socks5 127.0.0.1:9050 -X GET -H "application/javascript; charset=utf-8" http://lingr.com/api/session/verify\?session\=${LINGR_SESSION_ID} | jq -r '.status'`" = "error" ];then
        LINGR_SESSION_ID=`curl -sL -X GET -H "application/javascript; charset=utf-8" http://lingr.com/api/session/create\?user=${user}\&password=${pass}\&app_key=${app}|jq -r '.session'`
        curl -sL --socks5 127.0.0.1:9050 -X GET -H "application/javascript; charset=utf-8" http://lingr.com/api/room/show\?session=${LINGR_SESSION_ID}\&room=${room_id} | jq . > $tmp
    else
        curl -sL --socks5 127.0.0.1:9050 -X GET -H "application/javascript; charset=utf-8" http://lingr.com/api/room/show\?session=${LINGR_SESSION_ID}\&room=${room_id} | jq . > $tmp
    fi
    proxy_type="tor-proxy"
else
    if [ "`curl -sL -X GET -H "application/javascript; charset=utf-8" http://lingr.com/api/session/verify\?session\=${LINGR_SESSION_ID} | jq -r '.status'`" = "error" ];then
        LINGR_SESSION_ID=`curl -sL -X GET -H "application/javascript; charset=utf-8" http://lingr.com/api/session/create\?user=${user}\&password=${pass}\&app_key=${app}|jq -r '.session'`
        curl -sL -X GET -H "application/javascript; charset=utf-8" http://lingr.com/api/room/show\?session=${LINGR_SESSION_ID}\&room=${room_id} | jq . > $tmp
    else
        curl -sL -X GET -H "application/javascript; charset=utf-8" http://lingr.com/api/room/show\?session=${LINGR_SESSION_ID}\&room=${room_id} | jq . > $tmp
    fi
    proxy_type="no-proxy"
fi

nick=$icon
#cat $tmp| jq -r '.rooms|.[].messages|.[].text' > $file
#nick=`cat $tmp| jq -r '.rooms|.[].messages|.[].nickname'|tail -n 1`
#icon=`cat $tmp| jq -r '.rooms|.[].messages|.[].icon_url'`
#nick=$dir/icon/${nick}.jpg

if [ "`diff $file $back`" != "" ];then
    title=Lingr
    message=`diff $file $back`
    case $OSTYPE in
        darwin*)
            growlnotify -m "$message" --image $nick -t "$title : $proxy_type" "$message"
        ;;
        linux*)
            notify-send.sh -t 0 -u low --replace=9 -i $nick "$title : $proxy_type" "$message"
        ;;
    esac
fi
