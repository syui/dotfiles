
dotdire=~/dotfiles
if [ ! -d ~/dotfiles ];then
    git clone https://github.com/syui/dotfiles ~/dotfiles
fi
cd $dotdire
dotname=`bash -c "ls -dA -1 .*"`
for (( i=3; i<=`echo "${dotname}" | wc -l`; i++ ))
do
    filename=`echo "${dotname}" | awk "NR==$i"`
    echo "ln -s $dotdire/$filename ~/$filename" | grep -v .config | grep -v .vim | grep -v .git
    #ln -s $dotdire/$filename ~/$filename
done
