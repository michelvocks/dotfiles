"----------------------------------------------------------------------
" Variables & Settings
"----------------------------------------------------------------------
scriptencoding utf-8
set encoding=utf-8
set clipboard=unnamed
let g:vim_home_path = "~/.vim"

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
Plug 'maralla/completor.vim'
call plug#end()

"----------------------------------------------------------------------
" Completor Settings
"----------------------------------------------------------------------
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

"----------------------------------------------------------------------
" NerdTree Settings
"----------------------------------------------------------------------
map <C-o> :NERDTreeToggle<CR>
