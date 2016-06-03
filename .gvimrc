call plug#begin('~/.vim/plugged')

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

source ~/dotfiles/.vimrc.bundle

call plug#end()

source ~/dotfiles/.vimrc.plug
source ~/dotfiles/.vimrc.start

set textwidth=0
set t_Co=256
set background=dark
set clipboard=unnamedplus
set clipboard+=unnamed,autoselect
set laststatus=2
set directory=~/.vim/swap
set undodir=~/.vim/undo
set undofile
set backupdir=~/.vim/tmp
set number
set foldmethod=marker
set foldmethod=syntax

colorscheme molokai

autocmd FileType text setlocal textwidth=0
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

let mapleader = ','
let g:molokai_original = 1
let g:Powerline_symbols = 'unicode'
let g:air_auto_write = 1
let g:air_auto_write_nosilent = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_do_shade = 0
let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_startofline = 0
let g:EasyMotion_skipfoldedline = 0
let g:EasyMotion_use_migemo = 1
let g:EasyMotion_space_jump_first = 1
let g:vimfiler_safe_mode_by_default=0
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_enable = 0
let g:unite_kind_jump_list_after_jump_scroll=0
let g:unite_enable_start_insert = 1
let g:unite_source_rec_min_cache_files = 1000
let g:unite_source_rec_max_cache_files = 5000
let g:unite_source_file_mru_long_limit = 6000
let g:unite_source_file_mru_limit = 500
let g:unite_source_directory_mru_long_limit = 6000
let g:unite_prompt = '❯ '
let g:unite_winheight = 25

imap <silent><C-j> <Esc>
vmap <silent> cy   c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vmap <silent> sx :Str2HtmlEntity<cr>
vmap <silent> sr :Entity2HtmlString<cr>
vmap v $h
vmap < <gv
vmap > >gv
vmap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>
vmap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>
nmap <silent> <Leader>o :OverCommandLine<CR>%s//g<Left><Left>
nmap <silent> <Leader>on :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
nmap <silent> <Leader>om y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>
nmap Q :q!<CR>
nmap vy vawy
nmap gb '[
nmap gp ']
nmap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nmap <silent> cy   ciW<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nmap f <Plug>(clever-f-f)
nmap F <Plug>(clever-f-F)
nmap m <Plug>(easymotion-sn)
nmap s <Plug>(easymotion-s2)
nmap <CR> H<Plug>(easymotion-j)
nmap <Space> <Plug>(easymotion-bd-wl)
nmap [unite] <Nop>
nmap <C-l> [unite]
nmap <silent> [unite]g :<C-u>Unite -silent -no-quit grep:.<CR>
nmap <silent> [unite]y :<C-u>Unite -silent history/yank<CR>
nmap <silent> [unite]b :<C-u>Unite -silent buffer file_mru bookmark<CR>
nmap <silent> [unite]m :<C-u>Unite -silent mapping<CR>
nmap <silent> <Leader>f :VimFilerBufferDir -split -simple -no-quit -winwidth=32<CR>
nmap <C-p> "*p<CR>
