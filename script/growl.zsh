## zsh/growl integration: any command that takes longer than 5 seconds
## will trigger a growl notification when it completes.

if [ -f /usr/local/bin/terminal-notifier ] ; then
    preexec() {
        zsh_growl_cmd=$1
        zsh_growl_time=`date +%s`
    }

    precmd() {
        if (( $? == 0 )); then
            zsh_growl_status=done
        else
            zsh_growl_status=fail
        fi
        if [[ "${zsh_growl_cmd}" != "" ]]; then
            if (( `date +%s` - ${zsh_growl_time} > 5 )); then
                icon=~/dotfiles/Pictures/phoenix/phoenix_world.png
                if [ -f $icon ];then
                    terminal-notifier -message "${zsh_growl_cmd} ${zsh_growl_status}" -contentImage $icon
                else
                    terminal-notifier -message "${zsh_growl_cmd} ${zsh_growl_status}"
                fi
            fi
        fi
        zsh_growl_cmd=
    }
fi
