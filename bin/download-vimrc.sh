#!/bin/zsh

# github, bitbucket {{{
dot=`curl -s http://vim-jp.org/reading-vimrc/json/archives.json | jq -r '.[] | .vimrc | .[] | .url' | sed -e 's/\/github.com/\/raw.githubusercontent.com/g' -e 's/\/blob//g' -e 's/\/gist.github.com/\/gist.githubusercontent.com\/thinca/g' -e 's/\/src/\/raw/g'`

line=`echo $dot | wc -l | tr -d ' '`

for (( i=1; i<=$line;i++ ))
do
  repo=`echo $dot | awk "NR==$i"`
  echo $repo
  file=`echo $repo | cut -d '/' -f 4`
  echo $file
  curl $repo -o $file
done
## github, bitbucket }}}

# gist {{{
dot=`echo $dot | grep "gist.githubusercontent.com" | sed 's/$/\/raw/g'`
line=`echo "$dot" | wc -l | tr -d ' '`
for (( i=1;i<=$line;i++ ))
do
  repo=`echo "$dot" | awk "NR==$i"`
  file=`echo "$repo" | cut -d '/' -f 5`
  file=$dir/$file
  curl $repo -o $file
done
### gist }}}
