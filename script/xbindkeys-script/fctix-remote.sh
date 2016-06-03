#!/bin/bash

if [ `fcitx-remote` -eq 1 ];then
    fcitx-remote -o
else
    fcitx-remote -c
fi



