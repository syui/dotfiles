#!/bin/zsh
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
    ruby --version 2.1.5
fi

rvm use 1.9.3
ruby --version
