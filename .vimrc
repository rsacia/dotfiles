set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle
call vundle#begin()
Plugin 'gmarik/Vundle'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

set history=1000
set undolevels=1000

set autoread
set hidden

let mapleader = ","
nmap <leader>a :A<cr>
nmap <leader>w :w!<cr>
nmap <leader>W :w !sudo tee %<cr>
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>eb :e ~/.bashrc<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

set ruler

set cmdheight=2

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

noremap <F12> <Esc>:syntax sync fromstart<cr>
inoremap <F12> <C-o>:syntax sync fromstart<cr>

set hlsearch
set incsearch

set showmatch
set mat=2

set noerrorbells
set novisualbell
set t_vb=
set tm=500

syntax enable

colorscheme desert
set background=dark

set encoding=utf8

set ffs=unix,dos,mac

set nobackup
set nowb
set noswapfile

set expandtab
set smarttab

set shiftwidth=4
set tabstop=4

set pastetoggle=<F2>

set lbr
set tw=500

set ai
set wrap

map j gj
map k gk
set so=7

set wildignore=*.o,*~,*.pyc

map <silent> <leader><cr> :noh<cr>

set number

map 0 ^

set laststatus=2
set statusline=\%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray
