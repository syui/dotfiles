
hs=https://github.com
dd=dotfiles
ul=$hs/syui/$dd
if [ ! -d $dd ];then
    git clone $ul ~/$dd
fi
cd ~/$dd
dn=`zsh -c "ls -dA1 .*"`
for (( i=1; i<=`echo "${dn}" | wc -l`; i++ ))
do
    f=`echo "${dn}" | awk "NR==$i" | tr -d ' ' | grep -vw '.config' | grep -vw '.vim' | grep -vw '~/'`
    if [ "$f" != "~/" -a "$f" != "" ];then
        echo "ln -s ~/$dd/$f ~/$f"
        ln -s ~/$dd/$f ~/$f
        ln -sfn ~/$dd/.config ~/.config
    fi
done

case $OSTYPE in
    linux*)

        # font
        if [ ! -f ~/.config/fontconfig/font.conf ];then
            ln -s ~/dotfiles/.config/fontconfig/font.conf ~/.config/fontconfig/font.conf
        fi
        if [ ! -f ~/.gtkrc-2.0 ];then
            ln -s ~/dotfiles/.gtkrc-2.0 ~/.gtkrc-2.0
        fi
        if [ ! -d ~/.config/gtk-3.0 ];then
            ln -s ~/dotfiles/.config/gtk-3.0 ~/.config/gtk-3.0
        fi
        #if [ ! -f /etc/vconsole.conf ];then
        #    ln -s ~/dotfiles/etc/vconsole.conf /etc/vconsole.conf
        #fi
        ## xorg
        #xn=etc/X11/xorg.conf.d
        #cd ~/$dd/$xn
        #dn=`zsh -c "ls -dA1 *.conf"`
        #for (( i=1; i<=`echo "${dn}" | wc -l`; i++ ))
        #do
        #    f=`echo "${dn}" | awk "NR==$i"`
        #    echo "ln -s ~/$dd/$xn/$f /$xn/$f"
        #    sudo ln -s ~/$dd/$xn/$f /$xn/$f
        #done
        #xset dpms 0 0 0;xset s off
    ;;
esac

#echo -e 'default_user syui\nauto_login yes\ndaemon yes' >> /etc/slim.conf
#systemctl enable slim.service
#gtk-update-icon-cache -f /usr/share/icons/Numix
#rm -rf /usr/share/icons/Adwaita
#cp -rf /usr/share/icons/Numix /usr/share/icons/Adwaita
