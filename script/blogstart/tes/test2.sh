#!/bin/zsh

hdir=${0:a:h}
cat $hdir/tes/com.txt | pbcopy 
sour=`$hdir/lib/one-liner.sh`
titl=`echo $sour | tr '&' '\n' | grep http`
titl=${titl##*/}
titl=`echo ${titl##*.} | tr -d ' '`

if ! ls $hdir/plu/${titl} > /dev/null 2>&1;then
cat << EOF > $hdir/plu/${titl}
${titl})
        bash -c "\$imgv \$hdir/img/\${peco}.png"
        numb=http://localhost:4000
        bash -c "\$brow \$numb &"
        ${sour}
;;
EOF
fi
