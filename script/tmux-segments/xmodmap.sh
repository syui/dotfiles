#!/bin/zsh

run_segment() {
	key=`xmodmap -pke | grep 233 | cut -d ' ' -f 6`
    case $key in
        F2) icon="KEYMAP";;
        *) icon="APPLE";;
    esac
	echo $icon
}
