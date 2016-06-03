#!/bin/zsh

aline=`curl -s http://b.hatena.ne.jp/hotentry | sed -n '/<ul>/,/<\/ul>/p' | grep '<li>'`
line=`echo ${aline} | wc -l`

for (( i=1;i<=$line;i++ ))
do
  urls=`echo ${aline} | cut -d '"' -f 2 | awk "NR==$i"`
  title=`echo ${aline} | cut -d '<' -f 3 | cut -d '>' -f 2 | awk "NR==$i"`
  echo $title, $urls
done
