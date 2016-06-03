
## export {{{
export DOT=$HOME/dotfiles/android
export DOTFILE=$HOME/dotfiles
export PLUG=$HOME/dotfiles/.zsh/plugin
export PLUGIN=$HOME/dotfiles/.zsh/plugin
export SCRIPT=$HOME/dotfiles/script
export BROWSER=w3m
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
export PATH=$PATH:/sdcard/arch/bin:$SCRIPT/download-cli:$SCRIPT:$DOTFILE/bin
## }}}

### cdr {{{
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-pushd true
### }}}

### autoload, zstyle {{{
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-svn
autoload -Uz run-help-svk
autoload -Uz run-help-openssl
autoload -Uz run-help-p4
autoload -Uz run-help-sudo
autoload zed
autoload predict-on
autoload history-search-end
autoload -Uz select-word-style
select-word-style default
autoload -Uz zmv
autoload -U url-quote-magic
autoload -U compinit
compinit
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified
zstyle ':completion:*:default' menu select=1
zstyle ':completion:history-words:*' list no
zstyle ':completion:history-words:*' menu yes
zstyle ':completion:history-words:*' remove-all-dups yes
bindkey "\e/" _history-complete-older
bindkey "\e," _history-complete-newer

zstyle ':filter-select' max-lines $(($LINES / 2))
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache true
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
### }}}

## alias {{{
alias p="pacman -S"
alias v="vim"
alias f="vim -c 'VimFiler'"
alias zs="vi ~/.zshrc"
alias zr="source ~/.zshrc" #exec $SHELL
alias vs="vi ~/.vimrc"
alias ts="vi ~/.tmux.conf"
alias ll="ls -alF"
alias up="pacman -Syu --noconfirm && pacman -Scc --noconfirm"
alias an="download-peco.sh"
alias ni="nicomylist-dl && cd /sdcard/Music && ffg"
alias z="_z"
alias j="cdr"

alias run-help >/dev/null 2>&1 && unalias run-help
alias -g V="| vim -"
if which pbcopy >/dev/null 2>&1 ; then
  alias -g C='| pbcopy'
elif which xclip >/dev/null 2>&1 ; then
  alias -g C='| xclip --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
  alias -g C='| putclip'
fi
## }}}

## golang {{{
if [ -x "`which go`" ]; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

if [ ! -f $GOPATH/bin/peco ];then
    go get github.com/peco/peco/cmd/peco
fi
## }}}

## source {{{
source $DOT/install.sh
source $PLUGIN/zaw/zaw.zsh
source $PLUGIN/powerline.zsh/powerline-android.zsh
source $PLUGIN/z/z.sh
compctl -U -K _z_zsh_tab_completion ${_Z_CMD:-z}
## }}}

## zaw {{{
bindkey '^x' zaw
bindkey '^h' zaw-history
bindkey '^@' zaw-gitdir
bindkey '^r' zaw-open-file
bindkey '^j^j' zaw-cdr
#bindkey '^j^k' zaw-z
zaw-z-f (){
    zawzf=`z | peco | cut -d ' ' -f 2-`
    echo $zawzf
    z $zawzf
}
zle -N zaw-z-f
bindkey '^j^k' zaw-z-f

### }}}

### open {{{
function openapp() {
case ${OSTYPE} in
  freebsd*|darwin*)
    BUFFER="open -a "
    ;;
  linux*)
    BUFFER="xdg-open "
    #BUFFER="gnome-open "
    ;;
  cygwin*)
    BUFFER="cygstart "
    ;;
esac
CURSOR=$#BUFFER
}
zle -N openapp
bindkey '^o' openapp
#bindkey -s '^o' "open -a "

### history {{{
case $OSTYPE in
    linux*)
        function peco-select-history() {
        local tac
        if which tac > /dev/null; then
            tac="tac"
        else
            tac="tail -r"
        fi
        BUFFER=$(\history -rn 1 | \
            eval $tac | \
            peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle clear-screen
    }
    ;;
darwin*)
    function peco-select-history() {
    BUFFER=`history -rn 1 | peco`
    CURSOR=$#BUFFER
    zle clear-screen
}
;;
esac
zle -N peco-select-history
bindkey '^h^j' peco-select-history
### }}}

## cd-up-down
function cdup_dir() {
if [[ -z "$BUFFER" ]]; then
    echo
    cd ..
    ls -aF
    zle reset-prompt
else
    zle self-insert 'k'
fi
 }
 zle -N cdup_dir
 bindkey '^k' cdup_dir

 function cddown_dir(){
 #com='$SHELL -c "ls -AF . | grep / "'
 com='ls -AF . | grep / '
 while [ $? = 0 ]
 do
     cdir=`eval $com | peco`
     if [ $? = 0 ];then
         cd $cdir
         eval $com
     else
         break
     fi
 done
 zle reset-prompt
}
zle -N cddown_dir
bindkey '^j' cddown_dir

#auto-mount-usb
if ls /dev/block/sda > /dev/null 2>&1;then
    mkdir -p /sdcard/mnt/{usb2,usb3}
    mount -t ext4 /dev/block/sda2 /sdcard/mnt/usb2
    mount /dev/block/sda3 /sdcard/mnt/usb3
fi

if ls /dev/block/sdb > /dev/null 2>&1;then
    mkdir -p /sdcard/mnt/{usb2,usb3}
    mount -t ext4 /dev/block/sdb2 /sdcard/mnt/usb2
    mount /dev/block/sdb3 /sdcard/mnt/usb3
fi

if ls /dev/block/sdc > /dev/null 2>&1;then
    mkdir -p /sdcard/mnt/{usb2,usb3}
    mount -t ext4 /dev/block/sdc2 /sdcard/mnt/usb2
    mount /dev/block/sdc3 /sdcard/mnt/usb3
fi

#history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks  
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
setopt inc_append_history

history_buffer (){
    BUFFER=`awk '!a[$0]++' ~/.zsh_history | peco`
    CURSOR=$#BUFFER
}
zle -N history_buffer
bindkey '^h^j' history_buffer

nii (){
    case $# in
        0)nicoselect-dl `cat $DOTFILE/Documents/nicourl.txt | awk "NR==2"` && cd /sdcard/Music && ffg;;
        1)nicoselect-dl `cat $DOTFILE/Documents/nicourl.txt  | awk "NR==$1"` && cd /sdcard/Music && ffg;;
    esac
}

niii (){
dir=/sdcard/Music/origin
fil=url.txt
tmp=$dir/$fil
mkdir -p $dir

if [ ! -f $tmp ];then
    cd $dir
    curl -s https://raw.githubusercontent.com/syui/vocaloid/master/url.txt -O
fi

if ! diff <(curl -s https://raw.githubusercontent.com/syui/vocaloid/master/url.txt) <(cat $tmp) ;then
    cd $dir
    rm $tmp
    curl -s https://raw.githubusercontent.com/syui/vocaloid/master/url.txt -O
    youtube-dl -w -a $fil
fi
}

