## dotfiles {{{
# url : git.io/syu
# ref : http://dotshare.it/dots/
# os : archlinux < osx < windows
# terminal : urxvt, lilyterm { lilyterm > termite, urxvt > qterminal }
# shell : zsh
# editor : vim
# virtual : tmux
# login : slim
# window : awesome { awesome > spectrwm, i3, qtile }
# filer : spacefm
# theme : numix
# font : dejavu
# browser : firefox < chromium < chrome
# source : https://github.com/syui/dotfiles
# setup : git.io/syu
# command : curl -sL git.io/syu
## }}}

### export {{{
PATH=$PATH:$HOME/.rvm/bin:$HOME/.gem/ruby/2.2.0/bin
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
fpath=(~/.zsh/functions/ $fpath)
fpath=($HOME/.zsh/functions $fpath)
e_normal=`echo -e "¥033[0;30m"`
e_RED=`echo -e "¥033[1;31m"`
e_BLUE=`echo -e "¥033[1;36m"`

unset LSCOLORS
export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
export BROWSER=w3m
export PATH=/usr/local/bin:$PATH
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim
export PATH=$PATH:$HOME/local/bin:/usr/local/git/bin
export PATH=$PATH:$HOME/dotfiles/bin
export PATH=$PATH:/sbin:/usr/local/bin
export MANPATH=$MANPATH:/opt/local/man:/usr/local/share/man
export PATH="$PATH:$HOME/.rvm/bin"

# setup export
export DOTFILE=$HOME/dotfiles
export PLUGIN=$DOTFILE/.zsh/plugin
export GITHUB=https://github.com
export RAWGIT=https://raw.githubusercontent.com
export ORIGIN=$GITHUB/syui
export ORIRAW=$RAWGIT/syui/master
export APPJSON=$DOTFILE/Documents/app.json

[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"


case "${OSTYPE}" in
    darwin*)
        export PATH=$PATH:/opt/local/bin:/opt/local/sbin
        export PATH=$PATH:/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources
        ;;
    freebsd*)
        case ${UID} in
            0)
                updateports()
                {
                    if [ -f /usr/ports/.portsnap.INDEX ]
                    then
                        portsnap fetch update
                    else
                        portsnap fetch extract update
                    fi
                    (cd /usr/ports/; make index)

                    portversion -v -l \<
                }
                alias appsupgrade='pkgdb -F && BATCH=YES NO_CHECKSUM=YES portupgrade -a'
                ;;
        esac
        ;;
esac
### }}}

### setopt {{{
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_pushd
#setopt autopushd
#setopt brace_ccl
#setopt chase_links
setopt complete_aliases
#setopt correct_all
#setopt extended_glob
#setopt globdots
#setopt hist_ignore_all_dups
#setopt hist_no_store
#setopt hist_reduce_blanks
#setopt inc_append_history
#setopt list_packed
#setopt list_types
#setopt magic_equal_subst
#setopt multios
#setopt no_clobber
#setopt noautoremoveslash
#setopt nolistbeep
#setopt path_dirs
#setopt pushd_ignore_dups
#setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks  
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
setopt inc_append_history
#### }}}

### cdr {{{
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-pushd true
### }}}

### install {{{

#source ~/.zsh/plugin/install.zsh/install.zsh

### }}}

