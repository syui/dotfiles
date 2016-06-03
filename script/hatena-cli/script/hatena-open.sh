#!/bin/zsh

if [ `which percol` > /dev/null 2>&1 ];then
    peco=percol
else
    peco=peco
fi

i=`${0:a:h}/hatena-peco.sh | $peco`
urls=`echo "$i" | cut -d , -f 3 | tr -d '\n'`

case ${OSTYPE} in
linux*)
    chrome="chromium"
    firefox="firefox"
;;
freebsd*)
    chrome="chromium"
    firefox="firefox"
;;
darwin*)
    chrome=/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome
    #firefox=
;;
esac

echo -e "$i\nq[uit], [w]3m, [c]hrome < open browser ?"
read a
#if [ `which gosh` > /dev/null 2>&1 ];then
#    a=`${0:a:h}/key-run.scm | cut -d ' ' -f 1 | tail -n 1`
#else
#    read a
#fi

case $a in
    [cC]|"")
        $chrome `echo $urls`
    ;;
    [wW])
        w3m -N `echo $urls`
    ;;
    #[fF])
    #    $firefox `echo $urls`
    #;;
    [qQ]|*)
        exit
    ;;
esac
