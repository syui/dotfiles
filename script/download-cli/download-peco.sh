#!/bin/zsh
#tor
if ps -ax | grep -w tor | grep -v 'grep' > /dev/null 2>&1;then
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
fi
hdir=${0:a:h}
xclip=`${0:a:h}/download-cl.sh | peco | cut -d , -f 3 | sed -e '/--noun/d' -e '/^$/d' -e '/^$^$/d'`
ddir=~/Downloads
filen=$ddir/download_url.txt
rm $filen > /dev/null 2>&1

if [ ! -d $ddir ];then
    mkdir -p $ddir
fi

cd $ddir

echo -e "next page ?\n\t[y]es/enter, [n]o, [d]ownload" 

if [ `which gosh` > /dev/null 2>&1 ];then
    a=`$hdir/key-run.sh | cut -d ' ' -f 1 | tail -n 1`
else
	read a
fi

case $a in
	[yY]|j|""|" ")
	numb=99
	for (( i=2;i<=$numb;i++ ))
	do
			xclip="$xclip\n`$hdir/download-cl.sh $i | peco | cut -d , -f 3 | sed -e '/--noun/d' -e '/^$/d'`"
			if [ "$a" = "" -o "$a" = " " ];then
				echo "enter < key"
			fi
			echo -e "next page ?\n\t[y]es/enter, [n]o, [d]ownload" 
			if [ `which gosh` > /dev/null 2>&1 ];then
				a=`$hdir/key-run.sh | cut -d ' ' -f 1 | tail -n 1`
			else
				read a
			fi

			case $a in
				[yY]|j)
					echo -e " < key\n\tpage $i"
				;;
				"")
					echo -e "enter < key\n\tpage $i"
				;;
				" ")
					echo -e "enter < key\n\tpage $i"
				;;
				[dD])
					echo -e " < key\n$xclip"
					rm $filen > /dev/null 2>&1
					echo "$xclip" > $filen

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
					echo -e " < key\n$xclip"
					exit
				;;
			esac
	done
	;;
	[dD])
		echo -e " < key\n$xclip"
		rm $filen > /dev/null 2>&1
		echo "$xclip" > $filen
        
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
		echo -e " < key\n$xclip"
		exit
		;;
esac
