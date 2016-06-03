#
# ~/.bashrc
#

export PLUG=~/dotfiles/.bash/plugin
export CODE=$HOME/code
export CLICOLOR=1
export TERM="xterm-256color"
export HISTSIZE=1000000
export HISTCONTROL='ignoreboth'
export HISTIGNORE='&:ls:[bf]g:exit'
export HISTTIMEFORMAT='%b %d %H:%M:%S: '
export EDITOR=vim
export GOPATH=$HOME/code/go
export ECLIPSE_HOME=$HOME/eclipse
export PATH=$HOME/bin:${PATH}:/usr/local/go/bin:${SCALA_HOME}/bin:${GOPATH}/bin:/usr/local/sbin:${ECLIPSE_HOME}
export MANPATH=$HOME/bin/ctags-root/share/man:$MANPATH

shopt -s histappend
set cmdhist
set -o vi

alias vi='vim'
alias v='vim'
alias l='ls -alh'
alias la='ls -alh'
alias lt='ls -alrth'
alias h='history |grep'
alias b='cat ~/.bashrc |grep'
alias ls='ls -lAF'
alias cdcode='z $CODE'
alias cdslate='z $CODE/slate'
alias zcode='z $CODE'
alias zslate='z $CODE/slate'
alias svim='sudo vim'
alias rmswap='rm ~/.vim/tmp/swap/*'
alias adil='aws describe-instances'
function adi-ctl {
  adil $@ |awk -F "|" '{ print $2 " " $6 " " $9 " " $12 " " $13; }'
}
alias adi='adi-ctl'
function adia-ctl {
  adil $@ --region ap-northeast-1 |awk -F "|" '{ print $2 " " $6 " " $9 " " $12 " " $13; }'
}
alias adia='adia-ctl'
function adie-ctl {
  adil $@ --region eu-west-1 |awk -F "|" '{ print $2 " " $6 " " $9 " " $12 " " $13; }'
}
alias adie='adie-ctl'
alias adg='aws describe-groups'
alias ack=ag


#bind "set completion-ignore-case on"
shopt -s cdspell
shopt -s checkwinsize

if [ -x /usr/bin/dircolors ]; then
    test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


#PS1='[\u@\h \W]\$ '
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#function cool_prompt {
#  PS1="$BLUE[\t] \u@$(if [[ -x /usr/local/bin/my-instance-name ]]; then echo "$RED$(/usr/local/bin/my-instance-name)$BLUE"; else hostname -s; fi) "
#  [[ $(type -t __git_ps1) = "function" ]] && PS1="${PS1}$(__git_ps1 '%s:')"
#  PS1="${PS1}\W \!$ $NOCOLOR"
#}
#PROMPT_COMMAND=cool_prompt
# prompt
source $PLUG/bash-powerline/bash-powerline.sh

case $OSTYPE in
	darwin*)
		if [ -f $(brew --prefix)/etc/bash_completion ]; then
		  . $(brew --prefix)/etc/bash_completion
		fi
	;;
esac

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