### _z  {{{
if ! type _z > /dev/null 2>&1;then
    _z () {
        local datafile="${_Z_DATA:-$HOME/.z}"
        [ -z "$_Z_OWNER" -a -f "$datafile" -a ! -O "$datafile" ] && return
        if [ "$1" = "--add" ]
        then
            shift
            [ "$*" = "$HOME" ] && return
            local exclude
            for exclude in "${_Z_EXCLUDE_DIRS[@]}"
            do
                [ "$*" = "$exclude" ] && return
            done
            local tempfile="$datafile.$RANDOM"
            while read line
            do
                [ -d "${line%%\|*}" ] && echo $line
            done < "$datafile" | awk -v path="$*" -v now="$(date +%s)" -F"|" '
            BEGIN {
            rank[path] = 1
            time[path] = now
        }
        $2 >= 1 {
        # drop ranks below 1
        if( $1 == path ) {
            rank[$1] = $2 + 1
            time[$1] = now
        } else {
        rank[$1] = $2
        time[$1] = $3
    }
    count += $2
}
END {
if( count > 9000 ) {
    # aging
    for( x in rank ) print x "|" 0.99*rank[x] "|" time[x]
    } else for( x in rank ) print x "|" rank[x] "|" time[x]
}
' 2> /dev/null >| "$tempfile"
if [ $? -ne 0 -a -f "$datafile" ]
then
    env rm -f "$tempfile"
else
    [ "$_Z_OWNER" ] && chown $_Z_OWNER:$(id -ng $_Z_OWNER) "$tempfile"
    env mv -f "$tempfile" "$datafile" || env rm -f "$tempfile"
fi
  elif [ "$1" = "--complete" -a -s "$datafile" ]
  then
      while read line
      do
          [ -d "${line%%\|*}" ] && echo $line
      done < "$datafile" | awk -v q="$2" -F"|" '
      BEGIN {
      if( q == tolower(q) ) imatch = 1
          q = substr(q, 3)
          gsub(" ", ".*", q)
      }
      {
          if( imatch ) {
              if( tolower($1) ~ tolower(q) ) print $1
              } else if( $1 ~ q ) print $1
          }
          ' 2> /dev/null
      else
          while [ "$1" ]
          do
              case "$1" in
                  (--) while [ "$1" ]
                  do
                      shift
                      local fnd="$fnd${fnd:+ }$1"
                  done ;;
              (-*) local opt=${1:1}
                  while [ "$opt" ]
                  do
                      case ${opt:0:1} in
                          (c) local fnd="^$PWD $fnd" ;;
                          (h) echo "${_Z_CMD:-z} [-chlrtx] args" >&2
                              return ;;
                          (x) sed -i -e "\:^${PWD}|.*:d" "$datafile" ;;
                          (l) local list=1 ;;
                          (r) local typ="rank" ;;
                          (t) local typ="recent" ;;
                      esac
                      opt=${opt:1}
                  done ;;
              (*) local fnd="$fnd${fnd:+ }$1" ;;
          esac
          local last=$1
          shift
      done
      [ "$fnd" -a "$fnd" != "^$PWD " ] || local list=1
      case "$last" in
          (/*) [ -z "$list" -a -d "$last" ] && cd "$last" && return ;;
      esac
      [ -f "$datafile" ] || return
      local cd
      cd="$(while read line; do
      [ -d "${line%%\|*}" ] && echo $line
  done < "$datafile" | awk -v t="$(date +%s)" -v list="$list" -v typ="$typ" -v q="$fnd" -F"|" '
  function frecent(rank, time) {
  # relate frequency and time
  dx = t - time
  if( dx < 3600 ) return rank * 4
      if( dx < 86400 ) return rank * 2
          if( dx < 604800 ) return rank / 2
              return rank / 4
          }
          function output(files, out, common) {
          # list or return the desired directory
          if( list ) {
              cmd = "sort -n >&2"
              for( x in files ) {
                  if( files[x] ) printf "%-10s %s\n", files[x], x | cmd
                  }
                  if( common ) {
                      printf "%-10s %s\n", "common:", common > "/dev/stderr"
                  }
              } else {
              if( common ) out = common
                  print out
              }
          }
          function common(matches) {
          # find the common root of a list of matches, if it exists
          for( x in matches ) {
              if( matches[x] && (!short || length(x) < length(short)) ) {
                  short = x
              }
          }
          if( short == "/" ) return
              # use a copy to escape special characters, as we want to return
              # the original. yeah, this escaping is awful.
              clean_short = short
              gsub(/[\(\)\[\]\|]/, "\\\\&", clean_short)
              for( x in matches ) if( matches[x] && x !~ clean_short ) return
                  return short
              }
              BEGIN {
              gsub(" ", ".*", q)
              hi_rank = ihi_rank = -9999999999
          }
          {
              if( typ == "rank" ) {
                  rank = $2
              } else if( typ == "recent" ) {
              rank = $3 - t
          } else rank = frecent($2, $3)
          if( $1 ~ q ) {
              matches[$1] = rank
          } else if( tolower($1) ~ tolower(q) ) imatches[$1] = rank
          if( matches[$1] && matches[$1] > hi_rank ) {
              best_match = $1
              hi_rank = matches[$1]
          } else if( imatches[$1] && imatches[$1] > ihi_rank ) {
          ibest_match = $1
          ihi_rank = imatches[$1]
      }
  }
  END {
  # prefer case sensitive
  if( best_match ) {
      output(matches, best_match, common(matches))
  } else if( ibest_match ) {
  output(imatches, ibest_match, common(imatches))
                }
            }
            ')"
            [ $? -gt 0 ] && return
            [ "$cd" ] && cd "$cd"
        fi
    }
fi

compctl -U -K _z_zsh_tab_completion ${_Z_CMD:-z}
### }}}

### color {{{
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*' list-colors di=34 fi=0
case "${TERM}" in
    xterm)
        export TERM=xterm-color

        ;;
    kterm)
        export TERM=kterm-color
        stty erase
        ;;

    cons25)
        unset LANG
        export LSCOLORS=ExFxCxdxBxegedabagacad

        export LS_COLORS='di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30'
        zstyle ':completion:*' list-colors \
            'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        ;;

    kterm*|xterm*)
        export CLICOLOR=1
        export LSCOLORS=ExFxCxDxBxegedabagacad

        zstyle ':completion:*' list-colors \
            'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;

    dumb)
        echo "Welcome Emacs Shell"
        ;;
esac

autoload colors
colors
LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30"
export LS_COLORS

if [ -f ~/.dircolors ]; then
    if type dircolors > /dev/null 2>&1; then
        eval $(dircolors ~/.dircolors)
    elif type gdircolors > /dev/null 2>&1; then
        eval $(gdircolors ~/.dircolors)
    fi
fi

### }}}

### autoload, zstyle {{{
#HELPDIR=/usr/local/share/zsh/helpfiles
#alias run-help >/dev/null 2>&1 && unalias run-help
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

### magick {{{
typeset -A abbreviations
abbreviations=(
"L"    "| $PAGER"
"G"    "| grep"

"HEAD^"     "HEAD\\^"
"HEAD^^"    "HEAD\\^\\^"
"HEAD^^^"   "HEAD\\^\\^\\^"
"HEAD^^^^"  "HEAD\\^\\^\\^\\^\\^"
"HEAD^^^^^" "HEAD\\^\\^\\^\\^\\^"
)

magic-abbrev-expand () {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9^]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}

magic-abbrev-expand-and-insert () {
    magic-abbrev-expand
    zle self-insert
}

magic-abbrev-expand-and-accept () {
    magic-abbrev-expand
    zle accept-line
}

no-magic-abbrev-expand () {
    LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N magic-abbrev-expand-and-insert
zle -N magic-abbrev-expand-and-accept
zle -N no-magic-abbrev-expand
bindkey "\r"  magic-abbrev-expand-and-accept
#bindkey "^J"  accept-line
bindkey " "   magic-abbrev-expand-and-insert
bindkey "."   magic-abbrev-expand-and-insert
bindkey "^x " no-magic-abbrev-expand

function rmf(){
for file in $*
do
    __rm_single_file $file
done
}

function __rm_single_file(){
if ! [ -d ~/.Trash/ ]
then
    command /bin/mkdir ~/.Trash
fi

if ! [ $# -eq 1 ]
then
    echo "__rm_single_file: 1 argument required but $# passed."
    exit
fi

if [ -e $1 ]
then
    BASENAME=`basename $1`
    NAME=$BASENAME
    COUNT=0
    while [ -e ~/.Trash/$NAME ]
    do
        COUNT=$(($COUNT+1))
        NAME="$BASENAME.$COUNT"
    done

    command /bin/mv $1 ~/.Trash/$NAME
else
    echo "No such file or directory: $file"
fi
}

zle -N self-insert url-quote-magic
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# }}}

### directory {{{

function chpwd() {
case $OSTYPE in
    darwin*)
        rm ./.DS_Store > /dev/null 2>&1
        ;;
esac
ls -aCFG
}

function mkcd() {
if [[ -d $1 ]]; then
    echo "It already exsits! Cd to the directory."
    cd $1
else
    echo "Created the directory and cd to it."
    mkdir -p $1 && cd $1
fi
}

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
 com='$SHELL -c "ls -AF . | grep / "'
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
#case $OSTYPE in
#    darwin*)
#        bindkey '^[' cddown_dir
#        ;;
#    linux*)
#        bindkey '^j' cddown_dir
#        ;;
#esac

#function my_enter {
#    if [[ -n "$BUFFER" ]]; then
#        builtin zle .accept-line
#        return 0
#    fi
#    if [ "$WIDGET" != "$LASTWIDGET" ]; then
#        MY_ENTER_COUNT=0
#    fi
#    case $MY_ENTER_COUNT in
#        0)
#            BUFFER='ls -aCFG'
#            #CURSOR=$#BUFFER
#            (( MY_ENTER_COUNT++ ))
#            ;;
#        1)
    #            if [[ -d .svn ]]; then
    #                BUFFER=" svn status"
    #            elif git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    #                BUFFER=" git status -sb"
    #            else
    #                BUFFER='git config --list'
    #            fi
    #            (( MY_ENTER_COUNT++ ))
    #            ;;
#        *)
    #            echo my_entter quit!!
    #            reset
    #            MY_ENTER_COUNT=1
    #            #unset MY_ENTER_COUNT
    #            ;;
    #    esac
    #    builtin zle .accept-line
    #}
    #zle -N my_enter
    #bindkey '^m' my_enter
    ### }}}

    ### stack {{{

    local p_buffer_stack=""
    local -a buffer_stack_arr

    function make_p_buffer_stack()
    {
        if [[ ! $#buffer_stack_arr > 0 ]]; then
            p_buffer_stack=""
            return
        fi
        p_buffer_stack="%F{black} $buffer_stack_arr %f"
    }


    show_buffer_stack() {
        POSTDISPLAY="
        stack: $LBUFFER"
        zle push-line-or-edit
    }
    zle -N show_buffer_stack
    setopt noflowcontrol
    bindkey '^Q' show_buffer_stack
    ### }}}

    ### golang {{{

    if [ -x "`which go`" ]; then
        export GOPATH=$HOME/go
        export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
    fi

    ### }}}

    ### stack {{{
    function show_buffer_stack() {
    POSTDISPLAY="
    stack: $LBUFFER"
    zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey '^Q' show_buffer_stack
### }}}

### open {{{
#alias open="xdg-open"

function openapp() {
case ${OSTYPE} in
    darwin*)
        BUFFER="open -a "
        CURSOR=$#BUFFER
        ;;
    linux*)
        BUFFER="spacefm ."
        CURSOR=$#BUFFER
        #BUFFER="gnome-open "
        ;;
    cygwin*)
        BUFFER="cygstart "
        CURSOR=$#BUFFER
        ;;
esac
}
zle -N openapp
bindkey '^o' openapp
##bindkey -s '^o' "open -a "

# smart-last-word
autoload -Uz smart-insert-last-word
zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'
zle -N insert-last-word smart-insert-last-word
bindkey '^s' insert-last-word

# :<Tab>
bindkey -s '^[s' !$

# Editor mode
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey  '^[v' edit-command-line

### }}}

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

### markdown {{{
function markdown_preview(){
if [ $# -ne 1 ]
then
    echo "error: invalid arguments"
    echo "usage: $0 markdown_file"
    return 1
fi

if [ ! -f "$1" ]
then
    echo "error: $1 dose not exists"
    return 2
fi

(echo '<html><head><meta charset="UTF-8" /></head><body>';
markdown $1; echo '</body></html>')\
    | w3m -T text/html -dump

if [ $STY ]
then
    sleep 0.2
    screen -X redisplay
fi
}
### }}}

### virtualbox {{{
function vm (){
#zsh -c "ls -A ~/VirtualBox\ VMs/" | peco
vbi=`zsh -c "ls -A ~/VirtualBox\ VMs/ | tr ' ' '\n'"`
case $1 in
    [aA]rch*|[mM]ac*)
        echo $vbi | grep $1
        VBoxManage startvm `echo $vbi | grep $1`
        ;;
    "")
        echo $vbi | grep win
        echo win
        VBoxManage startvm `echo $vbi | grep win`
        ;;
    -a)
        echo $vbi | tr '\n' ' '
        VBoxManage startvm `echo $vbi | tr '\n' ' '`
        ;;
    *)
        VBoxManage startvm `echo "$vbi" | peco`
        ;;
esac
}

function vm-window (){
osascript << EOF

--tell application "System Events"
--  tell process "VirtualBoxVM"
--    every UI element
--  end tell
--end tell

tell app "VirtualBoxVM"
activate
end tell
EOF
}

### }}}

### tmux {{{

## auto-start
case $OSTYPE in
    darwin*)
        if [ -z "$SSH_CONNECTION" -a ${UID} -ne 0 -a -z "$TMUX" -a -z "$STY" ]; then
            if type tmux >/dev/null 2>&1; then
                tmux
            elif type tmux >/dev/null 2>&1; then
                if tmux has-session && tmux list-sessions | egrep -q '.*]$'; then
                    tmux attach && echo "tmux attached session "
                else
                    tmux new-session && echo "tmux created new session"
                fi
            elif type screen >/dev/null 2>&1; then
                screen -rx || screen -D -RR
            fi
        fi
        ;;
    linux*)
        if [ -z "$SSH_CONNECTION" -a -z "$TMUX" -a -z "$STY" ]; then
            if type tmux >/dev/null 2>&1; then
                if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
                    tmux -2 attach && echo "tmux attached session "
                else
                    tmux -2 new-session && echo "tmux created new session"
                fi
            fi
        fi
        ;;
esac

##copy-mode
function tmux-copy-line () {
tmux copy-mode\; send-keys 3k0Vj Enter
}
zle -N tmux-copy-line
bindkey '^n^n' tmux-copy-line

function tmux-copy-all () {
tmux copy-mode\; send-keys ggVG Enter
#tmux copy-mode\; send-keys Space\; send-keys '$'\; send-keys Enter
}
zle -N tmux-copy-all
bindkey '^[m' tmux-copy-all
### }}}

### alias {{{
alias lf="ls -F"
alias ll="ls -l"
alias 'ps?'='pgrep -l -f'
alias pk='pkill -f'
alias du="du -h"
alias duh="du -h ./ --max-depth=1"
alias su="su -l"
alias 'src'='exec zsh'
alias -g V="| vim -"
alias -g EV="| xargs --verbose sh -c 'vim \"\$@\" < /dev/tty'"
alias -g RET="RAILS_ENV=test"
alias -g RED="RAILS_ENV=development"
alias -g REP="RAILS_ENV=production"
alias raket='RAILS_ENV=test rake'
alias raked='RAILS_ENV=development rake'
alias rakep='RAILS_ENV=production rake'
alias ccat='pygmentize -O style=vim -f console256 -g'
alias less='less -r'
alias df='df -h'
alias free='free -m'
alias 'gr'='grep --color=auto -ERUIn'
alias 'm'='make'
alias 'mn'='make native-code'
alias 'mc'='make clean'
alias sc='screen -S main'
alias sn='screen'
alias sl='screen -ls'
alias sr='screen -r main'
alias srr='screen -U -D -RR'
alias tma='tmux attach'
alias tma0='tmux attach -t 0'
alias tma1='tmux attach -t 1'
alias tma2='tmux attach -t 2'
alias tml='tmux list-sessions'
alias pon='predict-on'
alias poff='predict-off'
#alias cp='nocorrect cp -irp'
alias refe='nocorrect refe'
alias s='ssh'
alias g='git'
alias gi='git'
alias oppai='git'
alias gs='git status -s -b'
alias gst='git status -s -b'
alias gc='git commit'
alias gci='git commit -a'
#alias java='nocorrect java'
alias erl='nocorrect erl'
alias sbcl='nocorrect sbcl'
alias gosh='nocorrect gosh'
alias node='nocorrect node'
alias scala='scala -deprecation -unchecked -explaintypes'
alias scc='scalac -deprecation -unchecked -explaintypes'
alias sci='scala -deprecation -unchecked -explaintypes -cp $SCALA_CLASSPATH -i ~/import.scala'
alias sce='scala'
alias ex='extract'
alias be='bundle exec'
alias grv='grepvim'
alias dircolors="gdircolors"
alias zmv='noglob zmv -W'
alias ls="ls -a"
#alias msf='cd /opt/msf/ && ./msfconsole'
alias gotr="altr"

alias qrank="w3m http://qrank.wbsrv.net/"
alias color-terminal='for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo'
alias ds.store="sudo find ./ -name '.DS_Store' -delete"
alias rgen="rake generate && rake preview"
alias where="command -v"
alias remem='du -sx / &> /dev/null & sleep 5 && kill $!'

alias vs='vim ~/.vimrc'
alias plug="vim $DOTFILE/.vimrc.plug"
alias zs='vim ~/.zshrc'
alias ts='vim ~/.tmux.conf'
alias zr='source ~/.zshrc && exec $SHELL'
alias zd='vim ~/dotfiles/.zshrc'
alias vim-trans='vim -c "ExciteTranslate"'
alias gistvim='vim * -c "bufdo %s/foo/bar/g | Gist"'
alias f='vim +VimFiler'
alias w3mjman='W3MMAN_MAN=jman w3mman'
alias w3h='rm ~/.w3m/history && w3m -N'
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'
alias z="_z"
alias j="cdr"

case $OSTYPE in
    darwin*)
        #/Applications/VLC.app/Contents/MacOS/VLC -I rc
        # interface:ncurses, speed:2
	alias p='sudo purge'
	alias o='qlmanage -p "$@" >& /dev/null'
        alias trash="sudo rm -rf ~/.Trash/"
        alias qm='qlmanage -p "$@" >& /dev/null'
        alias st='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
        alias sy='open -a "system preferences"'
        alias cvlc='/Applications/VLC.app/Contents/MacOS/VLC --rate=2.5 && sleep 3;reset'
        alias video="cvlc ~/Movies"
        alias vlc1='killall -KILL VLC'
        alias ctags="`brew --prefix`/usr/local/bin/ctags"
        alias u="brew update && brew upgrade"
        alias ll='gls -slhAF --color'
        alias gls='gls -lAFh --color=auto'
        #eval `dircolors ~/dotfiles/dircolors-solarized/dircolors.ansi-dark`
        ;;
    linux*)
        if ! which cvlc > /dev/null 2>&1;then
            sudo pacman -S vlc
        fi
        alias cvlc="cvlc -I ncurses --rate=2.5"
        alias video="cvlc ~/Videos"
        #alias cvlc="cvlc -I ncurses --rate=2 --global-key-audiodevice-cycle Master"
        #alias cvlc="cvlc -I ncurses --rate=2 --key-audiodevice-cycle Master"
        alias u="sudo pacman -Syu --noconfirm && sudo yaourt -Syua --noconfirm"
        alias vim="/usr/bin/vim"
        alias mf="free"
        ;;
esac

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

if [ ! -f $DOTFILE/.vimrc.seclet ];then
    touch $DOTFILE/{.zshrc.seclet,.vimrc.seclet}
fi

### }}}

### source {{{
#
###source $PLUGIN/oh-my-zsh
#if [ ! -d $PLUGIN/install.zsh ];then
#	git clone https://github.com/syui/install.zsh $PLUGIN/install.zsh
#	zsh $PLUGIN/install.zsh/install.zsh
#fi
case $OSTYPE in
	darwin*)
		if [ -f $DOTFILE/.zshrc.mac ];then
			source $DOTFILE/.zshrc.mac
		fi
		;;
	linux*)
		if [ -f $DOTFILE/.zshrc.linux ];then
			source $DOTFILE/.zshrc.linux
		fi
		;;
esac
source $PLUGIN/z/z.sh
compctl -U -K _z_zsh_tab_completion ${_Z_CMD:-z}
source ~/dotfiles/.zsh/plugin/zaw/zaw.zsh
source $HOME/dotfiles/.zsh/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source $PLUGIN/safari.zsh/safari.zsh
source $DOTFILE/.zshrc.seclet
[[ -s "$HOME/.qfcz/bin/qfcz.zsh" ]] && source "$HOME/.qfcz/bin/qfcz.zsh"
if [ -d $PLUGIN/memo.zsh ];then
    source $PLUGIN/memo.zsh/memo.zsh
fi
#source ~/dotfiles/.zsh/plugin/golang-crosscompile/crosscompile.bash
#if ruby -v | grep 2.2.0 > /dev/null 2>&1;then
#    sudo gem install qiita
#fi

#
#[ -f ~/.zshrc.local ] && source ~/.zshrc.local
#
#[ -s ${HOME}/.rvm/scripts/rvm ] && source ${HOME}/.rvm/scripts/rvm
#
case $OSTYPE in
    darwin*)
#        source $PLUGIN/airchrome.zsh/airchrome.zsh
        source $PLUGIN/growl.zsh
    ;;
esac
#

# zaw-cdrが動かない時はコメントを外す
# unsetopt sh_word_split
#
#### }}}

### bindkey {{{

bindkey -M viins 'jj' vi-cmd-mode
bindkey "^I" menu-complete
bindkey '^h^h' run-help
function peco-tree-vim(){
  local SELECTED_FILE=$(zsh -c "ls -A" | peco | xargs echo)
  BUFFER="vim $SELECTED_FILE"
  zle accept-line
}
zle -N peco-tree-vim
bindkey '^o^o' peco-tree-vim
#bindkey -s '^o' "open -a "
bindkey "^[u" undo
bindkey "^[r" redo
bindkey '^]'   vi-find-next-char
bindkey '^[^]' vi-find-prev-char
bindkey "^?" backward-delete-char
bindkey -a 'q' push-line
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[2~' overwrite-mode
bindkey '^[[3~' delete-char
bindkey '^[[A'  up-line-or-history
bindkey '^[[B'  down-line-or-history
bindkey '^[[C'  forward-char
bindkey '^[[D'  backward-char
bindkey '^[[5~' history-beginning-search-backward
bindkey '^[[6~' history-beginning-search-forward

## zaw {{{
bindkey '^x' zaw
bindkey '^h' zaw-history
bindkey '^@' zaw-gitdir
bindkey '^r' zaw-open-file
#case $OSTYPE in
#    darwin*)
#        bindkey '^[^[' zaw-cdr
#        ;;
#    linux*)
#        bindkey '^j^j' zaw-cdr
#        ;;
#esac
#bindkey '^j^k' zaw-z

zaw-z-f (){
    zawzf=`z | peco | cut -d ' ' -f 2-`
    echo $zawzf
    z $zawzf
}
zle -N zaw-z-f
#case $OSTYPE in
#    linux*)
#        bindkey '^j^k' zaw-z-f
#        ;;
#    darwin*)
#        bindkey '^[^k' zaw-z-f
#        ;;
#esac

### }}}

### }}}

### function {{{
ex() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

grepvim() {
    XFS=`grep -ERUInl $* | uniq | xargs`
    if [ "$XFS" ] ; then
        vim `grep -ERUInl $* | uniq | xargs`
    fi
}

function gte() {
google_translate "$*" "en-ja"
}

function gtj() {
google_translate "$*" "ja-en"
}

function google_translate() {
local str opt cond

if [ $# != 0 ]; then
    str=`echo $1 | sed -e 's/  */+/g'` # 1文字以上の半角空白を+に変換
    cond=$2
    if [ $cond = "ja-en" ]; then
        # ja -> en 翻訳
        opt='?hl=ja&sl=ja&tl=en&ie=UTF-8&oe=UTF-8'
    else
        # en -> ja 翻訳
        opt='?hl=ja&sl=en&tl=ja&ie=UTF-8&oe=UTF-8'
    fi
else
    opt='?hl=ja&sl=en&tl=ja&ie=UTF-8&oe=UTF-8'
fi

opt="${opt}&text=${str}"
w3m +13 "http://translate.google.com/${opt}"
}
function make() {
LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot¥sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}
function cwaf() {
LANG=C command ./waf "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot¥sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}

expand-to-home-or-insert () {
    if [ "$LBUFFER" = "" -o "$LBUFFER[-1]" = " " ]; then
        LBUFFER+="~/"
    else
        zle self-insert
    fi
}

function separate(){
echo -n $fg_bold[yellow]
for i in $(seq 1 $COLUMNS); do
    echo -n '~'
done
echo -n $reset_color
}

##alsa
#function vol(){
#case $OSTYPE in
#    darwin*)
#        osascript -e "set Volume ${1}"
#    ;;
#    linux*)
    #        if [ $# != 1 ];then
    #            echo mute
    #            amixer sset Master mute
    #        else
    #            echo $1
    #            amixer sset Master unmute
    #            amixer sset Master ${1}
    #        fi
    #    ;;
    #esac
    #}

    #pulseaudio
    function vol(){
    case $OSTYPE in
        darwin*)
            if [ $# != 1 ];then
                osascript -e "set Volume 0.00001"
            else
                osascript -e "set Volume ${1}"
            fi
            ;;
        linux*)
            if [ $# != 1 ];then
                echo mute
                echo old `pamixer --get-volume`
                pamixer --mute
            else
                echo $1
                pamixer --unmute
                echo old `pamixer --get-volume`
                pamixer --set-volume $1
            fi
            ;;
    esac
}

function manowar () {
mpc volume 100
amixer set PCM 100%
}
function torrent-search(){w3m "http://torrentz.eu/search?f=$1"}
function vmu(){VBoxManage storageattach $1 --storagectl ${1}sata1 --port 2 --type dvddrive --medium emptydrive}
function exdel(){exiftool -overwrite_original -all= $1}

function zman() {
PAGER="less -g -s '+/^       "$1"'" man zshall
}

function ccleaner(){
which ccleaner.scpt | xargs osascript &
open -a iterm2-f
}

function gif_make(){
gm convert *.png hoge.gif
rm *.png
}

function markpre(){
watchmedo shell-command -c "qlmanage -p $1" $HOME/blog/
}

function wifi(){
if networksetup -getairportnetwork en0 | grep off; then
    echo on
    networksetup -setairportpower en0 on
else
    echo off
    networksetup -setairportpower en0 off
fi
}

function aunpack-all(){for i in `ls *.$1`;do aunpack $i;done}

function twitter () {
osascript -e 'tell application "Twitter" to close window 1'
}

function unrar-all (){
for i in *.part1.rar
do
    unrar e -o+ $i
done
}

### git init {{{
#touch README.md
#git init
#git add README.md
#git commit -m "first commit"
#git remote add origin https://github.com/syui/syui.github.io.git
#git push -u origin master
### }}}

function gitinit(){
echo -n username:
user=`echo $USER`
repo=`echo $PWD:t`
repo_j={\"name\":\"$repo\"}
url="https://github.com/"$user/$repo.git
curl -u $user https://api.github.com/user/repos -d $repo_j
case $? in
    0)
        rm -rf .git
        rm -rf .DS_Store
        git init
        echo $url
        git remote add origin $url
        git add .
        git commit --allow-empty -m "noun"
        git push -u origin master
        ;;
esac
}

globalias() {
    if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle self-insert
}
zle -N globalias
bindkey " " globalias
bindkey "^ " magic-space           # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches


#function help-peco (){
#  s=`run-help | tail -n +2 | tr ' ' '\n' | sed '/^$/d' | peco`
#  man $s
#}
#zle -N help-peco

function au(){
case $1 in
    -o|*)
        SwitchAudioSource -a | grep output | cut -d '(' -f 1 | sed -e 's/ *$//' -e 's/$/"/g' -e 's/^/"/g' | peco | xargs -J % SwitchAudioSource -s %
        ;;
    -i)
        SwitchAudioSource -a | grep input | cut -d '(' -f 1 | sed -e 's/ *$//' -e 's/$/"/g' -e 's/^/"/g' | peco | xargs -J % SwitchAudioSource -t input -s %
        ;;
esac
#zle reset-prompt
}
zle -N au
bindkey '\^^' au

