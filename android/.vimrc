set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
" git repos on your local machine (i.e. when working on your own plugin)
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Avoid a name conflict with L9


Plugin 'Lokaltog/vim-easymotion'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" vim-easymotion {{{
        " EasyMotion Config {{{
        let g:EasyMotion_do_mapping = 0
        " let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTZXCVBASDGJF'
        let g:EasyMotion_keys = 'jkf.,hklyuiopnmqwertzxcvbasdg'
        " Do not shade
        let g:EasyMotion_do_shade = 0
        " Use upper case
        let g:EasyMotion_use_upper = 1
        " Smartcase
        let g:EasyMotion_smartcase = 1
        " Smartsign
        let g:EasyMotion_use_smartsign_us = 1
        " keep cursor column
        let g:EasyMotion_startofline = 0
        " Don't skip folded line
        let g:EasyMotion_skipfoldedline = 0
        " pseudo-migemo
        let g:EasyMotion_use_migemo = 1
        " Jump to first with enter & space
        " let g:EasyMotion_enter_jump_first = 1
        let g:EasyMotion_space_jump_first = 1
        " Prompt
        let g:EasyMotion_prompt = '{n}> '
        " Highlight cursor
        " let g:EasyMotion_cursor_highlight = 1
        "}}}

        " EasyMotion Regrex {{{
        let g:EasyMotion_re_line_anywhere = '\v' .
                    \  '(<.|^.)' . '|' .
                    \  '(.>|.$)' . '|' .
                    \  '(\s+\zs.)' . '|' .
                    \  '(\l)\zs(\u)' . '|' .
                    \  '(_\zs.)' . '|' .
                    \  '(#\zs.)'
        let g:EasyMotion_re_anywhere = '\v' .
                    \  '(<.|^)' . '|' .
                    \  '(.$)' . '|' .
                    \  '(\s+\zs.)' . '|' .
                    \  '(\l)\zs(\u)' . '|' .
                    \  '(_\zs.)' . '|' .
                    \  '(/\zs.)' . '|' .
                    \  '(#\zs.)'
        "}}}

    " EasyMotion Mapping {{{
    nmap s <Plug>(easymotion-s2)
    vmap s <Plug>(easymotion-s2)
    omap z <Plug>(easymotion-s2)
    nmap ms <Plug>(easymotion-s)
    vmap ms <Plug>(easymotion-s)
    omap mz <Plug>(easymotion-s)

    " Extend search
    "map  / <Plug>(easymotion-sn)
    "xmap / <Esc><Plug>(easymotion-sn)\v%V
    "omap / <Plug>(easymotion-tn)
    "noremap  ;/ /
    " nmap ;n <Plug>(easymotion-sn)<C-p>
    " map ;N <Plug>(easymotion-bd-n)

    set nohlsearch " use EasyMotion highlight
    "nmap n <Plug>(easymotion-next)<Plug>(anzu-update-search-status)zv
    "nmap N <Plug>(easymotion-prev)<Plug>(anzu-update-search-status)zv
    "xmap n <Plug>(easymotion-next)zv
    "xmap N <Plug>(easymotion-prev)zv

    " Replace defaut
    " smart f & F
    omap f <Plug>(easymotion-bd-fl)
    xmap f <Plug>(easymotion-bd-fl)
    omap F <Plug>(easymotion-Fl)
    xmap F <Plug>(easymotion-Fl)
    omap t <Plug>(easymotion-tl)
    xmap t <Plug>(easymotion-tl)
    omap T <Plug>(easymotion-Tl)
    xmap T <Plug>(easymotion-Tl)

    " Extend hjkl
    "map ;h <Plug>(easymotion-linebackward)
    "map ;j <Plug>(easymotion-j)
    "map ;k <Plug>(easymotion-k)
    "map ;l <Plug>(easymotion-lineforward)
    map mh <Plug>(easymotion-linebackward)
    map mj <Plug>(easymotion-j)
    map mk <Plug>(easymotion-k)
    map <Space> H<Plug>(easymotion-j)
    map <CR> 0<Plug>(easymotion-bd-wl)
    map ml <Plug>(easymotion-lineforward)

    " Anywhere!
    " map <Space><Space> <Plug>(easymotion-jumptoanywhere)

    " Repeat last motion
    " map ;<Space> <Plug>(easymotion-repeat)

    " move to next/previous last motion match
    "nmap <expr> <C-n> yankround#is_active() ?
    "            \ '<Plug>(yankround-next)' : '<Plug>(easymotion-next)'
    "nmap <expr> <C-p> yankround#is_active() ?
    "            \ '<Plug>(yankround-prev)' : '<Plug>(easymotion-prev)'
    xmap <C-n> <Plug>(easymotion-next)
    xmap <C-p> <Plug>(easymotion-prev)

    nmap <expr><Tab> EasyMotion#is_active() ?
                \ '<Plug>(easymotion-next)' : '<TAB>'
    nmap <expr>' EasyMotion#is_active() ?
                \ '<Plug>(easymotion-prev)' : "'"

    " Extene word motion
    map  mm  0<Plug>(easymotion-bd-wl)
    map  mw  <Plug>(easymotion-bd-wl)
    map  me  <Plug>(easymotion-bd-el)
    omap mb  <Plug>(easymotion-bl)
    " omap ;ge <Plug>(easymotion-gel)
    map mge <Plug>(easymotion-gel)

    function! s:wrap_M()
        let current_line = getline('.')
        keepjumps normal! M
        let middle_line = getline('.')
        if current_line == middle_line
            call EasyMotion#JK(0,2)
        endif
    endfunction
    nnoremap <silent> M :<C-u>call <SID>wrap_M()<CR>
    "}}}

    " EasyMotion User {{{
    " EasyMotion#User(pattern, is_visual, direction, is_inclusive)
    noremap  <silent><expr>;c
                \ ':<C-u>call EasyMotion#User(' .
                \ '"\\<' . expand('<cword>') . '\\>", 0, 2, 1)<CR>'
    xnoremap  <silent><expr>;c
                \ '<ESC>:<C-u>call EasyMotion#User(' .
                \ '"\\<' . expand('<cword>') . '\\>", 1, 2, 1)<CR>'

    let g:empattern = {}
    let g:empattern['syntax'] = '\v'
                \ . 'function|endfunction|return|call'
                \ . '|if|elseif|else|endif'
                \ . '|for|endfor'
                \ . '|while|endwhile'
                \ . '|break|continue'
                \ . '|let|unlet'
                \ . '|noremap|map|expr|silent'
                \ . '|g:|s:|b:|w:'
                \ . '|autoload|#|plugin'

    noremap  <silent>;1
                \ :<C-u>call EasyMotion#User(g:empattern.syntax , 0, 2, 1)<CR>
    xnoremap <silent>;1
                \ :<C-u>call EasyMotion#User(g:empattern.syntax , 1, 2, 1)<CR>
    "}}}

    function! EasyMotionMigemoToggle() "{{{
        if !exists(g:EasyMotion_use_migemo) && g:EasyMotion_use_migemo == 1
            let g:EasyMotion_use_migemo = 0
            echo 'Turn Off migemo'
        else
            let g:EasyMotion_use_migemo = 1
            echo 'Turn On migemo'
        endif
    endfunction
    command! -nargs=0 EasyMotionMigemoToggle :call EasyMotionMigemoToggle() "}}}
"}}}
