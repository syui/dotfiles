home_dir=${0:a:h}
scpt_dir=$home_dir/scpt
docs_dir=$home_dir/docs
qiit_dir=$docs_dir/qiita

export memo=' [ {"command":"memo"}, {"command":"todo"}, {"command":"qit"}, {"command":"mid"} ]'

for (( i=0;i<`echo $memo|jq '.[].command' | wc -l`;i++ ))
do

memo_command=`echo $memo | jq -r ".[$i].command"`
touch $scpt_dir/${memo_command}.zsh
source $scpt_dir/${memo_command}.zsh

$memo_command (){
        
        if [ ! -d $docs_dir ];then
            mkdir -p $docs_dir
        fi
        if [ ! -d $qiit_dir ];then
            mkdir -p $qiit_dir
        fi
        json_file=$docs_dir/${0}.json
        if [ ! "$0" = "qit" ];then
            tmp=`echo -e '[\n {\n "title" : "article-title",\n "comment" : "article-body"\n }\n]'`
            com=comment
        else
            tmp=`echo '[
  {
  "title": "",
  "tags": [ { "name": "" }, { "name":""}, { "name":""}, { "name":""}, { "name":""} ],
  "body": "",
  "coediting": false,
  "gist": false,
  "private": false,
  "tweet": false
  }
]
'`
        com=body
        fi
        if [ ! -f $json_file ];then
            echo "$tmp" > $json_file
        elif [ `cat $json_file | wc -l` -le 1 ];then
            echo "$tmp" >! $json_file
        fi
        if [ `zsh -c "ls -A $qiit_dir" | wc -l` -le 2 ];then
            echo "$tmp" >! $qiit_dir/`date +"%Y-%m-%d-%H-%M-%s"`.json
        fi
        case "$1" in
            ""|v|-[vV])
                zsh ${scpt_dir}/pull.zsh
                if [ "$0" = "qit" ];then
                    vim $qiit_dir/`zsh -c "ls -A $qiit_dir"|tail -n 1`
                else
                    vim $json_file
                fi
                ;;
            u|-[uU])
                zsh ${scpt_dir}/push.zsh
                ;;
            h|-[hH])
                echo "
                : vim $json_file
                o: cat $json_file | jq -r '.[]'
                c: cat $json_file | jq -r '.[0].comment'
                "
                ;;
            o|-o)
                cat $json_file | jq -r '.[]'
                ;;
            c|-c)
                cat $json_file | jq -r ".[0].${com}" | sed -e "s/^'//g" -e "s/'$//g"
                ;;
            t|-[tT])
                if [ $# = 2 ];then
                    cat $json_file | jq ".[$2].title"
                else
                    cat $json_file | jq -r ".[].title" | nl -v 0 -b a
                    echo "> nl?"
                    read key
                    cat $json_file | jq ".[$key].title"
                fi
                ;;
            b|-[bB])
                if [ $# = 2 ];then
                    cat $json_file | jq ".[$2].${com}"
                else
                    cat $json_file | jq ".[].${com}" | nl -v 0 -b a
                    echo "> nl?"
                    read key
                    cat $json_file | jq ".[$key].${com}"
                fi
                ;;
            n|-[nN])
                cat $json_file | jq ".[].title" | nl -v 0 -b a
                ;;
            w|-[wW])
                json=`cat $json_file | jq .`
                echo $json | jq . >! $json_file
                ;;
            [0-9]*|-[0-9]*)
                cat $json_file | jq -r ".[$1].${com}" | sed -e 's/^  *//g' -e "s/^'//g" -e "s/'$//g"
                ;;
            z|-[zZ])
                ;;
        esac
}
done