### }}}

### google {{{

function google-search() {
local str opt
if [ $ != 0 ]; then
    for i in $*; do
        str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
fi
w3m http://www.google.co.jp/$opt
}

function goy() {
local str opt
if [ $ != 0 ]; then
    for i in $*; do
        str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
    tbs='&tbs=qdr:y'
fi
w3m http://www.google.co.jp/$opt$tbs
}

function gom() {
local str opt
if [ $ != 0 ]; then
    for i in $*; do
        str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
    tbs='&tbs=qdr:m'
fi
w3m http://www.google.co.jp/$opt$tbs
}

# w3mでALC検索
function alc() {
if [ $ != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
else
    w3m "http://www.alc.co.jp/"
fi
}

function youtube-post(){
mkdir -p ~/Movies/youtube
google youtube post ~/Movies/youtube/*.mp4 --category People --tags "blog"
google youtube list --delimiter ','
}

functions mod(){
mkdir ~/Music/speed
cd ~/Music/speed && touch mylist.test && rm mylist* && mylist && mplayer -playlist mylist -speed 2.5 -af scaletempo,volnorm
}

# w3mでyoutube検索
function youtube-search() {
if [ $ != 0 ]; then
    w3m "http://www.youtube.com/results?search_query=$*&search_type=&aq=f"
else
    w3m "http://youtube.com/"
fi
}

# google booksの検索
function book-search() {
local str opt
if [ $ != 0 ]; then
    for i in $*; do
        str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?lr=lang_ja&hl=JA&tbo=p&tbm=bks&tbs=,bkv:p&num=10'
    opt="${opt}&q=${str}"
fi
w3m http://www.google.co.jp/$opt
}

function exmap (){
str=`exiftool -c "%.6f" -GPSPosition ${1} | sed -e 's/GPS Position//' -e 's/://' -e 's/E//'  -e 's/S//' -e 's/W//' -e 's/N//' -e 's/ //g'`
open -a Google\ Chrome "https://maps.google.co.jp/maps?q=$str"
}

function chrome() {
local str opt
if [ $ != 0 ]; then
    for i in $*; do
        str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
fi
open -a Google\ Chrome http://www.google.co.jp/$opt
}

function google_translate() {
local str opt arg

str=`pbpaste` # clipboard
arg=`echo ${@:2} | sed -e 's/  */+/g'` # argument
en_jp="?hl=ja&sl=en&tl=ja&ie=UTF-8&oe=UTF-8" # url

case "$1" in
    "-j") opt="?hl=ja&sl=ja&tl=en&ie=UTF-8&oe=UTF-8&text=${arg}";; # jp -> en translate
    "-e") opt="${en_jp}&text=${arg}";; # en -> jp translate
    *) opt="${en_jp}&text=${str}";; # en -> jp translate
