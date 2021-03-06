#!/bin/zsh

hdir=${0:a:h:h}
blog=~/blog_temp
peco=peco
relo=$hdir/lib/reload.sh

case $OSTYPE in
    linux*)
        brow="firefox"
        ;;
    darwin*)
        brow="open -a Safari"
        ;;
esac

mkdir -p ${hdir}/plu
mkdir -p $blog
cd $blog

if ! which go > /dev/null 2>&1;then
    case $OSTYPE in
        linux*)
            sudo pacman -S go
        ;;
        darwin*)
            brew install go
        ;;
    esac
    export GOPATH=$HOME/go
    go get -u -v github.com/spf13/hugo
fi

peco=`cat $hdir/theme.txt | $peco`

#peco=`cat << EOF | $peco
#hugo-incorporated
#lanyon-hugo
#davidl
#landing-page-theme
#middleman-simple-template
#gitbook
#EOF`

case $OSTYPE in
    linux*)
        imgv=mcomix
        if ! which $imgv > /dev/null 2>&1;then
            sudo pacman -S mcomix
        fi
    ;;
    darwin*)
        imgv="qlmanage -p"
    ;;
esac

case $peco in
    hugo-incorporated)
        bash -c "$imgv $hdir/img/${peco}.png"
        numb=http://localhost:1313
        git clone https://github.com/nilproductions/hugo-incorporated && cd hugo-incorporated &&  mkdir -p themes/hugo-incorporated/static && bash -c "$brow $numb &" && hugo server -w
    ;;
    lanyon-hugo)
        bash -c "$imgv $hdir/img/${peco}.png"
        numb=http://localhost:1313
        git clone https://github.com/tummychow/lanyon-hugo && cd lanyon-hugo && sed -i "" 's#"baseurl": "http://tummychow.github.io/lanyon-hugo/"#"baseurl": "http://tummychow.github.io"#g' config.json && bash -c "$brow $numb &" && hugo server
    ;;
    davidl)
        #$hdir/lib/rubyv.sh 2.1.5
        echo "rvm use 2.1.5"
        ruby --version
        source ~/.rvm/scripts/rvm
        if which rvm > /dev/null 2>&1;then 
        if ! rvm list | grep 2.1.5 > /dev/null 2>&1;then
            echo rvm install 2.1.5
            rvm install 2.1.5
        fi
        if ! ruby --version | grep 2.1.5 > /dev/null 2>&1;then
            echo rvm use 2.1.5
            rvm use 2.1.5
            #source ~/.rvm/scripts/rvm
        fi
        ruby --version
        else
            echo "ruby --version 2.1.5"
        fi
        bash -c "$imgv $hdir/img/${peco}.png"
        numb=http://localhost:4567
        git clone https://github.com/flexbox/davidl && cd davidl && bundle install && bower install && bash -c "$brow $numb &" && middleman server 
    ;;
    landing-page-theme)
        #set -e
        #$hdir/lib/rubyv.sh 2.1.5
        [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
        bash -c "$imgv $hdir/img/${peco}.png"
        numb=http://localhost:4000
        git clone https://github.com/swcool/landing-page-theme && cd landing-page-theme && bash -c "$brow $numb &" && cd $blog/landing-page-theme && jekyll server
    ;;
    gitbook)
        bash -c "$imgv $hdir/img/${peco}.png"
        numb=http://localhost:4000
        sudo npm update && sudo npm install gitbook -g && git clone https://github.com/onigra/gitbook-sample && cd gitbook-sample && sudo gitbook build && bash -c "$brow $numb &" && sudo gitbook serve
    ;;
    '!make-theme')
        $hdir/lib/make-theme.sh
        #cp -rf $hdir/bac/${0:a:t} $hdir/
        tempname=`bash -c "ls -A $hdir/plu" | tr ' ' '\n'`
        for (( i=1; i<=`echo $tempname | wc -l | tr -d ' '`; i++ ))
        do
            filename=`echo $tempname | awk "NR==$i"`
            if ! echo $casein | grep ${filename};then
                cat $hdir/plu/${filename} >> $hdir/lib/blogstart.sh
            fi
        done
    ;;
    '!recovery-theme')
        cp -rf ${hdir}/bac/theme.txt ${hdir}
        cp -rf ${hdir}/bac/blogstart.sh ${hdir}/lib
        rm -rf ${hdir}/plu > /dev/null 2>&1
        mkdir -p ${hdir}/plu
        echo "rm -rf ${blog}[y]"
        read key
        case $key in
            y)
            sudo rm -rf ${blog}
            ;;
        esac
        #echo "esac" >> $hdir/${0:a:t}
    ;;
    '!add-theme')
        ${hdir}/lib/add-theme.sh    
    ;;
startbootstrap-sb-admin-2)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
bash -c "$imgv $hdir/img/${peco}.png"
numb=http://localhost:4000
bash -c "$brow $numb &"
rvm use 2.1.5 && git clone https://github.com/IronSummitMedia/startbootstrap-sb-admin-2 && cd startbootstrap-sb-admin-2 && bower install && jekyll server
;;
middleman-simple-template)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
bash -c "$imgv $hdir/img/${peco}.png"
numb=http://localhost:4567
bash -c "$brow $numb &"
rvm use 1.9.3 && git clone https://github.com/syui/middleman-simple-template && cd middleman-simple-template && bundle install && middleman server
;;
startbootstrap-sb-admin-2)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
bash -c "$imgv $hdir/img/${peco}.png"
numb=http://localhost:4000
bash -c "$brow $numb &"
rvm use 2.1.5 && git clone https://github.com/IronSummitMedia/startbootstrap-sb-admin-2 && cd startbootstrap-sb-admin-2 && bower install && jekyll server
;;
gitbook-training)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
bash -c "$imgv $hdir/img/${peco}.png"
numb=http://localhost:4567
bash -c "$brow $numb &"
rvm use 2.0.0 && git clone https://github.com/catalyzeio/training && cd training && bundle install && middleman server
;;
