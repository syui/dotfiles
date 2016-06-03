#!/bin/zsh

#export http_proxy=socks5://127.0.0.1:9050
#export https_proxy=$http_proxy
#export ftp_proxy=$http_proxy
#export rsync_proxy=$http_proxy
#export HTTP_PROXY=$http_proxy
#export HTTPS_PROXY=$http_proxy
#export FTP_PROXY=$http_proxy
#export RSYNC_PROXY=$http_proxy

icon=~/dotfiles/Pictures/phoenix/phoenix_power_48.png
url=ipinfo.io
fil=~/bin/${url}.txt
touch $fil
txt=`cat $fil`

if ps -ax | grep -w tor | grep -v grep > /dev/null 2>&1;then
    wan=`curl -sL --socks5 127.0.0.1:9050 $url`
else
   wan=`curl -sL $url`
fi

wip=`echo $wan|jq -r .ip`
hos=`echo $wan|jq -r .hostname`
cou=`echo $wan|jq -r .country`
i=6
mes="$wip
$hos
$cou"

if [ "$wip" != "$txt" ] && [ "$wip" != "" ];then
    title="Tor Global IP Address"
    case $OSTYPE in
        darwin*)
            growlnotify --image $icon -t $title -m "$mes"
            ;;
        linux*)
            notify-send.sh -t 0 -i $icon --replace=$i $title "$mes"
            ;;
    esac
    echo $wip >! $fil
fi
