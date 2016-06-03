### download {{{

#setting

if [ ! -d ~/.local/share/fonts ];then
	mkdir -p ~/.local/share/fonts
fi

if [ ! -f ~/.local/share/fonts/Ricomoon.ttf ];then
	git clone https://github.com/syui/ricomoon ~/.local/share/fonts/ricomoon
	cp ~/.local/share/fonts/ricomoon/fonts/Ricomoon.ttf ~/.local/share/fonts
	fc-cache -fv
fi

if [ ! -d ~/.vim/swap ];then
case $OSTYPE in
	darwin*)
		rm -r /Applications/.localized
		rm -f ~/Desktop/.localized
		rm -f ~/Downloads/.localized
		rm -f ~/Public/.localized
		rm -f ~/Music/.localized
		rm -f ~/Movies/.localized
		rm -f ~/Pictures/.localized
		rm -f ~/Library/.localized
		rm -f ~/Documents/.localized
		killall Finder
	;;
	linux*)
		echo "passwd=root"
	;;
esac
	mkdir -p ~/.vim/{undo,tmp,swap}
fi

case $OSTYPE in
	darwin*)
		if ! which brew > /dev/null 2>&1;then
			ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		fi
		if [ ! -f /usr/local/bin/zsh ];then
			brew tap Homebrew/brewdler
			cd $DOTFILE
			brew brewdle
		fi
		if [ ! -f /usr/local/bin/ssh ];then
			brew tap homebrew/dupes
			brew install openssh --with-brewed-openssl --with-keychain-support
		fi

	;;
esac

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
case $OSTYPE in
    linux*)
        if ! which go > /dev/null 2>&1;then
            sudo pacman -S go --noconfirm
        fi
        ;;
esac

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

# tmux-powerline {{{
if type tmux > /dev/null 2>&1;then
    if [ ! -d $DOTFILE/.tmux/tmux-powerline ];then
        TPOWERLINE=$DOTFILE/.tmux/tmux-powerline
        git clone https://github.com/syui/tmux-powerline $DOTFILE/.tmux/tmux-powerline
    fi
    if [ ! -d $DOTFILE/.tmux/tmux-colors-solarized ];then
        git clone https://github.com/seebi/tmux-colors-solarized $DOTFILE/.tmux/tmux-colors-solarized
    fi
fi
## tmux-powerline {{{
#if type tmux > /dev/null 2>&1;then
#    if [ ! -d $DOTFILE/.tmux/tmux-powerline ];then
#        TPOWERLINE=$DOTFILE/.tmux/tmux-powerline
#        git clone https://github.com/erikw/tmux-powerline $DOTFILE/.tmux/tmux-powerline
#    fi
#    if [ ! -d $DOTFILE/.tmux/tmux-colors-solarized ];then
#        git clone https://github.com/seebi/tmux-colors-solarized $DOTFILE/.tmux/tmux-colors-solarized
#    fi
#fi
#
#if [ ! -f $DOTFILE/.tmux/tmux-powerline/segments/used-mem ];then
#    curl https://raw.githubusercontent.com/yonchu/used-mem/master/used-mem -o $DOTFILE/.tmux/tmux-powerline/segments/used-mem
#    chmod +x $DOTFILE/.tmux/tmux-powerline/segments/used-mem
#fi
#
#if [ ! -f $DOTFILE/.tmux/.tmux.conf.mac ];then
#    curl https://raw.githubusercontent.com/syui/dotfiles/master/.tmux/.tmux.conf.mac -o $DOTFILE/.tmux/.tmux.conf.mac
#fi
#
#case $OSTYPE in
#    linux*)
#        if [ ! -f $DOTFILE/.tmux/tmux-powerline/config/tmux-powerline-config-defaults.sh ];then
#            curl https://raw.githubusercontent.com/syui/dotfiles/master/.tmux/defaults.sh -o $DOTFILE/.tmux/tmux-powerline/config/tmux-powerline-config-defaults.sh
#            bash -c "cp -f $DOTFILE/.tmux/tmux-powerline/config/tmux-powerline-config-defaults.sh $DOTFILE/.tmux/tmux-powerline/config/defaults.sh"
#        fi
#
#        if [ ! -f $DOTFILE/.tmux/tmux-powerline/themes/origin.sh ];then
#            curl https://raw.githubusercontent.com/syui/dotfiles/master/.tmux/origin.sh -o $DOTFILE/.tmux/tmux-powerline/themes/origin.sh
#        fi
#        ;;
#esac
### }}}

## vim
if [ ! -d ~/.vim/autoload/plug.vim ];then
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

#if [ ! -d ~/.vim/bundle/vimproc.vim ];then
# 	git clone https://github.com/Shougo/vimproc.vim.git ~/.vim/bundle/vimproc.vim
# 	cd ~/.vim/bundle/vimproc.vim
#	make
#fi

case $OSTYPE in
	darwin*)
		if [  -d /Applications/MacVim.app ];then
			cp -rf ~/.vim/bundle/vimproc.vim/autoload/ /Applications/MacVim.app/Contents/Resources/vim/runtime/autoload/ 
			cp -rf ~/.vim/bundle/vimproc.vim/plugin/ /Applications/MacVim.app/Contents/Resources/vim/runtime/plugin/
		fi
	;;
esac

#case $OSTYPE in
#    darwin*)
#        if [ ! -d ~/.vim/bundle/Vundle.vim ];then
#            git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#	    vim +BundleInstall +q
#    	fi
#        #if [ ! -d ~/.vim/bundle/neobundle.vim ];then
#        #    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
#        #    #vim +NeoBundleInstall +q
#        #fi
#        ;;
#    linux*)
#        if [ ! -d ~/.vim/bundle/Vundle.vim ];then
#            git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#            if [ -f $DOTFILE/.vimrc.linux ];then
#                cp -rf $DOTFILE/.vimrc.linux ~/.vimrc
#            fi
#        fi
#        ;;
#esac

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
case $OSTYPE in
    darwin*)
        if [ ! -f `brew --prefix`/etc/profile.d/z.sh ];then
            brew install z
        fi
        . `brew --prefix`/etc/profile.d/z.sh
        if [ ! -d $PLUGIN/z ];then
            git clone https://github.com/rupa/z ~/dotfiles/.zsh/plugin/z
        fi
        ;;
    linux*)
        if [ ! -d ~/dotfiles/.zsh/plugin/z ];then
            git clone https://github.com/rupa/z ~/dotfiles/.zsh/plugin/z
        fi
        . ~/dotfiles/.zsh/plugin/z/z.sh
        ;;
esac

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
#case $OSTYPE in
#    linux*)
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
#    ;;
#esac

# C-f
if [ ! -d ~/.qfcz ];then
	git clone https://github.com/syui/qfcz $HOME/.qfcz
fi
## numix-themes
#case $OSTYPE in
#    linux*)
#    if [ ! -d /usr/share/icons/Numix ];then
#        yaourt -S numix-icon-theme-git --noconfirm
#        #sudo rm -rf /usr/share/icons/Adwaita
#        #sudo cp -rf /usr/share/icons/Numix /usr/share/icons/Adwaita
#        #sudo cp -rf /usr/share/icons/Numix /usr/share/icons/gnome
#    fi
#    ;;
#esac