esac

w3m +20 "http://translate.google.com/${opt}"  # goto 20 line
}

# blogger
function bp(){
TITLE="$(awk 'NR==1' $1)"
TAG="$(awk 'NR==2' $1)"
sed -ie 1,2d $1
google blogger post --blog "MBA-HACK" --title "${TITLE}" --tags "${TAG}" $1
url=`google blogger list url --title "${TITLE}" | cut -d , -f 2`
open -a Google\ Chrome $url
}



function got(){
w3m "http://www.google.co.jp/search?num=50&hl=ja&lr=lang_ja&q=$2&tbs=qdr:${1}"
}

function img-search () {
dir=~/Downloads/pic
mkdir -p $dir
word=`echo $1 | ruby -r cgi -ne 'puts CGI.escape $_.chomp'`
echo $word
url=`curl "http://ajax.googleapis.com/ajax/services/search/images?q=$word&v=1.0&safe=active&imgsz=xxlarge&rsz=large" | jq -r '.responseData.results [] .url'`
cou=`echo $url | wc -l | tr -d ' '`

for (( i=1;i<$cou;i++ ))
do
    urlo=`echo $url | awk "NR==$i"`
    file=${urlo##*/}
    curl $urlo -o $dir/$file
done

qlmanage -p $dir/*
file=`zsh -c "ls -A $dir" | peco`
url=`echo $url | grep $file`
echo $url | pbcopy && pbpaste
rm -rf $dir

}



### }}}

### prompt {{{
###
source $PLUGIN/powerline.zsh/powerline.zsh
#source $PLUGIN/modeline.zsh
###

## }}}

### media {{{

case $OSTYPE in

    darwin*)
        #function picasa(){
        #    dirp=~/Pictures/picasa
        #    dirc=middleman
        #            rm $dirp/.DS_Store > /dev/null 2>&1
        #    qlmanage -p ${dirp}/*
        #    exiftool -overwrite_original -all= $dirp
        #    case $1 in
        #       "")
        #            rm $dirp/.DS_Store > /dev/null 2>&1
        #            google picasa post -n "$dirc" ~/Pictures/picasa/*
        #            list=`google picasa list "$dirc" --delimiter " " --fields url-direct`
        #            numb=`bash -c "ls -A $dirp" | wc -l | tr -d ' '`
        #            echo "$list" | tail -n $numb | sed -e 's/^/![](/g' -e 's/$/)/g'| pbcopy && pbpaste
        #    ;;
        #    esac
        #    rm -rf $dirp > /dev/null 2>&1
        #    mkdir -p $dirp
        #}

        function chrome_done_reload (){
        osascript << EOF && osascript -e 'tell application "Google Chrome" to close first tab of window 1'
        tell application "Google Chrome"
        repeat while loading of active tab of window 1
        delay 0.1
        end repeat
        activate
        end tell
        EOF

        cat << EOF | osascript | tr ',' "\n"
        tell application "Google Chrome"
        set pageURI to get URL of tab of window 1
        set pageTitle to get title of tab of window 1
        return pageTitle & space & pageURI
        end tell
        EOF
    }

    function history_buffer (){
    BUFFER=`awk '!a[$0]++' ~/.zsh_history | peco`
    CURSOR=$#BUFFER
}
zle -N history_buffer
bindkey '^h^j' history_buffer

function asciinema-js (){
case $OSTYPE in
    darwin*)
        clip=pbcopy
        paste=pbpaste
        ;;
    linux*)
        clip="xsel -i"
        paste="xsel -o"
        ;;
esac
test=`$clip`
cat <<EOF | $clip
<script type="text/javascript" src="${test}.js" id="asciicast-${test##*/}" async></script>
EOF
$paste 
}

