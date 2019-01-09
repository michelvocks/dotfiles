"----------------------------------------------------------------------
" Variables & Settings
"----------------------------------------------------------------------
scriptencoding utf-8
set encoding=utf-8
set clipboard=unnamed
let g:vim_home_path = "~/.vim"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set number
set ruler
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set laststatus=2
set backspace=indent,eol,start
set autoread
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
set relativenumber

"----------------------------------------------------------------------
" Plugins
"----------------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(g:vim_home_path . "/plugged")
Plug 'fatih/vim-go'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'
call plug#end()

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdolgushin/groovy.vim'
Plugin 'posva/vim-vue'
call vundle#end()
filetype plugin indent on

"----------------------------------------------------------------------
" Key Mappings
"----------------------------------------------------------------------
map <C-o> :NERDTreeToggle<CR>
map <C-f> :FZF<CR>
map <C-r> :edit<CR>
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

"----------------------------------------------------------------------
" Auto highlighting for specific files
"----------------------------------------------------------------------
au BufRead,BufNewFile *.vue set filetype=vue.javascript.css
au BufWritePost *.go :GoBuild
