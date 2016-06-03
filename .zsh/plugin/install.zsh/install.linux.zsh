### download {{{

#setting

if [ ! -d ~/.vim/swap ];then
	echo     "passwd=root"
	mkdir -p ~/.vim/{undo,tmp,swap}
fi
		
export DOTFILE=$HOME/dotfiles
export PLUGIN=$DOTFILE/.zsh/plugin
export GITHUB=https://github.com
export RAWGIT=https://raw.githubusercontent.com
export ORIGIN=$GITHUB/syui
export ORIRAW=$RAWGIT/syui/master
export APPJSON=$DOTFILE/Documents/app.json

PATH=$PATH:$DOTFILE/script/download-cli

if [ ! -d $DOTFILE ];then
    mkdir -p $DOTFILE
fi
if [ ! -d $PLUGIN ];then
    mkdir -p $PLUGIN
fi
if [ ! -d $DOTFILE/.tmux ];then
    mkdir -p $DOTFILE/.tmux
fi

if [ ! -d $DOTFILE/Documents ];then
    mkdir -p $DOTFILE/Documents
fi

## golang {{{
if ! which go > /dev/null 2>&1;then
    sudo pacman -S go --noconfirm
fi

if [ -x "`which go`" ]; then
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

if [ ! -d ~/dev/go ];then
    mkdir -p ~/dev/go
fi

if [ ! -f $GOPATH/bin/peco ];then
    go get github.com/peco/peco/cmd/peco
fi

if [ ! -f $GOPATH/bin/ttygif ];then
    go get github.com/sugyan/ttygif
fi

## }}}
## completion
if [ ! -d $PLUGIN/zsh-completions ];then
    git clone git://github.com/zsh-users/zsh-completions $PLUGIN/zsh-completions
fi
fpath=($PLUGIN/zsh-completions/src $fpath)

## powerline {{{
if [ ! -d $PLUGIN/powerline.zsh ];then
    git clone https://github.com/syui/powerline.zsh $PLUGIN/powerline.zsh
fi

if [ ! -d $PLUGIN/powerline-bash ];then
    git clone https://github.com/milkbikis/powerline-bash $PLUGIN/powerline-bash
fi

### tmux-powerline {{{
if type tmux > /dev/null 2>&1;then
    if [ ! -d $DOTFILE/.tmux/tmux-powerline ];then
        TPOWERLINE=$DOTFILE/.tmux/tmux-powerline
        git clone https://github.com/syui/tmux-powerline $DOTFILE/.tmux/tmux-powerline
    fi
    if [ ! -d $DOTFILE/.tmux/tmux-colors-solarized ];then
        git clone https://github.com/seebi/tmux-colors-solarized $DOTFILE/.tmux/tmux-colors-solarized
    fi
fi
### }}}

## vim
if [ ! -d ~/.vim/autoload/plug.vim ];then
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

#if [ ! -d ~/.vim/bundle/vimproc.vim ];then
#	git clone https://github.com/Shougo/vimproc.vim.git ~/.vim/bundle/vimproc.vim
#	cd ~/.vim/bundle/vimproc.vim
#	make
#fi

if [  -d /Applications/MacVim.app ];then
	cp -rf ~/.vim/bundle/vimproc.vim/autoload/ /Applications/MacVim.app/Contents/Resources/vim/runtime/autoload/ 
	cp -rf ~/.vim/bundle/vimproc.vim/plugin/ /Applications/MacVim.app/Contents/Resources/vim/runtime/plugin/
fi

#if [ ! -d ~/.vim/bundle/Vundle.vim ];then
#    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#    if [ -f $DOTFILE/.vimrc.linux ];then
#        cp -rf $DOTFILE/.vimrc.linux ~/.vimrc
#    fi
#fi

## oh-my-zsh
if [ ! -d $PLUGIN/oh-my-zsh ];then
    git clone https://github.com/robbyrussell/oh-my-zsh $PLUGIN/oh-my-zsh
fi

## cheat-sheet
#if [ -f $PLUGIN/oh-my-zsh/templates/zshrc.zsh-template ];then
#    cheat-sheet () { zle -M "`cat ~/dotfiles/.zsh/cheat-sheet`" }
#    zle -N cheat-sheet
#    # bindkey "^[^h" cheat-sheet
#fi

## golang
#if [ ! -f ~/dotfiles/.zsh/plugin/golang-crosscompile/crosscompile.bash ];then
#    git clone https://github.com/davecheney/golang-crosscompile ~/dotfiles/.zsh/plugin/golang-crosscompile
#fi

## growl
if [ ! -f $PLUGIN/growl.zsh ];then
    cp -rf $DOTFILE/script/growl.zsh $PLUGIN/growl.zsh
fi

if [ ! -f $PLUGIN/notify-command.zsh ];then
    curl https://gist.githubusercontent.com/syui/3ebfbfa38a775f23ffef/raw/notify-command.zsh -o $PLUGIN/notify-command.zsh
    chmod +x $PLUGIN/notify-command.zsh
fi

## rupa/z
        if [ ! -d ~/dotfiles/.zsh/plugin/z ];then
            git clone https://github.com/rupa/z ~/dotfiles/.zsh/plugin/z
        fi
        . ~/dotfiles/.zsh/plugin/z/z.sh

## zaw/zaw
if [ ! -d ~/dotfiles/.zsh/plugin/zaw ];then
    git clone https://github.com/zsh-users/zaw ~/dotfiles/.zsh/plugin/zaw
fi

## syui/airchrome.zsh
if [ ! -f $PLUGIN/airchrome.zsh/airchrome.zsh ];then
    git clone https://github.com/syui/airchrome.zsh $PLUGIN/airchrome.zsh
fi

## syntax-highlight
if [ ! -f $HOME/dotfiles/.zsh/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ];then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/dotfiles/.zsh/plugin/zsh-syntax-highlighting
fi

## commandline-fu
#if [ ! -d $DOTFILE/bin/fu ];then
#    git clone https://github.com/samirahmed/fu $DOTFILE/bin/fu
#fi
### }}}

### yaourt
#        #if ! which pacaur > /dev/null 2>&1;then
#        #    yaourt -S --noconfirm pacaur
#        #fi
#        if ! which pasystray > /dev/null 2>&1;then
#            yaourt -S --noconfirm pasystray-git 
#        fi
#        if [ ! -f /usr/share/fonts/OTF/ipaexg.ttf ];then
#            yaourt -S --noconfirm otf-ipaexfont
#        fi
#        if ! which notify-send.sh > /dev/null 2>&1;then
#            yaourt -S --noconfirm notify-send.sh
#        fi

# C-f
if [ ! -d ~/.qfcz ];then
	git clone https://github.com/syui/qfcz $HOME/.qfcz
fi

if [ ! -f ~/.local/share/fonts/Ricomoon.ttf ];then
	git clone https://github.com/syui/ricomoon ~/.local/share/fonts/ricomoon
	cp ~/.local/share/fonts/ricomoon/fonts/Ricomoon.ttf ~/.local/share/fonts
	fc-cache -fv
fi

