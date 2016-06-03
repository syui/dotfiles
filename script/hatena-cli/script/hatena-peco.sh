#!/bin/zsh


if [ `which percol` > /dev/null 2>&1 ];then
    peco=percol
else
    peco=peco
fi

url=http://b.hatena.ne.jp/hotentry
tag=${0:a:h}/tag.txt
a=`curl -s $url | sed -n '/<ul>/,/<\/ul>/p' | grep '<li>'`
l=`echo "$a" | wc -l`

for (( i=1;i<=$l;i++ ))
do
  urls=`echo "$a" | cut -d '"' -f 2 | awk "NR==$i"`
  title=`echo "$a" | cut -d '<' -f 3 | cut -d '>' -f 2 | awk "NR==$i"`
  echo $title, $urls
done | grep hotentry | $peco | cut -d , -f 2 | tr -d ' ' > $tag

clip=`cat $tag`
rm $tag
url=http://b.hatena.ne.jp/$clip
a=`curl -s $url | grep -A 2 -B 3 '<div class="entry-contents">'`
l=`echo "$a" | grep '<h3 class' | wc -l`

for (( i=1;i<=$l;i++ ))
do
  users=`echo "$a" | grep 'users</a>' | tr '>' '\n' | sed -n '/<span/,/<\/span/p' | sed '/<span/d'| cut -d '<' -f 1 | awk "NR==$i"`
  urls=`echo "$a" | grep '<h3' | cut -d '"' -f 4 | awk "NR==$i"`
  title=`echo "$a" | tr -d , | grep '<h3' | cut -d '>' -f 3 | cut -d '<' -f 1 | awk "NR==$i"`
  echo $users, $title, $urls
done | sort -rn