function ms (){
dir1=$HOME/Music
file=${0:a:t}
loop=20
speed=2
play=`ps | grep mplayer -s | wc -l | tr -d ' '`

case $play in
    ""|1)
        sea="ID_FILENAME"
        dir="$dir1/"`zsh -c "ls -A $dir1 | peco"`
        com="mplayer -speed $speed -af scaletempo,volnorm -novideo -loop $loop -quiet -msglevel all=0 -identify $dir/*"
        com="${com} | grep $sea"
        eval $com
        ;;
    *)
        pkill mplayer > /dev/null 2>&1
        ;;
esac
}


alias ch="open -a Google\ Chrome --args --gpu-startup-dialog --disable-java --disable-background-mode --renderer-process-limit=2"
alias hatena="~/script/hatena-cli/hatena-cli"
alias nicovideo='nicovideo-dl -t -n'


alias fu="$DOTFILE/bin/fu/fu"
;;

esac

nn (){
    case $OSTYPE in
        linux*)
            #netctl-auto list
            netctl list
            #key=`netctl-auto list | cut -b 1`
            key=`netctl list | grep wlp | cut -b 1`
            case $key in
                #'*') netctl-auto disable-all ;;
                '*') sudo netctl stop-all ;;
                #'!') netctl-auto enable-all ;;
                *) sudo netctl start `find /etc/netctl/wlp* | cut -d / -f4` ;;
            esac
            ;;
    esac
}

