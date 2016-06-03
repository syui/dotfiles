#!/bin/zsh

run_segment() {
df -h | grep sda2 | tr ' ' , | sed -e 's/,,//g' -e 's/G/G /g' | cut -d , -f 4
}
