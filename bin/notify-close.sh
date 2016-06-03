#!/bin/zsh
for (( i=1;i<=15;i++ ))
do
    notify-send.sh --close=$i
    sleep 0.4
done
