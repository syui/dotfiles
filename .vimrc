" auto-reload
if exists("g:fff")
    set all&
    :normal <C-l>
endif
aug Reload
    au!
    nm <silent> <Space>s. :<C-u>source $MYVIMRC<CR>
    au! SourcePre $MYVIMRC let g:fff = &filetype
aug END
let &filetype = get(g:, 'fff', '')

" plug
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

let mapleader = ','

imap <silent><C-j> <Esc>
vmap <silent> cy c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vmap v $h
vmap < <gv
vmap > >gv
nmap Q :q!<CR>
nmap vy vawy
nmap gb '[
nmap gp ']
nmap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nmap <silent> cy ciW<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
