
## pacman
if [ ! -f /bin/tmux ]; then
    pacman-db-upgrade
    pacman -Syu --noconfirm
    pacman -S zsh tmux git go
fi

if [ ! -f /bin/youtube-dl ]; then
    pacman -S youtube-dl
fi

## fu
if [ ! -d $DOTFILE/bin/fu ];then
    git clone https://github.com/samirahmed/fu $DOTFILE/bin/fu
    cd $DOTFILE/bin/fu
fi
alias fu="$DOTFILE/bin/fu/fu"

## completion
if [ ! -d $PLUGIN/zsh-completions ];then
    git clone git://github.com/zsh-users/zsh-completions $PLUGIN/zsh-completions
fi
fpath=($PLUGIN/zsh-completions/src $fpath)

## powerline {{{
#if [ ! -f $PLUGIN/powerline.zsh ];then
#    curl https://gist.githubusercontent.com/syui/e3fad84e3dba8a3f667b/raw/powerline.zsh -o $PLUGIN/powerline.zsh
#fi

if [ ! -d $PLUGIN/powerline.zsh ];then
    git clone https://github.com/syui/powerline.zsh $PLUGIN/powerline.zsh
fi

if [ ! -d $PLUGIN/powerline-bash ];then
    git clone https://github.com/milkbikis/powerline-bash $PLUGIN/powerline-bash
fi

## tmux-powerline {{{
# iTerm : Treat ambiguous-width characters as double width
case $OSTYPE in
    darwin*)
        if ! type tmux > /dev/null 2>&1;then
            brew tap waltarix/homebrew-customs
            brew update
            brew install waltarix/customs/tmux
        fi
    ;;
esac

if type tmux > /dev/null 2>&1;then
    if [ ! -d $DOTFILE/.tmux/tmux-powerline ];then
        TPOWERLINE=$DOTFILE/.tmux/tmux-powerline
        git clone https://github.com/erikw/tmux-powerline $DOTFILE/.tmux/tmux-powerline
    fi
    if [ ! -d $DOTFILE/.tmux/tmux-colors-solarized ];then
        git clone https://github.com/seebi/tmux-colors-solarized $DOTFILE/.tmux/tmux-colors-solarized
    fi
fi

if [ ! -f $DOTFILE/.tmux/tmux-powerline/segments/used-mem ];then
    curl https://raw.githubusercontent.com/yonchu/used-mem/master/used-mem -o $DOTFILE/.tmux/tmux-powerline/segments/used-mem
    chmod +x $DOTFILE/.tmux/tmux-powerline/segments/used-mem
fi

if [ ! -f $DOTFILE/.tmux/tmux-powerline/segments/mplayer_tmux.sh ];then
    curl https://raw.githubusercontent.com/syui/mplayer_script/master/mplayer_tmux.sh -o $DOTFILE/.tmux/tmux-powerline/segments/mplayer_tmux.sh
    chmod +x $DOTFILE/.tmux/tmux-powerline/segments/mplayer_tmux.sh
fi

if [ ! -f $DOTFILE/.tmux/.tmux.conf.mac ];then
    curl https://raw.githubusercontent.com/syui/dotfiles/master/.tmux/.tmux.conf.mac -o $DOTFILE/.tmux/.tmux.conf.mac
fi

case $OSTYPE in
    linux*)
if [ ! -f $DOTFILE/.tmux/tmux-powerline/config/tmux-powerline-config-defaults.sh ];then
    curl https://raw.githubusercontent.com/syui/dotfiles/master/.tmux/defaults.sh -o $DOTFILE/.tmux/tmux-powerline/config/tmux-powerline-config-defaults.sh
    bash -c "cp -f $DOTFILE/.tmux/tmux-powerline/config/tmux-powerline-config-defaults.sh $DOTFILE/.tmux/tmux-powerline/config/defaults.sh"
fi

if [ ! -f $DOTFILE/.tmux/tmux-powerline/themes/origin.sh ];then
    curl https://raw.githubusercontent.com/syui/dotfiles/master/.tmux/origin.sh -o $DOTFILE/.tmux/tmux-powerline/themes/origin.sh
fi
;;
esac

## }}}

## vim
if [ ! -d ~/.vim/bundle/neobundle.vim ];then
    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ];then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ ! -d ~/.vim/bundle/vim-easymotion ];then
    git clone https://github.com/Lokaltog/vim-easymotion ~/.vim/bundle/vim-easymotion
fi

## rupa/z
case $OSTYPE in
  drawin*)
    if [ -f `brew --prefix`/etc/profile.d/z.sh ];then
      brew install z
    fi
    . `brew --prefix`/etc/profile.d/z.sh
    ;;
  linux*)
    if [ ! -d ~/dotfiles/.zsh/plugin/z ];then
      git clone https://github.com/rupa/z ~/dotfiles/.zsh/plugin/z
    fi
    . ~/dotfiles/.zsh/plugin/z/z.sh
    ;;
esac

compctl -U -K _z_zsh_tab_completion ${_Z_CMD:-z}

## zaw/zaw
if [ ! -d ~/dotfiles/.zsh/plugin/zaw ];then
  git clone https://github.com/zsh-users/zaw ~/dotfiles/.zsh/plugin/zaw
fi
if [ ! -f ~/dotfiles/.zsh/plugin/zaw/sources/zaw-z.zsh ];then
  curl https://raw.githubusercontent.com/lovingly/dotfiles/master/zsh.d/zaw/zaw-z.zsh -o $HOME/dotfiles/.zsh/plugin/zaw/sources/zaw-z.zsh
  chmod +x $HOME/dotfiles/.zsh/plugin/zaw/sources/zaw-z.zsh
fi

