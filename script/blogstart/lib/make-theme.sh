#!/bin/zsh

hdir=${0:a:h:h}
#cat $hdir/bac/com.txt | pbcopy
sour=`$hdir/lib/one-liner.sh`
titl=`echo $sour | tr '&' '\n' | grep http`
titl=${titl##*/}
titl=`echo ${titl##*.} | tr -d ' '`

if [ "" != ${titl} ];then
if ! grep ${titl} $hdir/theme.txt;then
    echo "${titl}" >> $hdir/theme.txt
if [ ! -f $hdir/plu/${titl} ];then
cat << EOF > $hdir/plu/${titl}
${titl})
[[ -s "\$HOME/.rvm/scripts/rvm" ]] && source "\$HOME/.rvm/scripts/rvm" 
bash -c "\$imgv \$hdir/img/\${peco}.png"
numb=http://localhost:4000
bash -c "\$brow \$numb &"
${sour}
;;
EOF
fi

fi
else
    echo "clipboard=${titl}"
fi
