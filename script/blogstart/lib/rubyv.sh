#!/bin/zsh
rubyusev=$1
echo "rvm use $rubyusev"
ruby --version
source ~/.rvm/scripts/rvm
if which rvm > /dev/null 2>&1;then 
if ! rvm list | grep $rubyusev > /dev/null 2>&1;then
    echo rvm install $rubyusev
    rvm install $rubyusev
fi
if ! ruby --version | grep $rubyusev > /dev/null 2>&1;then
    echo rvm use $rubyusev
    rvm use $rubyusev
    #source ~/.rvm/scripts/rvm
fi
ruby --version
else
    echo "ruby --version $rubyusev "
fi

rvm use $rubyusev
ruby --version