function one-liner(){
case $OSTYPE in
    darwin*)
        clip=pbpaste
        copy=pbcopy
        ;;
    linux*)
        clip="xclip -o"
        copy="xclip -i"
        ;;
esac
$clip | tr '\n' '&' | sed 's/&/ && /g' | $copy
$clip;
}
zle -N one-liner
bindkey '^y^y' one-liner

alias android="mkdir -p ~/Android && go-mtpfs ~/Android && lll || fusermount -u ~/Android"

alias -g D="$HOME/Downloads"
alias dis="arandr"

wifi-monitor-macbook (){
    sudo modprobe -r b43
    sudo modprobe -r brcmsmac
    sudo modprobe -r wl

    sudo modprobe b43
    sudo modprobe brcmsmac
    sudo modprobe wl
    iwconfig
}

function ms(){
dir1=$HOME/Music
file=${0:a:t}
loop=20
speed=2
#play=`ps | grep mplayer -s | wc -l | tr -d ' '`

#case $play in
#""|1)
sea="ID_FILENAME"
dir="$dir1/"`zsh -c "ls -A $dir1 | peco"`
#com="mplayer -speed $speed -af scaletempo,volnorm -novideo -loop $loop -quiet -msglevel all=0 -identify $dir/*"
#com="${com} | grep $sea"
#eval $com
mplayer -speed $speed -af scaletempo,volnorm -novideo -loop $loop -quiet $dir/*
#;;
    #*)
        #    pkill mplayer > /dev/null 2>&1
        #;;
        #esac
    }

    autoload -U compinit;
    compinit -u

    # zsh-cdr-error
    unsetopt sh_word_split


    if [ -f /usr/bin/virtualenvwrapper.sh ]; then
        export WORKON_HOME=$HOME/.virtualenvs
        source /usr/bin/virtualenvwrapper.sh
    fi

    # auto-keepass
    if [ ! -d ~/git/airkeepass ];then
        git clone https://github.com/syui/airkeepass ~/git/airkeepass
    fi
    alias keepassa="~/git/airkeepass/airkeepass"

    # googlecl
    function picasa(){
    dirp=~/Pictures/picasa
    url=https://raw.githubusercontent.com/mba-hack/images/master/
    exiftool -overwrite_original -all= ${dirp}
    touch $dirp/*
    cd $dirp
    case "$1" in
        "")
            #git log -1 --name-status | grep png | tr '\t' ',' | cut -d , -f 2 | sed 's#^#https://raw.githubusercontent.com/syui/images/master/#g'
            git log -1 --name-status | grep png | tr '\t' ',' | cut -d , -f 2 | sed "s#^#${url}#g"
            ;;
        u)
            git add -A
            git ci update
            git push
            git log -1 --name-status | grep png | tr '\t' ',' | cut -d , -f 2 | sed "s#^#${url}#g"
            ;;
        o)
            gthumb ${dirp} > /dev/null 2>&1
            git log -1 --name-status | grep png | tr '\t' ',' | cut -d , -f 2 | sed "s#^#${url}#g"
            ;;
        m)
            case $OSTYPE in
                darwin*)
                    git log -1 --name-status | grep -e png -e gif -e jpg -e jpeg | tr '\t' ',' | cut -d , -f 2 | sed -e "s#^#\!\[\]\(${url}#g" -e "s/$/\)/g" | pbcopy && pbpaste
                    ;;
                linux*)
                    git log -1 --name-status | grep -e png -e jpg -e jpeg -e gif | tr '\t' ',' | cut -d , -f 2 | sed -e "s#^#\!\[\]\(${url}#g" -e "s/$/\)/g" | xclip -i -sel c && xclip -o -sel c
                    ;;
            esac
            ;;
    esac

    #dirp=~/Pictures/picasa
    #dirc=middleman
    #gthumb ${dirp} > /dev/null 2>&1
    #exiftool -overwrite_original -all= ${dirp}
    #case $1 in
    #   "")
    #        sudo google picasa post -n "$dirc" ~/Pictures/picasa/*
    #        list=`sudo google picasa list "$dirc" --delimiter " " --fields url-direct`
    #        numb=`bash -c "ls -A $dirp" | wc -l | tr -d ' '`
    #        echo "$list" | tail -n $numb | sed -e 's/^/![](/g' -e 's/$/)/g' | xclip -i -sel c && xclip -o -sel c
    #;;
    #esac
    #rm -rf $dirp > /dev/null 2>&1
    #mkdir -p $dirp
}

function ffg (){
bas=`cat << EOF | peco | tr -d ' '
mp4 -> mp3
flv -> mp3
swf -> mp3
mp3 -> wav
flv -> wav
mov -> gif
jpg -> png
bmp -> png
gif -> mp4
EOF` > /dev/null 2>&1

inp=`echo $bas | cut -d '-' -f 1`
oup=`echo $bas | cut -d '>' -f 2`

case $inp in

    swf)
        for i in *.${inp}; do swfextract -m $i -o ${i%.swf}.mp3; done
        ;;

    mov)
        for i in *.${inp}; do ffmpeg -i *.mov -r 8 %04d.png && gm convert *.png ${i%.*}.gif && rm *.png; done
#for i in *.mp4; do ffmpeg -i *.mov -r 8 %04d.png && gm convert *.png ${i%.*}.gif && rm *.png; done
        ;;
    jpg)
        mogrify -format png -quality 100 *.jpg
        ;;

    bmp)
        mogrify -format png -quality 100 *.bmp
        ;;

    *)
        for i in *.${inp}; do ffmpeg -i $i -vn ${i%.*}.${oup}; done
        ;;

    esac
}

## twitter
function tweetvim (){
case $1 in
    "")
        vim +TweetVimHomeTimeline
        ;;
    t)
        vim +TweetVimSay
        ;;
    m)
        vim +TweetVimMentions +/@
        ;;
    l)
        vim -c "TweetVimListStatuses $2" +/http
        ;;
    $USER)
        vim -c "TweetVimUserTimeline syui__"
        ;;

    esac
}

alias t="tweetvim"
alias qiita-line="curl -I 'https://qiita.com/api/v1/items.json'"
alias lingr="vim +J6uil +J6uilStartNotify"
#alias html2text='python ~/html2text/html2text.py'
alias mylist='find `pwd` -maxdepth 1 -mindepth 1 | grep -v "\/\." > mylist'

export PATH=$PATH:$DOTFILE/script

#bindkey -s '^n^n' 'xdotool mousemove 1300 40 click 1'
#functions notify-send-click (){
#    xdotool key --window `xdotool getactivewindow` --clearmodifiers Return
#}
#zle -N notify-send-click
#bindkey '^n' notify-send-click
## ...enterを直に押さないとダメみたいだ。notify-send

functions d(){
case $1 in
    -[hH]|[hH]|--[hH]elp)
        echo '
        s)systemctl --state=failed
        p)cat /var/log/pacman.log
        j)journalctl -f
        l)systemctl list-units | cat
        u)systemctl list-unit-files | grep enabled
        '
        ;;
    s)systemctl --failed
        ;;
    p)cat /var/log/pacman.log
        ;;
    j)journalctl -f
        ;;
    l)systemctl list-units | cat
        ;;
    u)systemctl list-unit-files | grep enabled
        ;;
    *)c=`d -h|sed '/^$/d'|peco|cut -d ')' -f 2-`;zsh -c "$c"
        ;;
esac
}

alias a="/home/syui/git/a.zsh/a.zsh"
alias jekyll-server="rvm use 1.9.3 && jekyll server > /dev/null 2>&1 &"
alias jekyll-stop="ps -ax | grep jekyll | grep -v grep | cut -d ' ' -f1 | xargs kill"

#bindkey -s '^o' "a "

case $OSTYPE in
    darwin*)
        alias gitssh="sed -i "" 's#https://github.com/#git@github.com:#g' ./.git/config"
        ;;
    linux*)
        alias gitssh="sed -i 's#https://github.com/#git@github.com:#g' ./.git/config"
        alias haroopad='haroopad > /dev/null 2>&1 &'
        alias firefox='firefox > /dev/null 2>&1 &'
        ;;
esac


alias torc="sudo chroot --userspec=tor:tor /opt/torchroot /usr/bin/tor"

#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=setting'
#export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel' 
#export JAVA_FONTS=/usr/share/fonts/TTF

gitrebase(){
    host=https://github.com/
    user=${host}/$USER
    repo=${user}/`echo $PWD:t`
    dire=`echo $PWD:t`
    git clone ${repo} ${dire}.backup
    cd ${dire}.backup
    git rebase -i --root
    git add -A
    git rebase --continue
    git commit -m "git-rebase-new"
    git push -f
    cd ../
    rm -rf .git
    mv ${dire}.backup/.git .
    rm -rf ${dire}.backup
    git add -A
    git commit -m "git-rebase-new"
    git push -f
}

app-search(){
    case $OSTYPE in
        cygwin*)
            os=windows
            ;;
        darwin*)
            os=mac
            ;;
        linux*)
            os=linux
            ;;
    esac
    if [ $# = 0 ];then
        cat $APPJSON | jq -r ".[].$os" | grep -v null
    else
        case ${1} in
            [hH]|-[hH]|--[hH]elp)
                echo "
                str: search app
                -h : help
                -e : edit
                -a : all app
                -u : all url
                -t : all tag
                -c : all command
                "
                ;;
            [aA]|-[aA])
                cat $APPJSON | jq -r ".|.[]|.${os}"
                ;;
            [eE]|-[eE])
                vim $APPJSON
                ;;
            [uU]|-[uU])
                cat $APPJSON | jq -r ".|.[]|.${os}" | grep -v null | jq -r ".[][].url"
                ;;
            [tT]|-[tT])
                cat $APPJSON | jq -r ".|.[]|.${os}" | grep -v null | jq -r ".[][].tag"
                ;;
            [cC]|-[cC])
                cat $APPJSON | jq -r ".|.[]|.${os}" | grep -v null | jq -r ".[][].command"
                ;;
            *)
                cat $APPJSON | jq -r ".|.[]|.${os}" | grep -v null | jq -r ".[].${1}"
                ;;
        esac
    fi
}

### }}}

### os {{{
case $OSTYPE in
    linux*)
        bindkey -v
        export CLICOLOR=1
        export LSCOLORS=ExFxCxDxBxegedabagacad
        export PATH
        # man path
        MANPATH=/usr/local/man:$MANPATH
        export MANPATH
        INFOPATH=/usr/local/info:$INFOPATH
        export INFOPATH

        # Java
        #export JAVA_HOME=/usr/java/default
        #export PATH=$JAVA_HOME/bin:$PATH

        # Maven2
        export MAVEN_HOME=/usr/local/apache-maven-2.2.1
        export PATH=$MAVEN_HOME/bin:$PATH
        export MAVEN_OPTS=-Xmx1024M

        #rvm
        #if ! which rvm > /dev/null 2>&1;then
        #    curl -sSL https://get.rvm.io | bash -s stable
        #fi
        if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi
        if [[ -s /usr/local/rvm/scripts/rvm ]] ; then source /usr/local/rvm/scripts/rvm ; fi
        export PATH=$PATH:$HOME/.gem/ruby/1.8/bin

        #alias
        alias ls='ls -alh --color'
        alias vim="/usr/bin/vim"
        alias v="/usr/bin/vim"
        ;;

    darwin*)
        #if ! brew list > /dev/null 2>&1;then
        #    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        #fi
        #if ! brew brewdle dump > /dev/null 2>&1;then
        #    brew tap Homebrew/brewdler
        #fi
        #if [ ! -f $HOME/Brewfile ];then
        #    cd $HOME
        #    brew brewdle dump
        #fi
        if [ ! -f /usr/local/bin/terminal-notifier ];then
            brew install terminal-notifier
        fi
        if [ ! -f /usr/local/bin/go ];then
            brew install go
        fi
        if [ ! -f /usr/local/bin/zsh ];then
            brew install zsh
        fi
        if [ ! -f /usr/local/bin/tmux ];then
            brew install tmux
        fi
        if [ ! -f /usr/local/bin/git ];then
            brew install git
        fi
        if [ ! -f /usr/local/bin/gdircolors ];then
            brew install coreutils
        fi
        if [ ! -f /usr/local/bin/ctags ];then
            brew install ctags
        fi
        if ! which reattach-to-user-namespace > /dev/null 2>&1;then 
            brew install reattach-to-user-namespace 
        fi

        zle -N expand-to-home-or-insert
        bindkey -v
        bindkey "@"  expand-to-home-or-insert
        export PATH=/usr/local/bin:/usr/local/sbin:$PATH
        export PATH=/opt/local/bin:/opt/local/sbin:~/bin:$PATH

        # osx alias
        alias pbc='pbcopy'
        #alias vo='osascript -e "set Volume 0.00001"'
        # Terminal Colorの設定
        export CLICOLOR=1
        export LSCOLORS=ExFxCxDxBxegedabagacad

        ## vim
        export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
        #alias vi='/opt/local/bin/vim'
        alias vi='/usr/local/bin/vim'
        alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        alias v='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

        ##Java7
        #export JAVA_HOME=/Library/Java/JavaVirtualMachines/1.7.0.jdk/Contents/Home
        # export JAVA_HOME=/Library/Java/Home
        #export PATH=$JAVA_HOME/bin:$PATH
        ## デフォルトエンコーディングSJISをUTF-8へ
        #export _JAVA_OPTIONS="-Dfile.encoding=UTF-8"

        # haskell
        export PATH=/Users/ozaki/Library/Haskell/bin:$PATH

        # scala
        export SCALA_HOME=/Users/ozaki/.svm/current/rt
        PATH=$SCALA_HOME/bin:$PATH
        export SCALA_DOC_HOME=$SCALA_HOME/../devel-docs/api/
        export SCALA_CLASSPATH=~/sandbox/scala/yuroyoro/yuroyoro-util/target/yuroyoro-util-1.0.jar

        # Ant
        export ANT_VERSION=1.8.0
        export ANT_HOME=~/dev/Tools/apache-ant-${ANT_VERSION}
        export ANT_OPTS=-Xmx1g
        export PATH=$ANT_HOME/bin:$PATH

        # Maven2
        export MAVEN_VERSION=2.2.1
        export MAVEN_HOME=~/dev/Tools/apache-maven-${MAVEN_VERSION}
        export PATH=$MAVEN_HOME/bin:$PATH
        export MAVEN_OPTS=-Xmx1024M

        # man path
        MANPATH=/usr/local/man:$MANPATH
        export MANPATH
        INFOPATH=/usr/local/info:$INFOPATH
        export INFOPATH

        # Mysql
        export MYSQL_HOME=/usr/local/mysql
        export PATH=$MYSQL_HOME/bin:$PATH
        alias h2db='java -cp ~/.m2/repository/com/h2database/h2/1.1.112/h2-1.1.112.jar org.h2.tools.Server'

        # STAX SDK
        export STAX_HOME=~/dev/Project/sandbox/stax-sdk-0.2.11
        export PATH=$PATH:$STAX_HOME

        # Adobe AIR
        export AIR_HOME=~/dev/air
        export FLEX_HOME=~/dev/flex
        export PATH=$PATH:$AIR_HOME/bin:$FLEX_HOME/bin
        export GAE_SDK_VERSION=1.3.4
        GAE_SDK_INSTALLED_DIR=~/sandbox/GoogleAppEngine/sdk
        export GAE_HOME=$GAE_SDK_INSTALLED_DIR/$GAE_SDK_VERSION/google_appengine
        export PATH=$PATH:$GAE_HOME
        export GAEJ_SDK_VERSION=1.3.7
        GAEJ_SDK_INSTALLED_DIR=~/sandbox/GAEJava/sdk
        export GAEJ_HOME=$GAEJ_SDK_INSTALLED_DIR/appengine-java-sdk-$GAEJ_SDK_VERSION
        export PATH=$PATH:$GAEJ_HOME/bin
        export REFE_DATA_DIR=/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/share/refe
        export GOROOT=$HOME/dev/go
        export GOOS=darwin
        export GOARCH=386
        export PATH=$PATH:$GOROOT/bin
        export NODE_PATH=/usr/local/lib/node:$PATH
        export PATH=/usr/local/share/npm/bin:$PATH
        export JRUBY_HOME=$HOME/sandbox/jruby/jruby-1.5.2
        export PATH=$PATH:$JRUBY_HOME/bin
        export MIRAH_HOME=$HOME/sandbox/mirah/mirah
        export PATH=$PATH:$MIRAH_HOME/bin
        alias tma='tmux attach'
        alias tml='tmux list-window'
        source ~/.rvm/scripts/rvm
        ;;
esac

### }}}

### ssh {{{
# zsh-5.0.8
# zsh-surround
# http://qiita.com/ToruIwashita/items/eaefada1346e97d09fdb
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

autoload -Uz surround
zle -N delete-surround surround
zle -N change-surround surround
zle -N add-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# http://papix.hatenablog.com/entry/2014/11/07/182850
function peco-ssh() {
  SSH=$(grep "^\s*Host " ~/.ssh/config | sed s/"[\s ]*Host "// | grep -v "^\*$" | sort | peco)
  ssh $SSH
}
alias ss="peco-ssh"


### }}}

### tor {{{
alias chrome='open -a Google\ Chrome --args --proxy-server=="socks5://localhost:9050" --host-resolver-rules="MAP * 0.0.0.0, EXCLUDE localhost"'
#alias curl="curl --socks5 localhost:9050"
alias ssh-tor="torsocks ssh"
if ps -ax | grep -w tor | grep -v grep > /dev/null 2>&1;then
   export http_proxy=socks5://127.0.0.1:9050
   export https_proxy=$http_proxy
   export ftp_proxy=$http_proxy
   export rsync_proxy=$http_proxy
   export HTTP_PROXY=$http_proxy
   export HTTPS_PROXY=$http_proxy
   export FTP_PROXY=$http_proxy
   export RSYNC_PROXY=$http_proxy
   #export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
else
   unset http_proxy
   unset https_proxy
   unset ftp_proxy
   unset rsync_proxy
   unset HTTP_PROXY
   unset HTTPS_PROXY
   unset FTP_PROXY
   unset RSYNC_PROXY
fi

### }}}

### clipboard {{{

## pbcopy
#case ${OSTYPE} in
#    linux*)
#        if [ ! -f /usr/bin/xsel ];then
#            sudo pacman -S xsel
#        fi
#        alias pbcopy='xsel --clipboard --input'
#        ;;
#    cygwin*)
#        alias pbcopy='putclip'
#        ;;
#esac

## buffer
pbcopy-buffer(){
    case ${OSTYPE} in
        freebsd*|darwin*)
            print -rn $BUFFER | pbcopy
            ;;
        linux*)
            print -rn $BUFFER | xclip -i -selection clipboard
            ;;
        cygwin*)
            print -rn $BUFFER | putclip
            ;;
    esac
    zle -M "copy : ${BUFFER}"
}
zle -N pbcopy-buffer
bindkey '^p^p' pbcopy-buffer

## alias
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xclip >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xclip --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

## bindkey
# bindkey -s '^b' " | pbcopy"

## clipboard-history
function clipboard-history (){
case $OSTYPE in
    linux*)
        if [ ! -f /usr/bin/anamnesis ];then
            sudo yaourt -S anamnesis
        fi
        anamnesis -l 100 | sed -n '3,100p' | peco | cut -d u -f 2- | head -c -3 | tail -c +2  | xclip -i -selection clipboard
        ;;
    freebsd*|darwin*)
        plutil -convert xml1 ~/Library/Application\ Support/ClipMenu/clips.data -o - | parsrx.sh | grep '/plist/dict/array/string ' | sed '1,2d' | sed 's/\/plist\/dict\/array\/string//g' | peco | pbcopy
        ;;
esac
}
zle -N clipboard-history
bindkey '^[c' clipboard-history
### }}}

### memo {{{
# {
#    "os" : [ "archlinux", "coreos", "docker", "rocket", "vagrant", "awesome", "conky", "aplinelinux" ],
#    "terminal" : [ "msys2", "cygwin", "nyagos", "powershell", "vim", "tmux", "git" ],
#    "tool" : [ "dwb", "spacefm", "growl", "ffmpeg", "imagemagick", "googlecl", "keepass", "jq", "nc", "ssh", "mosh", "nmap", "weechat", "metasploit", "wireshark", "wercker", "hugo", "middleman", "feh", "android-terminal-emulater", "xdotool", "xmodmap", "peco" ],
#    "lang" : [ "c++", "python", "ruby", "lua", "go", "scala", "coffescript", "perl", "scss", "slim", "node.js", "swift", "gauche" ]
#  }
#}

# sudo pacman -S xorg xorg-xinit xterm 
# sudo pacman -S virtualbox-guest-modules virtualbox-guest-utils  
# slim,awesome,yaourt,pacman
# modprobe -a vboxguest vboxsf vboxvideo
# ~/.xinitrc:VBoxClient-all
# sudo pacman -S fcitx fcitx-mozc fcitx-im clipit 
# sudo pacman -S yaourt awesome slim vicious 
# sudo pacman -S spacefm 
# sudo rm -rf /usr/share/icons/Adwaita
# zsh ~/dotfiles/setfile.sh
# /etc/vconsole.conf
#KEYMAP=jp106
#FONT=Lat2-Terminus16
#FONT_MAP=8859-2

# sudo pacman -S xbindkeys
# sudo pacman -S xdotool
### }}}

#mplayer
#mplayer -fixed-vo -speed 3 -af scaletempo,volnorm -playlist mylist 
#mplayer -fixed-vo -speed 2.5 -af scaletempo -playlist mylist 
#
#android
export ANDROID_HOME=$HOME/Applications/android-sdk-macosx
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

#LANG="en_US.UTF-8"
#LC_COLLATE="en_US.UTF-8"
#LC_CTYPE="en_US.UTF-8"
#LC_MESSAGES="en_US.UTF-8"
#LC_MONETARY="en_US.UTF-8"
##LC_NUMERIC="en_US.UTF-8"
#LC_TIME="en_US.UTF-8"
#LC_ALL="en_US.UTF-8"
#

