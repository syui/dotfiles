#!/bin/zsh

url=http://b.hatena.ne.jp
url=$url/hotentry
a=`curl -s $url | grep -A 2 -B 2 '<div class="entry-contents">'`
l=`echo "$a" | grep '<li><strong>' | wc -l`

for (( i=1;i<=$l;i++ ))
do
  users=`echo "$a" | grep '<li><strong>' | tr '>' '\n' | sed -n '/<span/,/<\/span/p' | sed '/<span/d'| cut -d '<' -f 1 | awk "NR==$i"`
  urls=`echo "$a" | grep '<h3' | cut -d '"' -f 4 | awk "NR==$i"`
  title=`echo "$a" | tr -d , | grep '<h3' | cut -d '>' -f 3 | cut -d '<' -f 1 | awk "NR==$i"`
  echo $users, $title, $urls
done | sort -nr
