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
        bash -c "$imgv $hdir/img/${peco}.png"
        numb=http://localhost:4000
        git clone https://github.com/flexbox/davidl && bundle install && bower install && bash -c "$brow $numb &" && middleman server 
    ;;
    landing-page-theme)
        bash -c "$imgv $hdir/img/${peco}.png"
        numb=http://localhost:4000
        git clone https://github.com/swcool/landing-page-theme && cd landing-page-theme && gem install jekyll && bash -c "$brow $numb &" && jekyll server
    ;;
    gitbook)
        bash -c "$imgv $hdir/img/${peco}.png"
        numb=http://localhost:4000
        sudo npm update && sudo npm install gitbook -g && git clone https://github.com/onigra/gitbook-sample && cd gitbook-sample && sudo gitbook build && bash -c "$brow $numb &" && sudo gitbook serve
    ;;
    '!make-theme')
        $hdir/lib/make-theme.sh
        #cp -rf $hdir/bac/${0:a:t} $hdir/
        cat $hdir/plu/* >> $hdir/lib/blogstart.sh
        #echo "esac" >> $hdir/${0:a:t}
    ;;
    '!recovery-theme')
        cp -rf ${hdir}/bac/theme.txt ${hdir}
        cp -rf ${hdir}/bac/blogstart.sh ${hdir}/lib
        rm -rf ${hdir}/plu > /dev/null 2>&1
        mkdir -p ${hdir}/plu
        sudo rm -rf ${blog}
        #echo "esac" >> $hdir/${0:a:t}
    ;;
    '!add-theme')
        ${hdir}/lib/add-theme.sh    
    ;;
