dire=${0:a:h:h}

qit-a(){
    qiit_dir=$docs_dir/qiita
    file_tree=`zsh -c "ls -A $qiit_dir"`
    file_number=`echo "$file_tree" |wc -l`
    if [  $file_number -gt 1 ];then
        for (( i=1;i<=$file_number;i++ ))
        do
            file_search=$qiit_dir/`echo "$file_tree" | awk "NR==$i"`
            file_title=$(cat $file_search | jq -r '.[].title')
            if [ "$file_title" = "" ];then
                rm $file_search
            fi
        done
    fi
    file_tree=`zsh -c "ls -A $qiit_dir"`
    file_number=`echo "$file_tree" |wc -l`
    if [  $file_number -le 0 ];then
        qit
    else
        vim $qiit_dir/`echo "$file_tree" | tail -n 1`
    fi
}

qit-c(){
    qiit_dir=$docs_dir/qiita
    file_tree=`zsh -c "ls -A $qiit_dir"`
    file_number=`echo "$file_tree" |wc -l`
    if [  $file_number -gt 1 ];then
        for (( i=1;i<=$file_number;i++ ))
        do
            file_search=$qiit_dir/`echo "$file_tree" | awk "NR==$i"`
            file_title=$(cat $file_search | jq -r '.[].title')
            if [ "$file_title" = "" ];then
                rm $file_search
            fi
        done
    fi
}

qit-p(){
    echo $dire
    dire=$home_dir
    scpt_dir=$home_dir/scpt
    docs_dir=$home_dir/docs
    qiit_dir=$docs_dir/qiita
    post=$home_dir/docs
    file=qit.json
    file=$post/$file
    if [ ! -d $dire ];then
        mkdir -p $dire
    fi
    back=$dire/back
    json=parmas.json
    if [ ! -d $post ];then
        mkdir -p $post
    fi
    if [ ! -d $back ];then
        mkdir -p $back
    fi
    if [ ! -d $qiit ];then
        mkdir -p $qiit
    fi

    back=$back/$json

    cd $post
    qit-c
    touch $post/* > /dev/null 2>&1
    touch $dire/*/*  > /dev/null 2>&1
    if zsh -c "ls -a $qiit_dir|tail -n 1" > /dev/null 2>&1;then
        new_file=$qiit_dir/`zsh -c "ls -A $qiit_dir|tail -n 1"`
        cat $new_file >! $file
        rm $new_file
    fi
    json_tmp=`cat $file | jq -r .`
    echo "$json_tmp" >! $file
    echo "$json_tmp" >! $back

    if [ "`cat $file | jq -r '.[0].title'`" != "" ];then
        echo "$json_tmp"| jq -r '.[0]' >! $post/$json
        touch *
        if [ -f ~/.zshrc.seclet ];then
            source ~/.zshrc.seclet
        fi
        rvm use system
        qiita create_item < $post/$json -a $QIITA_ACCESS_TOKEN
        zsh $dire/scpt/push.zsh
    fi
}

qit-t(){
    rvm use system
    qiita list_items -a $QIITA_ACCESS_TOKEN | jq -r '.[]|.title,.url,.rendered_body' | html2text
}
