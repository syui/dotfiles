scpt=${0:a:h}
mid-a(){
    dir=~/middleman/source/blog
    if [ "$1" != "" ];then
        if echo $1 | grep '-' > /dev/null 2>&1;then
            m=`echo $1 | cut -b -2`
            d=`echo $1 | cut -b 4-`
            dat=`date "+%Y-"`${m}"-"${d}
        else
            if [ `echo $1 | wc -c | tr -d ' '` -ge 3 ];then
                d=`echo $1 | cut -b -2`
                dat=`date "+%Y-%m"`"-"${d}
            else
                dat=`date "+%Y-%m-"`$1
            fi
        fi
    else
        dat=`date -v+1d "+%Y-%m-%d"`
    fi
    echo $dat
    if [ "$2" != "" ];then
        #tit=`memo z`
        tit=`echo ${2} |tr -d '"'`
        fil="${dat}-${tit}.html.md"
    else
        fil="${dat}-noun.html.md"
        tit=noun
    fi
    echo $fil

    if echo "$tit" | grep anime > /dev/null 2>&1;then
        tag=anime
    elif echo "$tit" | grep private > /dev/null 2>&1;then
        tag=private
    elif echo "$tit" | grep -e arch -e archlinux -e mac -e windows -e awesome -e shell -e script > /dev/null 2>&1;then
        tag=pc
    elif echo "$tit" | grep -e vocaloid -e miku > /dev/null 2>&1;then
        tag=music
    elif echo "$tit" | grep -e illust -e comic > /dev/null 2>&1;then
        tag=illust
    else
        tag=auto
    fi

tem=`echo "---
title: ${tit}
date: ${dat}
tags: ${tag}
---"`

    echo "$tem" > $dir/$fil
    cd $dir
    #vim $fil
}

mid-p(){
    dme=${0:a:h}/docs
    dir=~/middleman/source/blog
    dat=$(date "+%Y%m%d")
    mem=memo.json
    bac=memo.back
    mem=$dme/$mem
    bac=$dme/$bac
    if [ `cat $mem | wc -l` -gt 5 ];then
        case $OSTYPE in
            darwin*)
                day=`date -v+1d +"%m-%d"`
                days=`date -v+1d +"%Y-%m-%d"`
                ;;
            linux*)
                day=`date -d '1 days' +"%m-%d"`
                days=`date -d '1 days' +"%Y-%m-%d"`
                ;;
        esac
        cd $dir > /dev/null
        cat $mem | jq . >! $mem
        tit=`cat $mem | jq '.[0].title'`
        fil=`zsh -c ls -A $dir | grep "$days" | tail -n 1`
        echo $fil
        if ! zsh -c ls -A $dir | cut -d - -f 1-3 | grep "$days";then
            mid-a "$day" $tit
            memo 0 >> $dir/$fil
            cat $fil
            echo "$fil > json"
            memo 0 >! $bac
            memo w
            case $OSTYPE in
                darwin*)
                    sed -i "" '2,5d' $mem
                    ;;
                linux*)
                    sed -i '2,5d' $mem
                    ;;
            esac
            touch *
            git add $fil
            git commit -m "$fil"
            git push
            ./$scpt/push.zsh
        else
            cat $fil
            echo "$fil > markdown"
            touch *
            git add $fil
            git commit -m "$fil"
            git push
            ./$scpt/push.zsh
        fi
    fi
}
