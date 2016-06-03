## vi-mode {{{
EMACS_INSERT=`bindkey -lL main | cut -d ' ' -f 3`
if bindkey -lL main | cut -d ' ' -f 3 | grep emacs > /dev/null 2>&1;then
    EMACS_INSERT="%K{black}%F{011}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{011}%F{034} % $EMACS_INSERT %k%f"
    VIM_INSERT="%K{011}%F{075}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{075}%F{026} % INSERT %k%f%K{075}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
else
    EMACS_INSERT="%K{black}%F{034}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{034}%F{011} % $EMACS_INSERT %k%f"
    VIM_INSERT="%K{034}%F{075}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{075}%F{026} % INSERT %k%f%K{075}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
fi
#VIM_INSERT="%K{034}%F{075}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{075}%F{026} % INSERT %k%f%K{075}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%%k%f"
RPROMPT="$EMACS_INSERT$VIM_INSERT"
function zle-keymap-select {
EMACS_INSERT=`bindkey -lL main | cut -d ' ' -f 3`
if echo $EMACS_INSERT | grep emacs > /dev/null 2>&1;then
    EMACS_INSERT="%K{black}%F{011}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{011}%F{034} % $EMACS_INSERT %k%f"
    VIM_NORMAL="%K{011}%F{125}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{125}%F{015} % NORMAL %k%f%K{125}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
    VIM_INSERT="%K{011}%F{075}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{075}%F{026} % INSERT %k%f%K{075}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
else
    EMACS_INSERT="%K{black}%F{034}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{034}%F{011} % $EMACS_INSERT %k%f"
    VIM_NORMAL="%K{034}%F{125}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{125}%F{015} % NORMAL %k%f%K{125}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
    VIM_INSERT="%K{034}%F{075}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{075}%F{026} % INSERT %k%f%K{075}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
fi
RPROMPT="$EMACS_INSERT${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
zle reset-prompt
}
zle -N zle-keymap-select

function airchrome-bindmode-emacs () {
bindkey -e
EMACS_INSERT=`bindkey -lL main | cut -d ' ' -f 3`
if echo $EMACS_INSERT | grep emacs > /dev/null 2>&1;then
    EMACS_INSERT="%K{black}%F{011}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{011}%F{034} % $EMACS_INSERT %k%f"
    VIM_NORMAL="%K{011}%F{125}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{125}%F{015} % NORMAL %k%f%K{125}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
    VIM_INSERT="%K{011}%F{075}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{075}%F{026} % INSERT %k%f%K{075}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
else
    EMACS_INSERT="%K{black}%F{011}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{011}%F{034} % $EMACS_INSERT %k%f"
    VIM_NORMAL="%K{011}%F{125}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{125}%F{015} % NORMAL %k%f%K{125}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
    VIM_INSERT="%K{011}%F{075}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{075}%F{026} % INSERT %k%f%K{075}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
fi
RPS1="$EMACS_INSERT${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
RPS2=$RPS1
zle reset-prompt
}
zle -N airchrome-bindmode-emacs
bindkey -v '^e' airchrome-bindmode-emacs
bindkey -a '^e' airchrome-bindmode-emacs

function airchrome-bindmode-vi () {
bindkey -v
EMACS_INSERT=`bindkey -lL main | cut -d ' ' -f 3`
if echo $EMACS_INSERT | grep emacs > /dev/null 2>&1;then
    EMACS_INSERT="%K{black}%F{011}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{011}%F{034} % $EMACS_INSERT %k%f"
    VIM_NORMAL="%K{011}%F{125}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{125}%F{015} % NORMAL %k%f%K{125}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
    VIM_INSERT="%K{011}%F{075}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{075}%F{026} % INSERT %k%f%K{075}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
else
    EMACS_INSERT="%K{black}%F{034}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{034}%F{011} % $EMACS_INSERT %k%f"
    VIM_NORMAL="%K{034}%F{125}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{125}%F{015} % NORMAL %k%f%K{125}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
    VIM_INSERT="%K{034}%F{075}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f%K{075}%F{026} % INSERT %k%f%K{075}%F{black}${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}%k%f"
fi
RPS1="$EMACS_INSERT${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
RPS2=$RPS1
zle reset-prompt
}
zle -N airchrome-bindmode-vi
bindkey -e '^v' airchrome-bindmode-vi
### }}}
