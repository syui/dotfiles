#!/bin/zsh

hdir=${0:a:h:h}

cp -rf $hdir/tes/theme.txt $hdir/bac
cp -rf $hdir/tes/blogstart.sh $hdir/bac
cp -rf ${hdir}/bac/theme.txt ${hdir}
cp -rf ${hdir}/bac/blogstart.sh ${hdir}/lib
rm -rf ${hdir}/lib/blogstart-s
rm -rf ${hdir}/plu/* > /dev/null 2>&1
